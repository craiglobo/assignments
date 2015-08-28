@istest
private class RestMockTest {
	
    /**
     * Check the lead insert
     */
    static testmethod void insertLeadTest() {
        Test.setMock(HttpCalloutMock.class, new RestInsertMock());
        RestLogin restInstance = new RestLogin();
        HttpResponse httpResponse = restInstance.createLead();
        String contentType = httpResponse.getHeader('Content-Type');
        
        // Verify if the content type is as desired
        System.assert(contentType == 'application/json');
        
        String actualBody = httpResponse.getBody();
        String expectedBody = '{"message" : "success"}';
        
        // Verify if the body is received as desired
        System.assertEquals(expectedBody, actualBody);
        
        // Verify is the response status is as desired
        System.assertEquals(200, httpResponse.getStatusCode());
    }
    
    /**
     * Check the lead delete
     */
    static testmethod void deleteLeadTest() {
        Test.setMock(HttpCalloutMock.class, new RestDeleteMock());
       	RestLogin restInstance = new RestLogin();
        HttpResponse httpResponse = restInstance.deleteLead();
        String contentType = httpResponse.getHeader('Content-Type');
        
        // Verify if the content type is as desired
        System.assert(contentType == 'application/json');
        String actualBody = httpResponse.getBody();
        String expectedBody = '{"message" : "success"}';
        
        // Verify if the body is received as desired
        System.assertEquals(expectedBody, actualBody);
        
        // Verify is the response status is as desired
        System.assertEquals(200, httpResponse.getStatusCode());
    }
    
    /**
     * Check the lead update
     */
    static testmethod void updateLeadtest(){
        Test.setMock(HttpCalloutMock.class, new RestUpdateMock());
        RestLogin restInstance = new RestLogin();
        HttpResponse httpResponse = restInstance.updateLead();
        String contentType = httpResponse.getHeader('Content-Type');
        
        // Verify if the content type is as desired
        System.assert(contentType == 'application/json');
        String actualBody = httpResponse.getBody();
        String expectedBody = '{"message" : "success"}';
        
        // Verify if the body is received as desired
        System.assertEquals(expectedBody, actualBody);
        
        // Verify is the response status is as desired
        System.assertEquals(200, httpResponse.getStatusCode());
    }
    
}