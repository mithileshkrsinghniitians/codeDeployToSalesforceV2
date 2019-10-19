public with sharing class ContactHandler {

//Avoid Recursive triggering

public static Boolean isContactConverted = false;

//Main Method

public static void ConvertToLead(List<Contact> lstContact){

List<Lead> lstLead = ContactHandler.insertLeads(lstContact);

system.debug('@@@@ Deleting Contact - :' + lstContact);

isContactConverted = true;

//delete lstContact;

insert lstLead;

system.debug('=====lstLead======'+ [Select Id, OwnerId, Owner.Name From Lead Where Id in: lstLead]);

List<Lead> lstNewLeads = [Select Id, firstName, LastName, IsConverted, Email, LeadSource, Contact_To_Lead__c from Lead where Contact_To_Lead__c = true];

ContactHandler.convertLeads(lstNewLeads, lstContact);

}

public static List<Lead> insertLeads(List<Contact> lstContact){

List<Lead> lstNewLeads = new List<Lead>();

for(Contact contact : lstContact){

Lead lead = new Lead();

lead.Contact_To_Lead__c = true;

lead.LastName = contact.LastName;

lead.firstName = contact.FirstName;

lead.Email = contact.Email;

lead.Company = 'Testing';

lead.LeadSource = 'Others';

lead.status = 'Converted to Contact';

lead.OwnerID = contact.New_Owner_ID__c;

lstNewLeads.add(lead);

}

return lstNewLeads;

}

public static void convertLeads(List<Lead> lstNewLeads, List<Contact> lstContact){

ID DupeAccountId;

for(Lead lead : lstNewLeads){

if(lead.isConverted == false){

Account a = [Select Id from Account LIMIT 1];

DupeAccountId = a.Id;

system.debug('@@@AccountId - : ' +lead.isconverted);

Database.LeadConvert lc = new Database.LeadConvert();

lc.setLeadId(lead.id);

lc.setConvertedStatus('Closed - Converted');

system.debug('@@@@LeadStats -: '+lc.getConvertedStatus());

//lc.setAccountId(lstContact[0].AccountId);

//lc.setContactId(lstContact[0].Id);

lc.setOwnerId('00590000001rbXy');

lc.setDoNotCreateOpportunity(true);

Database.LeadConvertResult lcr = Database.convertLead(lc);

system.debug('====lcr =='+ lcr );

isContactConverted = true;

}

}

}

}