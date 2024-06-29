public class ThinkingInApex {
    @testvisible
    private static Boolean fakeAccountInsertionException = false;
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
        try 
        {
            if(fakeAccountInsertionException) 
                accounts.values().get(0).First_Contact_Email__c = 'hello';
            update accounts.values();
        }catch(Exception ex){
            System.debug('ThinkingInApex.afterInsertContact Exception: ' + ex.getMessage());
        }
    }
}