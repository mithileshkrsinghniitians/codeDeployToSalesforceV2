public class SFTest_class {

    //variables used to build out the feed
    public List<returnFeedItem> feedItems {get; set;}               //The feedItems returned to the page
    public string theCaseId {get; set;}                             // 15 digit case id used for reply-all javascript

    //internal variables
    private final Case mycase;
    public Case thisCase {get; set;}
    public List<returnFeedItem> feedItemsUnfiltered = new List<returnFeedItem> ();                                  //Unfiltered list of FeedItems
    public Map<Id, returnFeedItem> feedItemMap = new Map<Id, returnFeedItem> ();                                    //Map of the email message ID to the corresponding returnFeedItem

    //handle to this controller
    public SFTest_class caseFeedCon {get{return this;}}

    public SFTest_class(ApexPages.StandardController stdController) {
        this.mycase = (Case)stdController.getRecord();
        system.debug('mycase = ' + mycase);
        if (this.mycase != null) {
            feedItems = new List<returnFeedItem> ();

            //get information on the case
            thisCase = [SELECT id, Contact.Email, CaseNumber, Status, ContactId, Contact.FirstName, Contact.LastName, Contact.Phone FROM Case WHERE ID = :mycase.id];

            theCaseId = thisCase.id;
            theCaseId = theCaseId.substring(0, 15);

            refreshFeed();
        }
    }

    //class to build out all of the information that we need to display for a single feed item from a ConnectApi.FeedItem
    public class returnFeedItem  {

        //variables to display or use on the page
        public List<attachmentInfo> attachmentList {get; set;}
        public id theItemID {get; set;}
        public string emailID {get; set;}

        public string emailIDraw {get; set;}                             //id of emailMessage object
        private SFTest_class ourController;                //needed to use methods in controller outside of the class
        private List<string> bodyList = new List<string> ();

        //default constructor that sets all of the variables to null or blank
        public returnFeedItem () {
            attachmentList = new List<attachmentInfo> ();
            theItemID = null;
            emailID = '';
            emailIDraw = '';
            ourController = null;
        }

        //primary constructor for building out returnFeedItem's from a ConnectApi.FeedItem
        public returnFeedItem (ConnectApi.FeedElement anItem, SFTest_class thisController) {

            theItemID = anItem.Id;                              //item used for adding comments
            ourController = thisController;                     //instance of controller so we can reference refreshFeed()
            emailID = '';                                       //by default, make the email blank
            attachmentList = new List<attachmentInfo> ();       //instantiate list of attachments (that is populated in addEmailMessages method)

            if (anItem.capabilities.emailMessage != NULL) {                                       //if it is an email, handle this way NOTE: the body of the email and meat happens in the addEmailMessages method so we only need to do one SOQL query for all feedItems
                ConnectApi.EmailMessageCapability emailMessage = anItem.capabilities.emailMessage;

                emailIDraw = emailMessage.emailMessageId;
                thisController.feedItemMap.put(emailIDraw, this);                                       //this is used to pull query for all of the email messages in addEmailMessages method

                emailID = 'loadToSubtab(\'' + emailIDraw + '\',\'Email Message\')';

                string bodyBeforeSplit = emailMessage.body;                               //get the body and covert to html
            }
        }
    }

    public class attachmentInfo {

        //variables that will be used
        public string id {get; set;}
        public string name {get; set;}
        public string size {get; set;}
        public string downloadUrl {get; set;}
        public string attachmentType {get; set;}
        public string documentId {get; set;}

        //instance of controller to use refreshFeed
        private SFTest_class ourController;

        public attachmentInfo (Attachment theAttachment, SFTest_class thisController) {
            id = theAttachment.id;
            name = theAttachment.name;
            size = String.valueOf(Math.rint(theAttachment.BodyLength/1000)) + ' kb';
            downloadUrl = '/servlet/servlet.FileDownload?file=' + theAttachment.Id;
            attachmentType = 'attachment';

            ourController = thisController;
        }

        public attachmentInfo (ContentVersion theFile, SFTest_class thisController) {
            id = theFile.Id;
            name = theFile.Title;
            size = String.valueOf(Math.rint(theFile.ContentSize/1000)) + ' kb';
            downloadUrl = '/sfc/servlet.shepherd/version/download/' + theFile.Id;
            attachmentType = 'file';
            documentId = theFile.ContentDocumentId;

            ourController = thisController;
        }

        public void deleteFile() {      // method for deleting attachments, since files can't be deleted unless by the owner
            if (attachmentType == 'file') {
                // create a copy of the file with current user as the owner
                Id currentUserId = UserInfo.getUserId();
                ContentDocument doc = new ContentDocument(Id = documentId, OwnerId = currentUserId);

                // change the owner
                try {
                
                /* ---- SFDC Commented Out ----
                    update doc;
                    ---- END ---- */
                    
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

            ourController.refreshFeed();
        }
    }

    public void refreshFeed() {
        //get all of the 'ConnectApi.FeedItem' objects for this case from the API and put them in a list
        List<ConnectApi.FeedElement> theFeedItemsRaw = ConnectApi.ChatterFeeds.getFeedElementsFromFeed(null, ConnectApi.FeedType.Record, mycase.Id, null, 100, null).elements;
        feedItemsUnfiltered.clear();

        //for each 'ConnectApi.FeedItem', construct a new returnFeedItem and add that to our unfiltered list (feedItemsUnfiltered) to send back to the page
        for (ConnectApi.FeedElement anItem : theFeedItemsRaw) {
            returnFeedItem newItem = new returnFeedItem(anItem, this);
            feedItemsUnfiltered.add(newItem);
        }

        addEmailMessages();
        feedItems = feedItemsUnfiltered.clone();

    }

    //method for getting the HTML body and attachments of email messages
    public void addEmailMessages () {
        Map<Id, Id> attachmentMap = new Map<Id, Id>();                         //Map for attachment ID to parent ID
        Map<Id, Id> fileMap = new Map<Id, Id>();
        Set<EmailMessage> emailsWithAttachments = new Set<EmailMessage>();
        List<ContentDocumentLink> allFileLinks = new List<ContentDocumentLink>();
        List<Attachment> allAttachments;

        //get all of the EmailMessage objects for all of the feedItems that are emails using the feedItemMap
        List<EmailMessage> allEmails = [SELECT Id, HasAttachment, FromAddress, ToAddress, CcAddress, Incoming FROM EmailMessage WHERE id IN :feedItemMap.keySet() ORDER BY CreatedDate DESC LIMIT 250];

        for (EmailMessage anEmail : allEmails) {
            if (anEmail.HasAttachment) {
                emailsWithAttachments.add(anEmail);
            }
        }

        //get all of the attachments for emails that have them
        allAttachments = [SELECT id, BodyLength, Name, ParentId FROM Attachment WHERE ParentId IN :emailsWithAttachments ORDER BY CreatedDate DESC LIMIT 250];

        for (Attachment anAttachment : allAttachments) {
            attachmentInfo newAttachment = new attachmentInfo(anAttachment, this);
            feedItemMap.get(anAttachment.ParentId).attachmentList.add(newAttachment);
        }

        // get just the ids to meet ContentDocumentLink filtering requirement
        Set<Id> emailIds = (new Map<Id,SObject>(allEmails)).keySet();

        if(!emailIds.isEmpty()) allFileLinks = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :emailIds LIMIT 250];

        Set<Id> fileIds = new Set<Id>();
        for (ContentDocumentLink aFile : allFileLinks) {
            fileMap.put(aFile.ContentDocumentId, aFile.LinkedEntityId);
            fileIds.add(aFile.ContentDocumentId);
        }

        // use a class with a current API version to query the actual files
        List<ContentVersion> contentVersions = [SELECT ContentDocumentId, Title, ContentSize FROM ContentVersion WHERE ContentDocumentId IN :fileIds AND IsLatest = TRUE];

        for (ContentVersion cv : contentVersions) {
            attachmentInfo newFile = new attachmentInfo(cv, this);
            feedItemMap.get(fileMap.get(cv.ContentDocumentId)).attachmentList.add(newFile);
        }
    }
}