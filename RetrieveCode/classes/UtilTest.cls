public class UtilTest
{
@Future
public static void updateOwner(Set<ID> ownerID)
{
List<Case> cc = new List<Case>();
List<Case> cases = [Select id, ownerid from case where ownerid IN : ownerID];
System.debug('Case Details' + cases);
for(Case c : cases)
{
c.ownerid = '00590000001rWCB';
cc.add(c);
}
update cc;
System.debug('Updated Cases' + cases);
}
}