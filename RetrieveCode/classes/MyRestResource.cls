@RestResource(urlMapping='/HCL/*')
global class MyRestResource {

// Just to Test 

    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
  
    @HttpGet
    global static Account doGet() {
    //global static mks1__Application__c doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website, mks1__Active__c FROM Account WHERE Id = :accountId];
        //mks1__Application__c result = [SELECT Id, mks1__CategoryIds_c__c FROM mks1__Application__c WHERE Id = :accountId];
        return result;
        
        //List<mks1__Application__c> accList = New List<mks1__Application__c>();
        //List<List <sObject>> searchList = [FIND '111' RETURNING  mks1__Application__c (Id, Name, mks1__CategoryIds_c__c)];
        //accList = ((List<mks1__Application__c>)searchList[0]);
        //System.debug('Singh' + accList);
        //return accList[0];
        
    }
  
  @HttpPost
    global static String doPost(String name,
        String phone, String website) {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }
}