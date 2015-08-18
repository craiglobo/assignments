/**
 * Controller class to get the field from the page 
 * on which the deletion has to be performed
 */
public with sharing class BatchLeadsController {
    public String selectedField {get; set;}
    
    /**
     * Call the custom settings to get the records in the constructor
     */
    
    /**
     * Get The configurable fields from the custom settings
     */
    public List<SelectOption> displayFields {
        get {
            displayFields = new List<SelectOption>();
            for (DuplicateLeads__c leadInstance_c : DuplicateLeads__c.getAll().Values()) {
                displayFields.add(new SelectOption(leadInstance_c.Name, leadInstance_c.Name));
            }
            return displayFields;
        }
        set;
    }
    
    /**
     * Call the batch and delete the duplicate leads 
     */
    public void startLeadDeletionBatch() {
        BatchLeads batchLeadsInstance = new BatchLeads(selectedField);
        Database.executeBatch(batchLeadsInstance);
    }
}