public with sharing class SiteLoginControllerV2 {
    public String authProviderURL { get; set; }
    public String username {get; set;}
    public String password {get; set;}
    public String siteURL  {get; set;}
    public String startURL {get; set;}
 
    public SiteLoginControllerV2 () {
        // Auth Provider URL hard coded here for clarity; better to load from a custom setting!
        authProviderURL = 'https://login.salesforce.com/services/auth/sso/00D90000000oiBxEAI/customer';
        siteURL         = Site.getCurrentSiteUrl();
        startURL        = System.currentPageReference().getParameters().get('startURL');
    }
    
    public PageReference login() {
        return Site.login(username, password, startUrl);
    }
}