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
public class StudentRegestration_Test {
    static ApexPages.StandardController StandardControllerExtension = new ApexPages.StandardController(new Student__c());
    public static testMethod void testSave() {
        Student__c studentInstance = new Student__c(Name = 'test');
        insert studentInstance;
        StudentRegestrationController studentControllerInstance = 
            new StudentRegestrationController(StandardControllerExtension);
        studentControllerInstance.saveRecord();
        List<Student__c> studentList = new List<Student__c>();
        studentList = [
            SELECT 
                id 
            FROM 
                Student__c 
            WHERE 
                Name = 'test'
        ];
        System.assertEquals(1,studentList.size());
    }
    
    public static testMethod void getlanguage() {
        StudentRegestrationController studentControllerInstance = 
            new StudentRegestrationController(StandardControllerExtension);
        List<SelectOption> optionList = new List<SelectOption>();
        optionList = studentControllerInstance.getlanguage();
        System.assertEquals(3,optionList.size()); 
    }
}