**Using Static variables in Apex**

1. **Maintaining data across trigger invocations**
*   Let’s say you have a computationally intensive operation that you wish to perform in a number of different scenarios. For example, reassigning account ownership based on some rules a user has defined. You might want to do this after a field value has changed on the account, or any of its contacts or opportunities.

* It’s very common to move longer operations into future calls – asynchronous operations that can be queued by your code. Future calls execute at some indeterminate time in the future, but because the platform can schedule them based on server load,they are granted higher limits than other execution contexts, and are thus ideal for computationally intensive tasks. 

* You can only make up to **fifty future calls from an execution context**, and you can’t make a future call from a future context. Because your code may share an execution context with other code, ideally you only want to invoke your future call once. 

* So in this scenario, you wish to initiate your future call from a number of different triggers or conditions. How can you keep track of whether or not you have already initiated the call? The answer: use a static variable. 
But how do you use it? You can’t use it as a flag to indicate that a future call is required. That’s because in Apex you have no way of knowing that you are exiting an execution context. You can, however, use it as a flag to indicate that the call has already been made.

**Desing Pattern**

```
public class SomeFutureOperations {
    private static Boolean futureCallCalled = false;

    public static void doFutureCall() {
        if(futureCallCalled || System.isFuture()) return;

        futureCallCalled = true;
        actaulFutureCall();
    }

    @future
    private static void actualFutureCall() {
        //actual async code here
        
    }
}
```

2. **Caching Data**
* Consider the case where you have one or more triggers or methods, and the execution depends in some way on the user who triggered the execution. You might be storing different field values based on the user. Or you might be prohibiting certain operations, or performing additional operations based on the user. 
* In this scenario, let’s say you’ve added a custom field to the User object, call it UserIsSpecial__c, that controls these operations. You can retrieve the current value of this field using the following code:

```
User u = [Select UserIsSpecial__c from User 
          where ID = :UserInfo.getUserId()];
Boolean userIsSpecial = u.UserIsSpecial__c;
```

* If you were only using this value in one place in your code, this would be fine – you could just use the query as is. But if you intend to use this value across multiple methods and triggers, this approach could result in numerous SOQL operations (SOQL being the database query language for the Force.com platform). The number of allowed SOQL calls is limited within an Execution context – so you want to minimize those calls where possible. 

* The solution is to cache the value the first time it is used. Rather than try to anticipate where the first use will be (which can be tricky in a complex application), it’s best to centralize access of the variable by placing it in an Apex class as follows:


**Design Pattern**

```
public class ThinkingInApex {
    private static Boolean isUserSpecialChecked = false;
    private static Boolean userIsSpecial = false;

    public static Boolean isUserSpecial() {
        if(isUserSpecialChecked) return userIsSpecial;

        User u = [Select UserIsSpecial__c from User where ID = :UserInfo.getUserId()];
        Boolean userIsSpecial = u.UserIsSpecial__c;
        isUserSpecialChecked = true;
        return userIsSpecial;
    }
}
```

**Caveat to above design pattern**

* There is, however, one caveat to this approach. You can run into trouble if you try to cache large amounts of data. You see, there is also a limit to the size of memory heap you can use in an execution context! 
* If you need to work with larger amounts of data, you may need to requery each time you need the data instead of caching it. And if you are facing both limits – not enough heap space and not enough available SOQL operations, **you may need to defer the operation into an asynchronous call where you have higher limits.**

3. **Controlling Program Flow**
* Static variables are frequently used to modify the execution of a program. Consider the scenario where you wish to store on the account object the name and Email of the first contact. This can come in handy when doing account-based marketing, and a useful reference point in the event that the contact is later deleted (so it makes sense to store the information in individual fields rather than a lookup to the contact – which would be set to null if the contact was later deleted). 

* Create two fields on the account, First_Contact_Name__c and First_Contact_Email__c.  The application will use a trigger on the contact field which will call a method in our ThinkingInApex class.

**Design Pattern**

```
trigger OnContactInsert on Contact (after insert) {
    ThinkingInApex.afterInsertContact(trigger.new);
}

```

```
public class ThinkingInApex {
    public static void afterInsertContact(List<Contact> contacts){
        //Get all the account IDs for the Contacts

        Set<Id> accountIds = new Set<Id>();
        for (Contact ct : contacts){
            if(ct.AccountId != null){
                accountIds.add(ct.AccountId);
            }
        }

        // Only query those accounts for the contact that don't yet have Firs_Contact_Name set
        Map<Id,Account> accounts = new Map<Id,Account>([SELECT Id, First_Contact_Name__c, First_Contact_Email__c
                                                        FROM Account WHERE Id IN : accountIds 
                                                        AND First_Contact_Name__c = NULL]);
        if(accounts.size() == 0) return;
        for(Contact ct: contacts) {
            if(ct.accountId!=null)
            {
                Account act = accounts.get(ct.accountId);
                // Note, contact name property is not yet 
                // available in the after insert trigger
                act.First_Contact_Name__c = ((ct.FirstName!=null)?ct.FirstName + ' ':'') + ct.LastName;
                act.First_Contact_Email__c = ct.Email;
            }
        }
        update accounts.values();
    }
}
```

**Adding Exception Handling in above code**
```
try 
{
    update accounts.values();
} catch(Exception ex)
{
    // Code to report an error!
    system.debug('An exception occurred ' + ex.getMessage());
} 
```
The challenge with above code is – **how do you test it?** It’s easy enough to test the success case. The following test method from class TestThinkingInApex does the job.
 
