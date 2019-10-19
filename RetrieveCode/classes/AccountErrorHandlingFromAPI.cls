public class AccountErrorHandlingFromAPI{
    
    public static void insertAccount(Account[] actList){
        try{
         
            System.debug('**********INSIDE TRY FROM CLASS**********');
            
                for(Account act: actList){
                System.debug('ActList' + actList); 
                System.debug('Transaction happened on account--> ' + act.Name + ' with account number --> ' + act.AccountNumber + ' and id --> ' + act.Id);
                Error_Logging_Framework__c elf = new Error_Logging_Framework__c();
                elf.Error_Message__c = 'Transaction happened on account--> ' + act.Name + ' with account number --> ' + act.AccountNumber + ' and id --> ' + act.Id;
                Database.insert(elf, false);
                
                /*
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {'mithileshkrsinghniitians@hotmail.com'});
                mail.setReplyTo('mithileshkrsinghniitians@hotmail.com');
                mail.setSenderDisplayName('Administrator');
                mail.setSubject('New Case Created');
                mail.setPlainTextBody('This is a Testing');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                */
                
                String[] toAddresses = new String[] {UserInfo.getUserEmail()};
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(toAddresses);
                email.optOutPolicy = 'FILTER';
                email.subject = 'Testing';
                email.plainTextBody = 'Transaction happened on account--> ' + act.Name + ' with account number --> ' + act.AccountNumber + ' and id --> ' + act.Id;
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            }
            
             
        }catch(DMLException e){
            System.debug('**********INSIDE CATCH FROM CLASS**********'); 
            
            for(Account act: actList){
                System.debug('An error occured in insert/ update operation from SAP on account: ' + act.Name + '. Error is: ' + e.getMessage());
                Error_Logging_Framework__c elf = new Error_Logging_Framework__c();
                elf.Error_Message__c = 'An error occured in insert/ update operation from SAP on account: ' + act.Name + '. Error is: ' + e.getMessage();
                elf.addError('DML Exception');
                insert elf;
                
                /*
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {'mithileshkrsinghniitians@hotmail.com'});
                mail.setReplyTo('mithileshkrsinghniitians@hotmail.com');
                mail.setSenderDisplayName('Administrator');
                mail.setSubject('New Case Created');
                mail.setPlainTextBody('This is a Testing');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                */
                
                String[] toAddresses = new String[] {UserInfo.getUserEmail()};
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(toAddresses);
                email.optOutPolicy = 'FILTER';
                email.subject = 'Testing';
                email.plainTextBody = 'Transaction happened on account--> ' + act.Name + ' with account number --> ' + act.AccountNumber + ' and id --> ' + act.Id;
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            }
        }
    }
}