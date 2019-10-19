public with sharing class SpecSheettoProduct 
{
Id OpportunityId;
Id OpportunityOwnerId;
public List<OpportunityLineItem> OptList {get; set;}

public SpecSheettoProduct (ApexPages.StandardController controller) 
{
OpportunityId =[select id from Opportunity where id =:ApexPages.currentPage().getParameters().get('oppid')].id;
OpportunityOwnerId =[select ownerid from Opportunity where id =:ApexPages.currentPage().getParameters().get('oppid')].ownerid;
System.debug('OpportunityId :' + OpportunityId);
System.debug('OpportunityOwnerId :' + OpportunityOwnerId);
}
public List<OpportunityLineItem> getoptProducts()
{
if(OptList == null) 
{
OptList = new List<OpportunityLineItem>();
for(OpportunityLineItem c: [SELECT Id, OpportunityId, PricebookEntryId FROM OpportunityLineItem where 
OpportunityId =: OpportunityID]) 
{
OptList.add(c);
}
}
return OptList;
}
public PageReference NewSpecSheet()
{
/*
string optprod = System.currentPageReference().getParameters().get('opid');
id oliid= System.currentPageReference().getParameters().get('oliid');
system.debug('##################### optprod: ' + optprod);
system.debug('$$$$$$$$ '+oliid);
Map<Id, OpportunityLineItem> olimap = new Map<Id, OpportunityLineItem>();
List<OpportunityLineItem> op=new List<OpportunityLineItem>();
For(OpportunityLineItem o : op)
{
olimap.put(o.id,o);
}
pageReference Page = new pageReference ('olimap.get(oliid).o.pricebookentry.product2.SpecSheetURL__c?opid=' + opid);
Page.setRedirect(true);
*/
return null;
}
}