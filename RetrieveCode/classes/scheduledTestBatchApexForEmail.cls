global class scheduledTestBatchApexForEmail implements Schedulable 
{
   global void execute(SchedulableContext sc) 
   {
      TestBatchApexForEmail obj = new TestBatchApexForEmail(); 
      database.executebatch(obj);
   }
}