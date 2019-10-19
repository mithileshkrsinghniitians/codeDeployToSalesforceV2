global class MC_RenewalChangePasswordController
{
    global String newPassword{get;set;}
    global String confirmPassword{get;set;}
    global String oldPassword {get;set;}
    global boolean runFromTest = false;
    //Global Boolean success{get;set;}
    
    public MC_RenewalChangePasswordController()
    {
        newPassword = '';
        confirmPassword = '';
        oldPassword = '';
    }
    // Forgot Password method
    global PageReference MC_RenewalChangePassword() {
        System.PageReference pg = null;
        try{
            pg = Site.ChangePassword(newPassword,confirmPassword,oldpassword);
           
           //Functionality to send Email
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId('00X90000001NjkQ'); //Id of the Email Template
            mail.setTargetObjectId('00590000002VmgV'); // Id of Contact or Lead or User
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
               
        }catch(Exception ex)
        {   
            
        }
        runFromTest = false;
        return pg;
    }
    
   
}