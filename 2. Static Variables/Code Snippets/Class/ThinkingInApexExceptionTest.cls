@istest
public with sharing class ThinkingInApexExceptionTest {
    @istest
    public static void TestSetFirstContactNameException() {
        List<Account> accounts = new List<Account>{new Account(name='a1'), new Account(name='a2')};
            insert accounts;
        test.startTest();
        
        
        ThinkingInApex.fakeAccountInsertionException = true;
        
        List<Contact> contacts = new List<Contact>{new Contact(LastName='c1',Email='c1@c1.com', AccountId = accounts[0].id), 
                new Contact(LastName='c2',Email='c2@c2.com', AccountId = accounts[1].id)};
                    insert contacts;
        
        
        
        test.StopTest();
        
        Map<ID,Account> actResults = new Map<ID, Account>([Select ID, First_Contact_Name__c,First_Contact_Email__c from Account]);
        
        // Verify the accounts for each contact
        for(Contact ct: contacts)
        {
            Account actToTest = actResults.get(ct.accountId); 
            // We only used the last name in this test
            system.assertNotEquals(ct.LastName, actToTest.First_Contact_Name__c);
            system.assertNotEquals(ct.Email, actToTest.First_Contact_Email__c); 
        }
    }
}