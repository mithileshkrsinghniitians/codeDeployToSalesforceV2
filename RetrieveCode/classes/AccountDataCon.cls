public class AccountDataCon {

    public Account acct {get;set;}
    //constructor
    public AccountDataCon(ApexPages.StandardController controller) {
          acct = (Account)controller .getRecord();
          acct.OwnerId = UserInfo.getUserId(); 
    }
    //This method is used to insert Account and redirects to new Contact page
    public PageReference Savedata(){
              try{
                 insert acct;
                PageReference pageRef  = new PageReference('/apex/ContactCustompage?AccountId='+acct.Id);
               pageref.setRedirect(true);
              return pageRef;
               system.debug('data========>');
          
              }catch(Exception E){
              ApexPages.addMessages(E);
       }
         return null;
    }
}