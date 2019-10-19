public class callout {

    public PageReference submit() {
    
    sendNotification(a.Name,a.phone);
        return null;
    }


public Account a{get;set;}
public List<Account> acct{get;set;}

public callout()
{
a=new Account();
acct =new List<account>();
}

public static void sendNotification(String name, String city) {

    HttpRequest req = new HttpRequest();
    HttpResponse res = new HttpResponse();
    Http http = new Http();

    req.setEndpoint('http://requestb.in/17b0ymm1');
    req.setMethod('POST');
    //req.setBody('name='+EncodingUtil.urlEncode(name, 'UTF-8')+'&city='+EncodingUtil.urlEncode(city, 'UTF-8'));
    req.setBody('name=' + name +'&city=' + city);
    req.setCompressed(true); // otherwise we hit a limit of 32000

    try {
        res = http.send(req);
    } catch(System.CalloutException e) {
        System.debug('Callout error: '+ e);
        System.debug(res.toString());
    }

}
}