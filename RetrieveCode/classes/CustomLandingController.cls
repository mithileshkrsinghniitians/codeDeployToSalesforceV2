public with sharing class CustomLandingController 
{

    public PageReference logOut() {
        return new PageReference('/secur/logout.jsp');
    }


    public PageReference changePassword() {
        //return new PageReference('/apex/ChangePassword');
        return new PageReference('/apex/CustomChangePassword');
     }

    // Code we will invoke on page load.
    public PageReference forwardToCustomAuthPage() 
     {
        if(UserInfo.getUserType() == 'Guest')
        {
            return new PageReference('/CustomLoginPage');
        }
        else{
            return null;
            }
            
     }

    public CustomLandingController() {}
}