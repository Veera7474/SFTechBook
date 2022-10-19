trigger veera1Trigger on veera1__c (before insert , before update,after update) 
    {
        if(trigger.isbefore && trigger.isinsert)
        {
            system.debug('i am in before insert');
        }
        if(trigger.isupdate)
        {
            if(trigger.isbefore)
            {
                for(veera1__c vee : trigger.new)
                {
                 system.debug('New Name'+vee.Name);
                 system.debug('Old Name'+Trigger.oldMap.get(vee.id).Name);   
                }
             }
         }
    }