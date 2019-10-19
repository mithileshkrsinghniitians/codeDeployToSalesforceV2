public class SFTest 
{
        public string id {get; set;}
        public string name {get; set;}
        public string size {get; set;}
        public string downloadUrl {get; set;}
        public string attachmentType {get; set;}
        public string documentId {get; set;}
public SFTest(ApexPages.StandardController controller) {
}

public void deleteFile() {      // method for deleting attachments, since files can't be deleted unless by the owner
        if (attachmentType == 'file') {
            // create a copy of the file with current user as the owner
            Id currentUserId = UserInfo.getUserId();
            ContentDocument doc = new ContentDocument(Id = documentId, OwnerId = currentUserId);

            // change the owner
            try {
                update doc;
            } catch (Exception e){
                System.debug('There was an error, ' + e + ' updating ownership of this file: ' + documentId);
              //  Error_Logging.recordException(e, 'caseFeedExtension', 'updating ownership of a file before deleting');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'There was an ERROR deleting this File.'));
            }

            // delete the file
            try {
                delete doc;
            } catch (Exception e){
                System.debug('There was an error, ' + e + ' deleting this file: ' + documentId);
             //   Error_Logging.recordException(e, 'caseFeedExtension', 'deleting file from case feed');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'There was an ERROR deleting this File.'));
            }

        } else if (attachmentType == 'attachment') {
            // get the attachment
            Attachment attach = [SELECT Id FROM Attachment WHERE Id = :Id];

            try {
                delete attach;
            } catch (Exception e){
                System.debug('There was an error, ' + e + ' deleting this attachment: ' + Id);
                //Error_Logging.recordException(e, 'caseFeedExtension', 'deleting attachment from case feed');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'There was an ERROR deleting this Attachment.'));
            }
        }
}
}