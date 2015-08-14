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
private class BatchLeadTest {
    static List<Lead> leadList = new List<Lead>(); 
    static List<Lead> duplicateLeadList = new List<Lead>(); 
    static Lead  leadRecord;
    static Integer i = 0;
    
    /**
     * Create bulk data for lead  
     */
    static List<Lead> createLeadData() {
        
        // Creation of 200 lead records
        for(Integer j = 0; j < 200; j++) {
            leadRecord = new Lead(LastName = 'TestLead', Company = 'testCompanyLead',
                Status = 'Open - Not Contacted');
         leadList.add(leadRecord);
        }
        return leadList;
    }
    
    /**
     * Check the lead duplication with same records 
     */
    static testMethod void testDuplicateRecordsOfLead() {
        List <Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            leadObject.Email = 'abc@test.com';
            leadData.add(leadObject);
        }
        
        insert leadData;
        
        // New excution 
        Test.startTest();
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResults = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
            WHERE 
                Email = 'abc@test.com'
        ];
        
         // Check if there is 1 record  in the leadListResult list
        System.assertEquals(1,leadListResults.size());
    }
    
    /**
     * Check the lead duplication with different records 
     */ 
    static testMethod void testDifferentRecordsOfLead() {
        List <Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            i++;
            leadObject.Email = 'abc@test.com' + i;
            leadData.add(leadObject);
        }
        
        // Insertion of lead data
        insert leadInstance;
        for (Lead leadTest : [ 
            SELECT 
                LastName 
            FROM 
                Lead
            ]
        ) {
            System.debug(leadTest);
        }
        
        // New excution context
        Test.startTest();
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResult = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there are 200 records in the  leadListResult list
        System.assertEquals(200, leadListResult.size());
    }
}