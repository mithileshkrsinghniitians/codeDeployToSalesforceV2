public with sharing class Example
{
    private static final Integer RETRY_COUNT = 1;

    public static void run()
    {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
         
            /* Callout to hookb.in to capture Access Token */
        req.setEndpoint('callout:Customer_Issue/my/api/path');
        
            /* Callout to Facebook/CustomerIssue */
        //req.setEndpoint('callout:Customer_Issue/v1/LogicalEntityData/Customer?CustomerId=000247');
          
            /* Callout to Salesforce Another Org (Jolly Dev Org) */
        //req.setEndpoint('callout:Named_Credential/services/apexrest/Accounts/001i000000vGJDh');
        
        req.setMethod('GET');
        req.setHeader('Authorization', 'OAuth {!$Credential.OAuthToken}');
        //req.setHeader('Authorization', 'OAuth {!$Credential.AuthorizationMethod}');
        req.setTimeout(120000);
        HttpResponse res = http.send(req);
        //HttpResponse res = withRetry(req);
        
        System.debug('Final: ' + res.getStatusCode() + ' ' + res.getStatus());
        System.debug(res.getBody());
    }

    private static HttpResponse withRetry(HttpRequest req)
    {
        HttpResponse res = null;
        for (Integer i = 0; i <= RETRY_COUNT; i++)
        {
            System.debug('Before Invocation ' + i);

            Http http = new Http();
            res = http.send(req);

            System.debug('After Invocation ' + i + ': ' + res.getStatusCode() + ' ' + res.getStatus());
            System.debug(res.getBody());

            if (res.getStatusCode() >= 200 && res.getStatusCode() < 400)
            {
                break;
            }
        }
        return res;
    }
}