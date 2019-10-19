public without sharing class SC_PasswordCreation {
    public string userName{get;set;}
    public String password{get;set;}
    public string confirmPassword{get;set;}
     public string newpassword{get;set;}
    
    
    public ID userID{get;set;}
    
    public SC_PasswordCreation(){
        userName = UserInfo.getUserName();
        userID   = UserInfo.getUserId();
    }
     
     private boolean isValidPassword() {

        return password == newpassword;

    }
    public PageReference doSetPassword() {
    System.debug('The password for user ID ' + confirmPassword + password );
        if(!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }   

 

        string startURL = '/apex/SC_homepage';
      try {
          System.setPassword(userID, password);
          
          System.debug('The password for user ID ' + newpassword + password + startURL);
      } catch (Exception ce) {
          System.debug('Error::'+ce);
      }
        return Page.SC_homepage;
   }
   

    public PageReference doResetPassword(){
        try{
            System.ResetPassword(userID, true);
            system.debug('the password for User Id' + userId);
        } catch(Exception ce){
            system.debug('Error' + ce);
        }
         return Page.SC_homepage;
        }
    
}