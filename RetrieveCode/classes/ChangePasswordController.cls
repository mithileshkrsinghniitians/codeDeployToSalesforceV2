/**
 * An apex page controller that exposes the change password functionality
 */
public with sharing class ChangePasswordController {
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}        
    
public PageReference changePassword() {
/*
String email = UserInfo.getUserEmail();   
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] {email});
mail.setTargetObjectId('00590000001rWCB');
mail.setTemplateId('00X90000001NjDb');
mail.setsaveasActivity(false);
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
*/
      return Site.changePassword(newPassword, verifyNewPassword, oldpassword);         
    }     
    
    public ChangePasswordController() {}
}