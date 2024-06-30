/**
 * @author : Sucharita
 * @description : Consider the scenario where you want to query a set of contacts and, as part of the functionality, 
 * make sure that if any of those contacts belongs to an account, the account has an AnnualRevenue forecast set.
*/


public without sharing class LimitSOQL {

    // Approach 1: Listing accountIds corresponding to Contacts, and query those accounts again
    public void approach1() {
        Set<Id> accountIds = new Set<Id>();
        List<Contact> conList = [SELECT Id, AccountId FROM Contact WHERE AccountId != null];

        if (conList.size() > 0) {
            for (Contact con : conList) {
                accountIds.add(con.AccountId);
            }
        }

        if (accountIds.size() > 0) {
            List<Account> accounts = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :accountIds];
            for (Account accountFound : accounts) {
                if (accountFound.AnnualRevenue == null) {
                    accountFound.AnnualRevenue = 500;
                }
            }
            update accounts;
        }
    }

    // Approach 2: Use only one SOQL to update related accounts
    //This second approach uses about the same amount of memory and CPU time as the first, but only requires one SOQL statement.

    public void approach2() {
        List<Contact> contactsToUpdate = [SELECT Id, Account.AnnualRevenue FROM Contact WHERE Account.AnnualRevenue = null];

        Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
        for (Contact ct : contactsToUpdate) {
            if (ct.Account != null && ct.Account.AnnualRevenue == null) {
                ct.Account.AnnualRevenue = 500;
                accountsToUpdate.put(ct.Account.Id, ct.Account);
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate.values();
        }
    }
}
