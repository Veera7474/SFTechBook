trigger ContactreasonTrigger on Case (before insert,after insert,after update)
{
  if(Trigger.isInsert || Trigger.isUpdate)
  {
          ContactHelperClass.caseTriggerHandler(Trigger.New);
  }
}