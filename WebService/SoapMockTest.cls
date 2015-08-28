/**
 * 
 */
@isTest
private class SoapMockTest {
    
    /**
     *
     */
    @isTest
    static void insertLeadTest() {              
        // Generate a fake response for insert
        Test.setMock(WebServiceMock.class, new SoapInsertMock());
        
        //Create an instance of the class by wsdl.class
        soapClassLeadDML1.SoapLeadManipulation classInstance = 
            new soapClassLeadDML1.SoapLeadManipulation ();
        
        // Create the instance of wrapper class wsdl.wrapper
        soapClassLeadDML1.SoapWrapLeadInformation wrapperInstance = 
            new soapClassLeadDML1.SoapWrapLeadInformation ();
        
        wrapperInstance = classInstance.createLead(
            'test', 
            'test2', 
            'Open - Not Contacted', 
            'test.inc', 
            'demo@test.com', 
            '789654123'
        );
        
        // Verify if the lead is created by checking the wrapper isSuccess field
        System.assertEquals(true, wrapperInstance.isSuccess);
    }
    
    /**
     *
     */
    @istest
    static void updateLeadTest() { 
    
        // Generate a fake response for insert
        Test.setMock(WebServiceMock.class, new SoapUpdateMock());
        
        //Create an instance of the class by wsdl.class
        soapClassLeadDML1.SoapLeadManipulation  classInstance = 
            new soapClassLeadDML1.SoapLeadManipulation ();
        
        // Create the instance of wrapper class wsdl.wrapper
        soapClassLeadDML1.SoapWrapLeadInformation wrapperInstance = 
            new soapClassLeadDML1.SoapWrapLeadInformation ();
        
        wrapperInstance = classInstance.updateLead(
            'test', 
            'test2', 
            'demo@test.com', 
            '7896231454'
        );
        
        // Verify if the lead is created by checking the wrapper isSuccess field
        System.assertEquals(True, wrapperInstance.isSuccess);
    }
    
    /**
     *
     */
    @isTest
    static void deleteLeadTest() { 
        
        // Generate a fake response for insert
        Test.setMock(WebServiceMock.class, new SoapDeleteMock());
        
        //Create an instance of the class by wsdl.class
        soapClassLeadDML1.SoapLeadManipulation  classInstance = 
            new soapClassLeadDML1.SoapLeadManipulation ();
        
        // Create the instance of wrapper class wsdl.wrapper
        soapClassLeadDML1.SoapWrapLeadInformation  wrapperInstance = 
            new soapClassLeadDML1.SoapWrapLeadInformation ();
        
        wrapperInstance = classInstance.deleteLead(
            'test', 
            'test2', 
            'demo@test.com', 
            '7896231454'
        );
        
        // Verify if the lead is deleted by checking the wrapper isSuccess field
        System.assertEquals(True, wrapperInstance.isSuccess);
    }
    
}