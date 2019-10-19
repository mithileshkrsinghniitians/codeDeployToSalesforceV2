public with sharing class BusinessAccountCustomCon {
   public string straccid='';
   public string strid='';
    //public Boolean booldata;
    public Boolean boldata{get;set;}
    public Account acct {get;set;}
    public Opportunity opp{get;set;}
    public string stropp{get;set;}
    public String RT{get;set;}
    public string state{get;set;}
    public BusinessAccountCustomCon(ApexPages.StandardController controller) {
      strid = apexpages.currentpage().getparameters().get('Accountids');
      straccid = apexpages.currentpage().getparameters().get('id');
      system.debug(strid);
      system.debug(straccid);
      opp = [select id,Name from Opportunity Where id =: strid];
       RT = [Select RecordType.Name from Opportunity where id=:strid].RecordType.Name;
      system.debug(RT); 
      list<Opportunity> lstopp = [select id,Name,RecordType.Name from Opportunity Where id =: strid];
      
       /*for(Opportunity objopp :lstopp){
            stropp = objopp.id;
    
       }*/
       system.debug(lstopp);
       system.debug(opp);
      /* if( stropp == 'Group Benefits'){
       
              boldata = true;
       }*/
       
       system.debug('stropp===============>'+stropp);
           acct = new Account();
           State = [ Select  BillingStateCode from Account where ID =: straccid].BillingStateCode;
           system.debug(State);
            acct = (account)controller .getRecord();
            system.debug(Acct.BillingState);
            system.debug(Acct.BillingStateCode);
            //system.debug(BillingStateCode);
            //system.debug(BillingState);
            system.debug(Account.BillingStateCode);
            system.Debug(Account.BillingState);
            
             acct.BillingStateCode = State;
              
    }
    //this method is for update account information and redirect to Attachment page 
  
  /*
  public void setEditVisibility(){
  if(RT == 'Group Benefits')
  {
   boldata = false;
  }
  else
  {
  boldata = true;
  }
  }   
  */
  
  public pageReference savedata(){
  try{
    
    update acct;
    PageReference pageref  = new PageReference('/apex/OppAttachmentPage?oppid='+strid+'&accountid='+straccid);
               pageref.setRedirect(true);
              return pageref;
         
    }catch(Exception E){
               Acct.BillingStateCode = state;
              //System.debug('The following exception has occurred: ' + e.getMessage());
              apexpages.addmessages(E);
         }
         return null;
  }
}