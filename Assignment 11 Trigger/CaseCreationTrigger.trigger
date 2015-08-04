/**Trigger for Updating Cases that come in from the Web, Email or Chat
  *Use Case – we would like to use the email address of the incoming case to see 
  *if we can associate the correct person account to populate the Account and Contact Fields.
  *When a new case is created and the Case.Origin field is set to “Chat” or “Email” or “Web” 
  *take the Case.SuppliedEmail field and look up to find a match in the following 
  *account fields – Account.PersonEmail, Account.Email_Address__c
  */

// Trigger on case object after insert of account record
trigger CaseCreationTrigger on Case (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // Sent the inserted record to the handler class constructor
            CaseCreationHandler caseHandlerInstance = new CaseCreationHandler(Trigger.new);
       }
    }
}