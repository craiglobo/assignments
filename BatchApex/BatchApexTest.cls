/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class BatchApexTest {
    
    /**
     * Test the opportunity mail
     */
    static testMethod void testOpportunityMail() {
        List<Account> accountList = new List<Account>();
        List<Opportunity> opportunityList = new List<Opportunity>();
        for(Integer i = 0; i < 5; i++) {
            accountList.add(new Account(Primary_Email__c = 'craig' + i + '@eternussolutions.com',
                Name = ''+i, Email_Address__c = 'test' + i + '@eternussolutions.com'));
        }

        insert accountList;
        for(Integer i = 0; i < 5; i++) {
            opportunityList.add(new Opportunity(Amount = 5, StageName = 'Closed Won',
                Name = 'Closed Opportunity '+ i, CloseDate = (Date)Date.today(),
                AccountId = accountList[i].Id)); 
        }
        
        opportunityList.add(new Opportunity(Amount = 12, StageName = 'Closed Won',
            Name = 'TestOpportunity', CloseDate = (Date) Date.today(), 
            AccountId = accountList[0].Id));
        
        insert opportunityList; 
        
        
        // New excution context
        Test.startTest();
        BatchApex batchInstance = new BatchApex();
        Database.executeBatch(batchInstance);
        Test.stopTest();
        
        // Check
        //System.assert();
    }
}
