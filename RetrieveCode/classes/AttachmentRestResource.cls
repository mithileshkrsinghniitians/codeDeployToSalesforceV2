@RestResource(urlMapping='/Attachment/*')
global with sharing class AttachmentRestResource {

    @HttpGet
    global static Attachment doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String attId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Attachment att = [SELECT Body FROM Attachment WHERE Id = :attId];
        return att;
    }
}