@isTest
private class UpdateAccountFieldTrigger_TestClass
{
 private static testMethod void operation()
 {
  Account a = new Account(Name='Test', Private__c=false);
  insert a;
  Contact c = new Contact(Lastname = 'Test', AccountID=a.ID);
  insert c;
  
  a.Private__c = true;
  update a;
 }
}