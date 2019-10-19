@isTest
public class UserDeactivatedTriggerTest
{
private static testMethod void updateOwner() 
{
Case c = new Case();
insert c;

User u = new User();
if(u.IsActive == False)
{
List<Case> cc = new List<Case>();
List<Case> cases = [Select id, ownerid from case where ownerid = '00590000001rbXy'];
for(Case c1 : cases)
{
c1.ownerid = '00590000001rWCB';
cc.add(c1);
}
update cc;
}
}
}