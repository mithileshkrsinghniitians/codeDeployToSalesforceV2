public class DBN_TapeMapping
{
public DBN_TapeMapping(ApexPages.StandardController controller) {}
public String SellerField1 {get;set;}
public String SellerField2 {get;set;}
public String SellerField3 {get;set;}
Integer LoanCount;
String Match;

String SFField1='2nd Loan Number';
public String getSFField1() 
{
return SFField1;
}
public void setSFField1(String SFField1) 
{
this.SFField1 = SFField1; 
}

String SFField2='HO Name 1';
public String getSFField2() 
{
return SFField2;
}
public void setSFField2(String SFField2) 
{
this.SFField2 = SFField2; 
}

String SFField3='HO SSN 1';
public String getSFField3() 
{
return SFField3;
}
public void setSFField3(String SFField3) 
{
this.SFField3 = SFField3; 
}

public String getMatch() 
{
return Match;
}
public void setMatch(String Match) 
{ 
this.Match = Match;
}
/*
public List<SelectOption> getSellerList() {
        List<SelectOption> Options = new List<SelectOption>();
        Date d = system.Today();
        Tape_Mapping__c tm = [select Id, SF_Fields__c, Seller_Fields__c from Tape_Mapping__c where Name = 'Ocwen' order by CreatedDate desc limit 1];
        String SFields = tm.SF_Fields__c;
        String [] Loans = SFields.split('\n');
        LoanCount = Loans.size();
        Options.Add(new SelectOption('--None--','--None--'));
        for(Integer i=0; i<LoanCount; i++) 
        {
        Options.Add(new SelectOption(Loans[i],Loans[i]));
        }
return Options;
}
*/

public List<SelectOption> getSellerList()
{
List<SelectOption> options = new List<SelectOption>();
options.add(new SelectOption('--None--','--None--'));
options.add(new SelectOption('LOAN_NO','LOAN_NO'));
options.add(new SelectOption('SERV_LOAN_NO','SERV_LOAN_NO '));
options.add(new SelectOption('SECURED_UNSECURED','SECURED_UNSECURED'));
return options;
}

public PageReference process()
{
Tape_Mapping__c obj = [Select Id from Tape_Mapping__c where Name ='Mithilesh' order by CreatedDate desc limit 1];
obj.Seller_Fields__c = SellerField1 + '\n';
obj.SF_Fields__c = SFField1 + '\n';
obj.Seller_Fields__c += SellerField2 + '\n';
obj.SF_Fields__c += SFField2 + '\n';
obj.Seller_Fields__c += SellerField3 + '\n';
obj.SF_Fields__c += SFField3 + '\n';
//obj.ID = obj.ID;
update obj;
PageReference pageRef= new PageReference('/apex/DBNTapeMapping');
pageRef.setredirect(true);        
return pageRef; 
} 
}