public class ABCD{
public String body{get;set;}
public String HtmlValue{get;set;}
public ABCD ()
{

EmailTemplate E= [Select id,htmlValue,body from EmailTemplate where id='00X2v0000023H9U'limit 1];
body=E.body;
HtmlValue=E.htmlValue;

}


}