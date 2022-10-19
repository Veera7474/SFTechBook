public class SchedulearClass implements Schedulable
{
     Public void execute(SchedulableContext sc)

     {
        BatchOnCase b = new BatchOnCase(); // Your batch class
          database.executeBatch(b);

     }
}