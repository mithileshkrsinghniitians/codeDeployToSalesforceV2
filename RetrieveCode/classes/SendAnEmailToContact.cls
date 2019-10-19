public class SendAnEmailToContact 
{
/*
String email ='mithileshkrsinghniitians@hotmail.com';
Set<Case> CaseOwnerID = new Set<Case>([SELECT OwnerId FROM Case]);
//System.debug('CaseOwnerID' + CaseOwnerID);
Set<Case> AccID =[SELECT AccountId FROM Case where OwnerId IN : CaseOwnerID];
//System.debug('AccID' + AccID);
Set<String> ContDetails =[SELECT Name,Phone,Email FROM Contact WHERE AccountId IN : AccID];
//System.debug('ContDetails' + ContDetails);
*/
public void doSendEmail()
{
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] {'mithileshkrsinghniitians@hotmail.com'});
mail.setReplyTo('mithileshkrsinghniitians@hotmail.com');
mail.setSenderDisplayName('Administrator');
mail.setSubject('New Case Created');
mail.setPlainTextBody('This is a Testing');
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}
}