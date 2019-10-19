@isTest
private class UpdateOppIDTest
{
 static testMethod void runTestClass()
 {
  Date d = System.today();
  Integer year = d.year();
  String year1 = String.valueOf(year);
  
  Opportunity opp1 = new Opportunity(Name='Test1', Amount=null, CloseDate=System.today(), StageName='None',
  Type='New Customer', RecordTypeId='01290000000tZCvAAM', Business_Region__c = 'US');
  System.debug('Opportunity1 Details' + opp1);
  
  if((opp1.RecordTypeId == '01290000000tZCvAAM') && (opp1.Business_Region__c == 'US'))
  {
      Integer UsNumber = [SELECT count() FROM Opportunity WHERE RecordTypeId = '01290000000tZCvAAM'];
      System.debug('RecordType UsNumber Count' + UsNumber);
      String USRegion = opp1.Business_Region__c;
      System.debug('USRegion :' + USRegion);
      opp1.Opportunity_ID__c = (USRegion + '-' + year1) + '-' + (UsNumber + 1);
      insert opp1;
  }
 }
 
 static testMethod void runTestClass1()
 {
  Date d = System.today();
  Integer year = d.year();
  String year1 = String.valueOf(year);
  
  Opportunity opp2 = new Opportunity(Name='Test2', Amount=null, CloseDate=System.today(), StageName='None',
  Type='New Customer', RecordTypeId='01290000000tZDPAA2', Business_Region__c = 'EURO');
  System.debug('Opportunity2 Details' + opp2);
  
  if(!(opp2.RecordTypeId == '01290000000tZDPAA1') && (opp2.Business_Region__c == 'EURO'))
    {
           Integer EURONumber = [SELECT count() FROM Opportunity WHERE RecordTypeId = '01290000000tZDPAA2'];
           System.debug('RecordType EURONumber Count' + EURONumber);
           String EURORegion = opp2.Business_Region__c;
           System.debug('EURORegion :' + EURORegion);
           opp2.Opportunity_ID__c = (EURORegion + '-' + year1) + '-' + (EURONumber + 1);      
           insert opp2;
    }
  }
}