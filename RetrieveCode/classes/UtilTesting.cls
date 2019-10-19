public class UtilTesting 
{
public static string getProfileId(String profileName)
 {
        System.Debug('## >>> Starting Util.getProfileId <<<');
        System.Debug('## >>> Get profileName from ProfileID for profileName :'+profileName);
        list<Profile> pr = [Select Id From Profile where name =: profileName limit 1];
        if(pr.size()>0){
            System.Debug('## >>>>> end of Util.getProfileId -> Return:'+pr[0].Id +' <<<<<');
            return String.ValueOf(pr[0].Id);
        }
        return '';
 }
}