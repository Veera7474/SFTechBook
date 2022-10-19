trigger Trigger501 on Case (before insert)
{
     if(Trigger.isafter)
     {
         if(Trigger.isinsert||Trigger.isupdate)
         {
             caseHelper.caseTriggerHandler(Trigger.New);
         }
         
     }
}