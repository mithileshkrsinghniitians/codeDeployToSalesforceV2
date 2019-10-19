public class NamedCredential
    {
        public static void callingToAnotherOrg()
            {
              //(HttpRequest & Http) Instance Of The Class
                HttpRequest feedRequest = new HttpRequest();
                Http http = new Http();

            /* Callout Invoking Parameters */
        //String body='{"Name":"test account2from one org", "Phone":"123456789"}';
        //feedRequest.setEndpoint('callout:Named_Credential/services/data/v32.0/sobjects/Account');
        //feedRequest.setEndpoint('callout:Named_Credential/services/data/v32.0/sobjects/Account?Select+id+From+Account');
        //feedRequest.setEndpoint('callout:Named_Credential/services/data/v41.0/sobjects/Attachment/00Pi000000qrmTCEAY/Body');
        
            /* Callout to Salesforce Another Org (Jolly Dev Org) */
        feedRequest.setEndpoint('callout:Named_Credential/services/apexrest/Accounts/001i000000vGJDh');
        
            /* Callout to Facebook */
        //feedRequest.setEndpoint('callout:Facebook');
        
            /* Callout to hookb.in to capture Access Token */
        // feedRequest.setEndpoint('https://hookb.in/03M8oD9lNRtGmGkNlK1D');
        
        /* Header */
        //feedRequest.setHeader('Authorization', 'OAuth {!$Credential.OAuthToken}');
        //feedRequest.setHeader('Content-Type', 'application/json');    
        feedRequest.setMethod('GET');
        //feedRequest.setBody(body);
        
        /* Invoking Callout */
        System.debug(feedRequest);
        HTTPResponse feedResponse = http.send(feedRequest);
        
        System.debug('Final: ' + feedResponse.getStatusCode() + ' ' + feedResponse.getStatus());
        System.debug(feedResponse.getBody());
            }
     }