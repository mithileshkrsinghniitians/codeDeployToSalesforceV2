public with sharing class DownloadData 
 {
    public DownloadData(ApexPages.StandardController controller) {}
    
    public List<Account> getData() 
    {
    id accid = ApexPages.currentPage().getParameters().get('id');
    List<Account> mo = [SELECT ID, Name, Phone FROM Account where id =:accid]; 
    return mo;
    } 
 }