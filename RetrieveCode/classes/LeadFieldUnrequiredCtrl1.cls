Public without sharing class LeadFieldUnrequiredCtrl1
{

    public pageReference save()
    {
        Lead l = New Lead ();
        l.FirstName = 'TestLead123';
        Insert l ;
        System.Debug('####### == >> '+ l.ID);
        return null;
    
    }
    
}