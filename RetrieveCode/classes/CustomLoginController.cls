/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class CustomLoginController {
    global String username{get;set;}
    global String password{get;set;}
    global CustomLoginController () {}
    global PageReference forwardToCustomAuthPage() {
        return new PageReference( '/CustomLandingPage');
        // return new PageReference( 'https://community.wd.com/');
    }
    global PageReference login() {
        return Site.login(username, password, null);
    }
    
    public PageReference logOut() {
        return new PageReference('/apex/ForgotPassword');
    }
    
     public PageReference forgotPassword() {
        return new PageReference('/apex/ForgotPassword');
    }

}