/**
 * Update lead mock test class
 */
@isTest
global class SoapUpdateMock implements WebServiceMock {
    
    /**
     * 
     */
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) { 
        
        soapClassLeadDML1.updateLeadResponse_element responseElementInstance = 
            new soapClassLeadDML1.updateLeadResponse_element();
        responseElementInstance.result = new soapClassLeadDML1.SoapWrapLeadInformation();
        responseElementInstance.result.isSuccess = true;
        
        // Add the response element to the response parameter
        response.put('response_x', responseElementInstance); 
   }
}