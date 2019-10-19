public class NewAccountSave
{
public String accName{get;set;}
public String CaseDetail {get;set;}
public NewAccountSave(ApexPages.StandardController controller) {
}
public PageReference save()
{
Account a = new Account(Name=accName,Case_Detail__c=CaseDetail);
insert a;
PageReference p = new ApexPages.StandardController(a).view();
p.setRedirect(true);
return p;
}
}