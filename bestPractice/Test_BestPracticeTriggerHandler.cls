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
public class Test_BestPracticeTriggerHandler {
    static Integer i;
    
    // Check with valid data
    static testMethod void validDataCheck() {
        List<Account> accountListData = BestPracticeDataFactory.accountData();
        List<Contact> contactListData = BestPracticeDataFactory.contactData();
        
        // Acccount
        List<Account> accountList = new List<Account>();
        for (Account accountInstance : accountListData) {
            accountInstance.Website='www.gmail.com';
            accountList.add(accountInstance);
        }
        insert accountList;
        
        // Contact
        List<Contact> contactList = new List<Contact>();
        for (Contact contatcInstance : contactListData) {
            contatcInstance.Email='abc@gmail.com';
            contactList.add(contatcInstance);
        }
        
        // Checking the governor limits
        Test.startTest();
        insert contactList;
        Test.stopTest();
        
        List<Account> accountData = [
            SELECT
                Id 
            FROM 
                Account
        ];
         
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact 
        ]; 
        
        // Check the final result  ??????????????????????       ERROR
        for (i=0;i<200;i++) {
            System.assertEquals(accountData[i].Id, contactData[i].AccountId);
        }    
    }  
    
/////////////////////////////////////////////////////////////////////////////////////////////
    
    // Check with  blank account data  
    static testMethod void contactEmailDomainBlankCheck() {
        List<Account> accountListData = BestPracticeDataFactory.accountData();
        List<Contact> contactListData = BestPracticeDataFactory.contactData();
        
        // Acccount
        List<Account> accountList = new List<Account>();
        for (Account accountInstance : accountListData) {
            accountInstance.Website='www.gmail.com';
            accountList.add(accountInstance);
        }
        insert accountList;
        
        // Checking the governor limits
        Test.startTest();
        insert contactListData;
        Test.stopTest();
        
        /*
        List<Account> accountData = [
            SELECT
                Id 
            FROM 
                Account
        ];
        */ 
         
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact 
        ]; 
        
        // Check the final result
        for (i=0;i<200;i++) {
            System.assert(contactData[i].AccountId == NULL);
        }      
    }
    
 //////////////////////////////////////////////////////////////////////////////////////////////
    
    // Check with  blank contact data
    static testMethod void accountDomainBlankCheck() {
        List<Account> accountListData = BestPracticeDataFactory.accountData();
        List<Contact> contactListData = BestPracticeDataFactory.contactData();
        
        insert accountListData;
        
        // Contact
        List<Contact> contactList = new List<Contact>();
        for (Contact contatcInstance : contactListData) {
            contatcInstance.Email='abc@gmail.com';
            contactList.add(contatcInstance);
        }
        
        
        // Checking the governor limits
        Test.startTest();
        insert contactListData;
        Test.stopTest();
        
        
        List<Account> accountData = [
            SELECT
                Id 
            FROM 
                Account
        ];
         
         
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact 
        ]; 
        
        // Check the final result
        for (i=0;i<200;i++) {
            System.assert(contactData[i].AccountId == NULL);
        }      
    }
    

///////////////////////////////////////////////////////////////////////////////////////////////
    
    
    // Check with  blank account data and blank contact data
      static testMethod void accountDomainContactEmailDomainBlankCheck() {
        List<Account> accountListData = BestPracticeDataFactory.accountData();
        List<Contact> contactListData = BestPracticeDataFactory.contactData();
        
        // Checking the governor limits
        Test.startTest();
        insert contactListData;
        Test.stopTest();
        
        
        List<Account> accountData = [
            SELECT
                Id 
            FROM 
                Account
        ];
         
         
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact 
        ]; 
        
        // Check the final result
        for (i=0;i<200;i++) {
            System.assert(contactData[i].AccountId == NULL);
        }
    }
}