public with sharing class StudentRegestrationController {
    public Student__c studentInstance{get;set;}
    public String languageOption{get;set;}
    public List<SelectOption> language;
    
    // Creating an instance in constructor
    public StudentRegestrationController(ApexPages.StandardController StandardControllerExtension) {
        studentInstance = (Student__c)StandardControllerExtension.getRecord();
    }
    
    // Add the languages to the picklist     
    public List<SelectOption> getlanguage() {
        List<SelectOption> listLanguageInstance = new List<SelectOption>();
        listLanguageInstance.add(new SelectOption('en_US','English'));
        listLanguageInstance.add(new SelectOption('fr','French'));
        listLanguageInstance.add(new SelectOption('es','Spanish'));
        return listLanguageInstance;
    }
    
    // Insert the record
    public PageReference saveRecord() {
        insert studentInstance;
        ApexPages.addMessage(new ApexPages.Message
            (ApexPages.Severity.INFO, System.Label.Message));
        return Null;
        
    }
}
