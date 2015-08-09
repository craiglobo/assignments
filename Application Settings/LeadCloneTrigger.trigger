/**
 * Write a Trigger on  Lead which will create the clone record.
 */

trigger LeadCloneTrigger on Lead(after insert) {
    TriggerSetting__c disableTriggerInstance = TriggerSetting__c.getInstance();
    if (disableTriggerInstance.DisableTrigger__c == false) {
        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                
				// Pass the inserted values to the handler class constructor
                LeadCloneHandler LeadHandlerInstance = new LeadCloneHandler(Trigger.new);
            }
        }
    }
}