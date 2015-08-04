/**
  *Trigger for Updating Cases that come in from the Web, Email or Chat
  *Use Case – we would like to use the email address of the incoming case to see if we can associate 
  *the correct person account to populate the Account and Contact Fields.
  *When a new case is created and the Case.Origin field is set to “Chat” or “Email” or “Web” take the Case.
  *SuppliedEmail field and look up to find a match in the following account fields – Account.PersonEmail, Account.Email_Address__c
  */

public with sharing class CaseCreationHandler {
    public CaseCreationHandler(List<Case> caseParameter ) {
        List<Case> caseList = new List<Case>();
        List<Account> accountList=[SELECT a.Id, a.Person_Email__c, a.Email_Address__c , 
                                    (SELECT Id FROM Contacts) 
                                    FROM Account a 
                                    WHERE a.Id 
                                    IN 
                                    (SELECT AccountId FROM Contact)];
        for (Case caseInstance : caseParameter) {
            for (Account accountInstance : accountList) {
                if (caseInstance.Origin == 'Chat' || caseInstance.Origin == 'Email' || 
                    caseInstance.Origin == 'Web') {
                        if (caseInstance.Supplied_Email__c == accountInstance.Person_Email__c || 
                            caseInstance.Supplied_Email__c == accountInstance.Email_Address__c) {
                                System.debug(caseInstance.Supplied_Email__c + 'And the Id is' + 
                                accountInstance.Id);
                                caseInstance.AccountId=accountInstance.Id;
                    }
                }
            }
        }
    } 
}