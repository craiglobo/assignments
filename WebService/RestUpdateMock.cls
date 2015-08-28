/**
 * This is a mock test for REST API for update method
 */ 
global class RestUpdateMock implements HttpCalloutMock {
    
    /**
     * To return the response to the consumer org  
     */
    global HTTPResponse respond(HTTPRequest httpRequest) {
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setHeader('Content-Type', 'application/json');
        httpResponse.setStatusCode(200);
        httpResponse.setBody('{"message" : "success"}');
        return httpResponse;
    }
}