public class ExampleV2 {

    public static void run() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        /* Callout to Beeceptor Endpoint */
        req.setEndpoint('callout:Customer_Issue/my/api/path');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        System.debug(res.getStatusCode() + ' ' + res.getStatus());
        System.debug(res.getBody());
    }
}