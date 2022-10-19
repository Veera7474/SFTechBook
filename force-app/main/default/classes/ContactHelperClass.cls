public class ContactHelperClass 
{
    public static void caseTriggerHandler (List<Case> newList)
    {
        system.debug('newList'+newList.size());
        List<Task> taskList= new List<Task>();
        for(Case c:newList)
        {
            if(c.RecordTypeId!=Schema.SObjectType.Case.getRecordTypeInfosByName().get('General').getRecordTypeId())
            {
                Task newTask=new Task();
                newTask.Subject='This Task is Generated for others';
                newTask.WhatId=c.Id;
                taskList.add(newTask);
                if((c.Contact_Reason__c == 'List Of Support manegement') || (c.Contact_Reason__c =='Electrcity & Gas'))
                {
                    c.Contact_Reason__c.addError('You do not have the permission to add this Contact Reason');
                }
            }
            else
            {
                Task newTask=new Task();
                newTask.Subject='This Task is Generated for general';
                newTask.WhatId=c.Id;
                taskList.add(newTask);     
            }
        }
        if(taskList.size()>0)
        {
            insert taskList;
        }
    }
}