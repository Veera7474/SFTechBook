trigger AccountTigger on Account (before insert , before update)
{
 if(Trigger.isBefore && Trigger.isInsert)
 {
     system.debug('i am in before insert context');
 }
    if(Trigger.isBefore && Trigger.isUpdate)
 {
     system.debug('i am in before Update context');
 }
}