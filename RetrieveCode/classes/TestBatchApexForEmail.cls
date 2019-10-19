global class TestBatchApexForEmail implements Database.Batchable<sObject>
{
String email='mvatsyayana@salesforce.com';
global Database.querylocator start(Database.BatchableContext BC)
{
return Database.getQueryLocator([select Description from Account WHERE id='0019000000X2LZe']);
}
global void execute(Database.BatchableContext BC, List<Account> scope)
{
/* List<Account> acct = new List<Account>();
for(Account a : scope)
{
a.Description='Hi, This is a Batch Apex Job Testing. Developed By: Mithilesh Kumar Singh';
acct.add(a);
}
update acct; */
for(integer i=1; i<10; i++)
{
finish(BC);
}
}
global void finish(Database.BatchableContext BC)
{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] {email});
mail.setReplyTo('mvatsyayana@salesforce.com');
mail.setSenderDisplayName('System Hacked');
mail.setSubject('Dear Manav Vatsyayana: Your System Has Been Hacked By Pakistan Hacker(Mark Zuckerberg) !!!');
mail.setPlainTextBody('Dear Manav Vatsyayana,\n This is to inform you that your computer has been hacked. Please format '+
' your computer now. This is observed by Microsoft Anti-Virus.\n If you have any question please contact us:\n Address: DLF Cyber Green, Gurgaon,'+ 
' HR.\n Phone:0124 415 8000');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
}