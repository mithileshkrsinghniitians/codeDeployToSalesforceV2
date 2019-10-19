global class scheduledOwnerReassignment implements Schedulable 
{
   global void execute(SchedulableContext sc) 
   {
      OwnerReassignment obj = new OwnerReassignment(); 
      database.executebatch(obj);
   }
}