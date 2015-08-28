/**
 * Rest API
 */
public class RestLogin {
    
    /**
     *  Get the Response for the access token
     */
    public static WrapperResponseOAuth loginMethod() {
        String userName = 'craig.lobo7@eternussolutions.com';
        String password = 'eternus@1234';
        String clientId = '3MVG9ZL0ppGP5UrDlJlXJsYZuRvxJLOCtGpRR.CJ44iQrDVON48QKCJUN3vLlqtC8etDE3lAm8iBWu2jFSKYn';
        String clientSecret = '4608373958018150483';
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token'); 
        request.setBody(
            'grant_type=password' + 
            '&client_id=' + clientId + 
            '&client_secret=' + clientSecret + 
            '&username=' + EncodingUtil.urlEncode(userName, 'UTF-8') + 
            '&password=' + EncodingUtil.urlEncode(password, 'UTF-8')
        );
        Http http = new Http();
        HTTPResponse response = http.send(request);   
        System.debug('Body: ' + response.getBody());
        System.debug('Status:' + response.getStatus());
        System.debug('Status Code:' + response.getStatusCode());
        WrapperResponseOAuth wrapperInstane = 
            (WrapperResponseOAuth) JSON.deserialize(response.getBody(), WrapperResponseOAuth.class);
        System.debug('Access Token' + wrapperInstane.access_token);
        return wrapperInstane;
    }
    
    /**
     * Create new Lead from REST API
     */
    public HttpResponse createLead() {
        WrapperResponseOAuth wrapInstance = RestLogin.loginMethod();
        Http httpInstance = new Http();
        HttpRequest httpRequestInstance = new HttpRequest();
        httpRequestInstance.setHeader('Authorization', 'Bearer ' + wrapInstance.access_token);
        httpRequestInstance.setHeader('Content-Type', 'application/json');
        httpRequestInstance.setHeader('accept', 'application/json');
        httpRequestInstance.setMethod('POST');
        String createString = '{"firstNameInsert" : "Rest", "lastNameInsert" : "Assign", "companyInsert" : "Rest.org", "statusInsert" : "Open - Not Contacted", "emailInsert" : "demo@rest.com", "phoneInsert" : "7410258963"}';
        httpRequestInstance.setBody(createString);
        httpRequestInstance.setEndpoint(wrapInstance.instance_url + '/services/apexrest/LeadManipulation');
        HttpResponse responseInstance = httpInstance.send(httpRequestInstance);
        return responseInstance;
    } 
    
    /**
     * Update Lead from REST API
     */
    public HttpResponse updateLead() {
        WrapperResponseOAuth wrapperInstance = RestLogin.loginMethod();
        Http httpInstance = new Http();
        HttpRequest httpRequestInstance = new HttpRequest();
        httpRequestInstance.setHeader('Authorization', 'Bearer ' + wrapperInstance.access_token);
        httpRequestInstance.setHeader('Content-Type', 'application/json');
        httpRequestInstance.setHeader('accept', 'application/json');
        httpRequestInstance.setEndpoint(wrapperInstance.instance_url + '/services/apexrest/LeadManipulation?_HttpMethod=PATCH');
        httpRequestInstance.setMethod('POST');
        String updateString = '{"firstNameUpdate" : "Rest", "lastNameUpdate" : "Assign", "emailUpdate" : "updateDemo@rest.com", "phoneUpdate" : "8888319158"}';
        httpRequestInstance.setBody(updateString);
        httpRequestInstance.setHeader('Authorization', 'OAuth ' + wrapperInstance.access_token);      
        HttpResponse responseInstance = httpInstance.send(httpRequestInstance);
        return responseInstance;
    }
    
    /**
     * Delete new Lead from REST API
     */
    public HttpResponse deleteLead() {
        WrapperResponseOAuth wrapInstance = RestLogin.loginMethod();
        Http httpInstance = new Http();
        HttpRequest httpRequestInstance = new HttpRequest();
        httpRequestInstance.setHeader('Authorization', 'Bearer' + wrapInstance.access_token);
        httpRequestInstance.setHeader('Content-Type', 'application/json');
        httpRequestInstance.setHeader('accept', 'application/json');
        httpRequestInstance.setEndpoint(wrapInstance.instance_url + '/services/apexrest/LeadManipulation?FirstName=Rest&LastName=Assign&Email=updateDemo@rest.com&Phone=8888319158');
        httpRequestInstance.setMethod('DELETE');      
        httpRequestInstance.setHeader('Authorization', 'OAuth ' + wrapInstance.access_token);       
        HttpResponse responseInstance = httpInstance.send(httpRequestInstance);
        return responseInstance;
    }
    
    /**
     * Wrapper Class to get the response 
     */
    public class WrapperResponseOAuth {
        public String id = '';
        public String issued_at = '';
        public String instance_url = '';
        public String signature = '';
        public String access_token = '';
    }
}