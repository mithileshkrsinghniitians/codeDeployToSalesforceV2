public class sample1
{    
    public List<Account> acct {get;set;}
    public sample1()
    {
        acct = [SELECT Name, (SELECT Name, Email FROM Contacts) FROM Account where id = '0019000000X2LZe'];
    }    
}