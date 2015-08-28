/**
 *
 */
global class SoapLogin {
 
    /**
     * Insert a lead
     */
    public void insertLead() {
        
        // Partner WSDL instance
        partnerSoapSforceCom.Soap soapPartnerInstance = new partnerSoapSforceCom.Soap();
        
        // Username and password with token appended
        partnerSoapSforceCom.LoginResult loginResultInstance = 
            soapPartnerInstance.login(
                'craig.lobo7@eternussolutions.com', 
                'eternus@1234vbw4rulTBavtzlfeX580PLbSD'
            );
            
        // WSDL Class . org1Class Instance
        soapClassLeadDML1.SoapleadManipulation leadManipulationInstance = 
            new soapClassLeadDML1.SoapleadManipulation();
        
        // Getting the session header
        leadManipulationInstance.SessionHeader   = 
            new soapClassLeadDML1.SessionHeader_element();
        
        // Getting the sessionId from the login result
        leadManipulationInstance.SessionHeader.sessionID = loginResultInstance.SessionID;
        
        leadManipulationInstance.createLead(
            'Soap', 
            'Test', 
            'Open - Not Contacted', 
            'Test.inc', 
            'test@soap.com', 
            '9874563210'
        );
    }
        
    /**
     * Delete a lead
     */
    public void deleteLead() {
       
        // Partner WSDL instance
        partnerSoapSforceCom.Soap soapPartnerInstance = new partnerSoapSforceCom.Soap();
        
        // Username and password with token appended
        partnerSoapSforceCom.LoginResult loginResultInstance = 
            soapPartnerInstance.login(
                'craig.lobo7@eternussolutions.com', 
                'eternus@1234vbw4rulTBavtzlfeX580PLbSD'
            );
        
        // WSDL Class . org1Class Instance
        soapClassLeadDML1.SoapleadManipulation leadManipulationInstance = 
            new soapClassLeadDML1.SoapleadManipulation();
        
        // Getting the session header
        leadManipulationInstance.SessionHeader   = 
            new soapClassLeadDML1.SessionHeader_element();
        
        // Getting the sessionId from the login result
        leadManipulationInstance.SessionHeader.sessionID = loginResultInstance.SessionID;
    
        leadManipulationInstance.deleteLead('Soap', 'Test', 'test@soap.com', '9874563210');
    }
    
    /**
     * Update a lead
     */    
    public void updateLead() {
    
        // Partner WSDL instance
        partnerSoapSforceCom.Soap soapPartnerInstance = new partnerSoapSforceCom.Soap();
        
        // Username and password with token appended
        partnerSoapSforceCom.LoginResult loginResultInstance = 
            soapPartnerInstance.login(
                'craig.lobo7@eternussolutions.com', 
                'eternus@1234vbw4rulTBavtzlfeX580PLbSD'
            );
        
        // WSDL Class . org1Class Instance
        soapClassLeadDML1.SoapleadManipulation leadManipulationInstance = 
            new soapClassLeadDML1.SoapleadManipulation();
        
        // Getting the session header
        leadManipulationInstance.SessionHeader   = 
            new soapClassLeadDML1.SessionHeader_element(); 
        
        // Getting the sessionId from the login result
        leadManipulationInstance.SessionHeader.sessionID = loginResultInstance.SessionID;
        
        leadManipulationInstance.updateLead(
            'Soap', 
            'Test',
            'soap@test.com', 
            '9632587410'
        ); 
    }     
}