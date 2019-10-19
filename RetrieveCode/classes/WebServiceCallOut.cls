global class WebServiceCallOut
{

public static void main()
{
     HttpRequest req = new HttpRequest();
     req.setEndpoint('https://login.salesforce.com');
     req.setMethod('GET');
     
     // Specify the required user name and password to access the endpoint
     // As well as the header and header information
 
     String username = 'mithileshks2009@gmail.com';
     String password = 'Mithilesh_123cEQpAjsqRdccdCqVWv9B9iKuK';
  
  /* Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'BASIC ' + EncodingUtil.base64Decode(headerValue);
     req.setHeader('Authorization', authorizationHeader);
  */   
  
     //req.setRequestHeader("Authorization",
     req.setHeader('Authorization', 'BASIC ' + UserInfo.getSessionId());
 
     // Create a new http object to send the request object
     // A response object is generated as a result of the request  
  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
   }
}