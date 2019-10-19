public class FetchURL
{
public FetchURL()
{
String str = ApexPages.currentPage().getParameters().get('saml_request_id');
System.debug('SAML Request Id' + str);
}
}