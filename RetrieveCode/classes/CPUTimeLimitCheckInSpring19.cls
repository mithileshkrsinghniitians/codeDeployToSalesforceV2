@isTest
public class CPUTimeLimitCheckInSpring19 {
    @testSetup static void setup()
    {
        for(Integer i=0; i<150; i++)
        {
            Contact con = new Contact();
            con.LastName  = 'CPU Time Limit' + i;
            insert con;
        }
    }
    
    static testMethod void testCPUTimeLimt()
    {
        
    }
}