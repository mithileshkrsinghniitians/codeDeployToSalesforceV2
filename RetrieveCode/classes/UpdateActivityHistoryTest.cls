@isTest(SeeAllData=True)
private class UpdateActivityHistoryTest
{
static testMethod void testUpdateActivityHistory()
{
Opportunity obj = [Select mks1__Unique_Account_Code__c, id from Opportunity where id = '0069000000FETdC'];
String UAC ='Test';
List<Opportunity> listopp = new List<Opportunity>([Select ID, Name, mks1__Unique_Account_Code__c from Opportunity
where mks1__Unique_Account_Code__c =: UAC]);
if((listopp[0].Name==listopp[0].Name) && (listopp[0].mks1__Unique_Account_Code__c==listopp[0].mks1__Unique_Account_Code__c))
{
List<Task> tasklist = new List<Task>();
   Task task = new Task();
   task.whatId='0069000000FETdC';
   task.Status='Mithilesh Test';
   task.Subject='Mithilesh Test';
   task.ActivityDate=System.today();
   task.Priority='High';
   task.Description='This is a test';
   tasklist.add(task);
   insert tasklist;
   update task;
}
}
}