/**
 * Collection of Closed Won Opportunities 
 * The Primary contact associated with an account needs to know which all are the 
 * closed won opportunities for his account per day. 
 * Create a process which will run everyday in the midnight & collect all the 
 * Closed won opportunities of that account in a day & send an email to Primary Contact. 
 * The email body should contain the Opportunity Name & it's respective amount 
 * with the aggregated amount in the end. 
 */
global with sharing class BatchApex implements Database.Batchable<Sobject>, Database.Stateful, 
    Schedulable {
    map<String,WrapperClass> accountOpportunityMap;
    public BatchApex() {
        accountOpportunityMap = new Map<String,WrapperClass>();
    }
    
    /**
     * Wrapper class with opportunity and sum
     */
    public class WrapperClass {
         List<Opportunity> opportunityList;
         Double sum;
         
        /**
         *Constructor to initialize the warpper class variables
         */
        public WrapperClass() {
            opportunityList = new List<Opportunity>();
            sum = 0;
        }
    }
    
    /**
     * Get all opportunities whos lookup field to account is not blank 
     * and email field on Account object is not blank
     */
    global Database.QueryLocator start(Database.BatchableContext batchableContext) {
            return Database.getQueryLocator([
                SELECT 
                    Id, 
                    Name, 
                    Amount, 
                    StageName, 
                    Opportunity.Account.Email_Address__c, 
                    AccountId 
                FROM 
                    Opportunity 
                WHERE 
                    AccountId <> null 
                AND 
                    Opportunity.Account.Email_Address__c <> null
            ]);
    }
    
    /**
     * This will sum up all the closed won opportunities of a perticular account per day
     * and will send a mail to the primary contact
     */
    global void execute(Database.BatchableContext batchableContext,
         List<Opportunity> opportunityparameter) {
        for(Opportunity opportunityInstance : opportunityparameter) {
            if(accountOpportunityMap.containsKey(opportunityInstance.Account.Email_Address__c)) {
                WrapperClass wrapperInstance = accountOpportunityMap.get(
                    opportunityInstance.Account.Email_Address__c);
                
                // Add the opportunity in the opportunity list in the wrapper class
                wrapperInstance.opportunityList.add(opportunityInstance);
                
                // Add the amount of that opportunity which is inserted in the opportunity list 
                // in the sum variable in the wrapper class
                wrapperInstance.sum += opportunityInstance.Amount;
                accountOpportunityMap.put(
                    opportunityInstance.Account.Email_Address__c, wrapperInstance);
            }
            else {
                wrapperClass wrapperInstance = new wrapperClass();
                wrapperInstance.opportunityList.add(opportunityInstance);
                wrapperInstance.sum = opportunityInstance.Amount;
                accountOpportunityMap.put
                    (opportunityInstance.Account.Email_Address__c, wrapperInstance);
            }
        }
    }
     
      global void execute(SchedulableContext schedulableContext) {
          
      }
     
     /**
      * The finish block to send mail to primary contact of all opportunities 
      * with the with their ammount
      */
    global void finish(Database.BatchableContext batchableContext) {
        List<Messaging.SingleEmailMessage> mailInstance = new List<Messaging.SingleEmailMessage>();
        List<String> sendTo = new List<String>();
        for(String emailInstance : accountOpportunityMap.keySet()) {
            Messaging.SingleEmailMessage individualMail = new Messaging.SingleEmailMessage();
            WrapperClass wrapperInstance = accountOpportunityMap.get(emailInstance);
            
            // Recipient email id
            sendTo.add('craig.lobo@eternussolutions.com');
            individualMail.setToAddresses(sendTo);
            individualMail.setSenderDisplayName('SalesForce.com');
            individualMail.setSubject('List Of Opportunities and Amount');
            String body = 'Hello ' + IndividualMail;
            body += ' Opportunities associated to your'; 
            body += ' account and the aggregate of their amount';
            body += ' ' + wrapperInstance.opportunityList + ' ' + wrapperInstance.sum;
            for (Opportunity opportunityInstance : wrapperInstance.opportunityList) {
                body += '\n' + opportunityInstance.Name + ' ' + opportunityInstance.Amount;
            }
            body += '\n ' +wrapperInstance.sum;
            individualMail.setHtmlBody(body);
            mailInstance.add(individualMail); 
        }
        Messaging.sendEmail(mailInstance);
    }
}

