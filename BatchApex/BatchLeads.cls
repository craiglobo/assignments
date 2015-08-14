/**
 * Removal of duplicate Leads 
 * During the Campaigning, It might happen that representative creates duplicate leads in an org. 
 * So admin want to build a process which will run every 3 hours/day &  
 * remove the duplicate leads from the org. 
 * The criteria to find the duplicate records should be configurable. 
 */

global with sharing class BatchLeads implements Database.Batchable<sObject>, Database.Stateful {
    public Map<String,Lead> emailMap;
    public List<Lead> duplicateLeadsList;
    
    /**
     * Initialization of emailMap and duplicateLeadsList in constructor
     */
    public BatchLeads() {
         
         // Map to store unique leads on basis of email id; 
         // Email in key part, Lead record in value part
         emailMap = new Map<String,Lead>();
         
         // List to store Duplicated leads
         duplicateLeadsList = new List<Lead>(); 
         
    }
    
    /**
     * Query to fetch the Leads and get all lead which have email not null  
     */
    global Database.QueryLocator start(Database.BatchableContext BatchableContextInstance) {
        return Database.getQueryLocator([
            SELECT 
                Id, 
                Name, 
                Email
            FROM 
                Lead
            WHERE 
                Email <> null 
        ]);
    }
    
    
    /**
     * Sort the lead and add unique leads in map emailMap and 
     * the duplicate leads in the list duplicateLeadsList 
     */
    global void execute(Database.BatchableContext BatchableContextInstance, List<Lead> leadList) {
        for (Lead leadInstance : leadList) {
            
            //If key does not exist the excute > add the lead record in the emailMap
            if (!(emailMap.containskey(leadInstance.Email))) {
                emailMap.put(leadInstance.Email, leadInstance);
            } 
            
            // Key exist then excute > add the lead record in the duplicateLeadsList
            else {
                duplicateLeadsList.add(leadInstance);
            }
        }
        // Null check befor DML operation
        if(!duplicateLeadsList.isEmpty()) {
            delete duplicateLeadsList;
        }
    }

    /**
     * Print the final map with unique lead records with 
     * email address as key and lead record in value 
     */
    global void finish(Database.BatchableContext BatchableContextInstance) {
        System.debug(' Map of Unique Lead records : ' + emailMap);
    }
}

