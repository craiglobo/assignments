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
private class DependentList_Test {
     public static testmethod void testCountry() {
         List<Country__c> countryList = new List<Country__c>();
         Country__c countryInstance1 = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Pakistan');
         countryList.add(countryInstance1);
         countryList.add(countryInstance2);
         countryList.add(countryInstance3);
        
         Test.startTest();
         insert countryList;
         Test.stopTest();
        
         DependentListController DependentListInstance = 
            new DependentListController();
         List<SelectOption> optionList = new List<SelectOption>();
         optionList = DependentListInstance.selectedCountry();
         System.assertEquals(3,optionList.size()); 
    }
  
  
    public static testmethod void testRelatedCity()
    {
         
         List<Country__c> countryList = new List<Country__c>();
         Country__c countryInstance1 = new Country__c(Name= 'India');
         Country__c countryInstance2 = new Country__c(Name= 'USA');
         Country__c countryInstance3 = new Country__c(Name= 'Mexico');
         countryList.add(countryInstance1);
         countryList.add(countryInstance2);
         countryList.add(countryInstance3);
         
         List<City__c> cityList = new List<City__c>();
          
         City__c firstCity = new City__c(Name= 'Banglore', Country__c='India');
         City__c secondCity = new City__c(Name= 'Pune', Country__c='India' );
         
         cityList.add(firstCity);
         cityList.add(secondCity);
         
         Test.startTest();
         insert countryList;
         insert cityList;
         Test.stopTest();
         
         DependentListController DependentListInstance = new DependentListController();
         DependentListInstance.selected = 'India';
         DependentListInstance.relatedCity();
         System.assertEquals(2, DependentListInstance.cityOptions.size());  
    }
}

    