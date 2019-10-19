public class Util
{
@Future
public static void updateOpp(Id ids, Id oldId)
{
List<opportunity> opp =[Select id, ownerId from opportunity where id=:ids ];
opp[0].OwnerID = oldId; 
update opp[0];
}
}