/**
 * Create a Visual Force page. 
 * This page should display two picklists, one for Country and another for City. 
 * Initially city picklist should not display any value; 
 * instead it should be dependent upon Country picklist. 
 * So when user selects a particular country 
 * then City picklist should load all the cities corresponding to the selected country.
 */
 
public with sharing class DependentListController {
    public String countrySelected { get; set; }
    public List<SelectOption> countryOptions{ get; set; }
    public String option{ get; set; }
    public List<selectOption> cityOptions{ get; set; }
    
    // Calling the selectCpountry() to show all the countries
    public DependentListController() {
        selectCountry();
    }
    
    // Get all countries 
    public List<SelectOption> selectCountry() {
        countryOptions = new List<SelectOption>();
        
        // Getting all the countries in the pick list
        for (Country__c countryInstance : Country__c.getAll().Values()) {
            countryOptions.add(new SelectOption(countryInstance.Name, countryInstance.Name));
        }
        return countryOptions;
    }
    
    // Get the related cities of selected country
    public void relatedCity() {
        cityOptions = new List<SelectOption>();
        
        // Query on City to get related cities
        for (City__c cityInstance : [
                SELECT 
                    Name 
                FROM 
                    City__c 
                WHERE 
                    Country__c = :countrySelected
            ]) {
            cityOptions.add(new SelectOption(cityInstance.Name, cityInstance.Name));
        }
    }
}