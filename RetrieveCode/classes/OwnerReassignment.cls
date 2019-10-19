global class OwnerReassignment implements Database.Batchable<sObject>
{
String email='mithileshkrsinghniitians@hotmail.com';
Id toUserId='00590000001rbXyAAI';
Id fromUserId='00590000001rqsyAAA';
global Database.querylocator start(Database.BatchableContext BC)
{
return Database.getQueryLocator([Select Branch_Name__c from Account where ID = '0019000000nifez']);
}
global void execute(Database.BatchableContext BC, List<sObject> scope)
{
//Account accns =[Select Branch_Name__c from Account where ID = '0019000000nifez'];
List<String_Test__c> branchList = [SELECT Name, User_Name__c FROM String_Test__c WHERE Name ='New Delhi'];
for(sObject s : scope)
{
Account a = (Account)s;
for (String_Test__c b : branchList)
{
if(a.Branch_Name__c == b.Name)
{
a.OwnerId = b.User_Name__c;
}
}
}
}
global void finish(Database.BatchableContext BC)
{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] {email});
mail.setReplyTo('mithileshkrsinghniitians@hotmail.com');
mail.setSenderDisplayName('Batch Processing');
mail.setSubject('Batch Process Completed');
mail.setPlainTextBody('Batch Process has completed');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
/*
OwnerReassignment reassign = new OwnerReassignment();
ID batchprocessid = Database.executeBatch(reassign);
*/
}