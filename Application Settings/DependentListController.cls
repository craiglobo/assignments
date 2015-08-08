public with sharing class DependentListController {
    
    public String selected{get;set;}
    public List<SelectOption> countryOptions{get;set;}
    public String option{get;set;}
    public List<selectOption> cityOptions{get;set;}
    public DependentListController() {
        selectedCountry();
    }
    public List<SelectOption> selectedCountry() {
        countryOptions = new List<SelectOption>();
        for (Country__c countryInstance : Country__c.getAll().Values()) {
            countryOptions.add(new SelectOption(countryInstance.Name,countryInstance.Name));
            
        }
        return countryOptions;
    }
    public void relatedCity() {
        cityOptions = new List<SelectOption>();
        for (City__c cityInstance : [SELECT Name FROM City__c 
                                            WHERE Country__c = :selected]) {
            cityOptions.add(new SelectOption(cityInstance.Name,cityInstance.Name));
        }
    }
}