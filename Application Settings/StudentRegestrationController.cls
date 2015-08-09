public with sharing class StudentRegestrationController {
    public Student__c studentInstance{ get; set; }
    public String languageOption{ get; set; }
    public List<SelectOption> allLanguage;
    List<SelectOption> listLanguageInstance = new List<SelectOption>();
    
    // Creating an instance in constructor
    public StudentRegestrationController(ApexPages.StandardController StandardControllerExtension) {
        studentInstance = (Student__c) StandardControllerExtension.getRecord();

    }
    
    // Add the languages to the picklist     
    public List<SelectOption> getallLanguage() {
        /*
        // Getting all the countries in the pick list
        List<String> a = Language__c.getAll().Values();
        for (Integer i=0; i<=a.size();i++) {
            
        }*/listLanguageInstance.add(new SelectOption('','--Select Language--'));
        

          //listLanguageInstance.add(new SelectOption('',''));
        for (Language__c languageInstance : Language__c.getAll().Values()) {
            listLanguageInstance.add(new SelectOption(languageInstance.Code__c,languageInstance.Name));
        }
        return listLanguageInstance;
    
    } 
    
    // Insert the record
    public PageReference saveRecord() {
        if (studentInstance == null) {
            insert studentInstance;
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.INFO, 
                System.Label.Message
            ));
        }
        return null;
        
    }
}