public with sharing class AttachmentUploadController {
    public string strparentid='';
    public string strAccountid='';
    public boolean strbool = false;
    public boolean blnAttchmentinsert{get;set;}
    public string strname{get;set;}
    public blob Attach {get;set;}  
    public Attachment__c objattach{get;set;}
    public Integer noOfAttachments{set;get;}
       public Attachment attachment{get;set;}
      public AttachmentUploadController(ApexPages.StandardController stdController){
      noOfAttachments = 0;
       objattach = new Attachment__c();
                attachment = new Attachment();
               objattach = (Attachment__c)stdController .getRecord();
                strparentid=apexpages.currentpage().getparameters().get('oppid');
               strname='';
                strAccountid=apexpages.currentpage().getparameters().get('accountid');
     }
   
  //this method is for insert attachment 
  public PageReference upload() {
  if(strparentid!= null){
   if(strbool == true && noOfAttachments >0 ){
             this.attachment = null;
             //attachment.body = null;
             ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,' Please use the Add Another Attachment button to attach another file.'));
              return null;
         }
               objattach.Opportunity__c = strparentid;
               objattach.Account__c =  strAccountid;
                objattach.OwnerId = UserInfo.getUserId();
          try{
          if(objattach!= null){
             insert objattach;
             }
            system.debug('objattach@@@@'+objattach);
        }Catch(Exception Ex){
                   Apexpages.addmessage(new apexPages.Message(ApexPages.severity.Error,Ex.getMessage()));
                            } 
                    }
      if(objattach.Id != null){
          attachment.OwnerId = objattach.OwnerId;
          attachment.Body = Attach;
          attachment.ParentId = objattach.Id ;// the record the file is attached to
          attachment.IsPrivate = true;
         try {
                  system.debug('****attachment---'+attachment);
                  Attach = null;
                  if(attachment!= null)
                  {
                   insert attachment;
                  
                  }    
                   //this.attachment = null;             
                     noOfAttachments++;
                     strbool = true;
          
             } catch (DMLException e) {
                        this.attachment = null;
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                       return null;
                 }
      
      
      } 
       if(attachment.Name != null && attachment.Name != ' '){
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,' Mithilesh Singh.'));
                             strname+='FileName:  '+attachment.Name+'\n';
     }
             system.debug('strname=================>'+strname);
             this.attachment = null;
             attachment = new attachment();
           
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully.'));
           
           return null;
  }
  public PageReference redirectpage(){
  if(strbool == true){
           this.attachment = null;
           PageReference pageref  = new PageReference('/apex/ProLineItemPage?strid='+strparentid);
               pageref.setRedirect(true);
              return pageref;
               } else{
                       this.attachment = null;
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select and attach file.'));
                 }
      return null;
  }
  
  public PageReference  addanotherattach(){
  
    PageReference pageref  = new PageReference('/apex/OppAttachmentPage?oppid='+strparentid);
               pageref.setRedirect(true);
              return pageref;
  }
  
}