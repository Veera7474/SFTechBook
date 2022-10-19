public class BatchOnCase implements Database.Batchable<sObject>
{
    Public Database.Querylocator start(Database.BatchableContext BC)
    {  
        String  Q='SELECT Id, CaseNumber, ContactId, Contact_Reason__c,CreatedDate,Status FROM Case';
        System.debug('Q--------->'+Q);
        return Database.getQueryLocator(Q); 
    }
    Public void execute(Database.BatchableContext BC,List<Case> listOfCases)
    {
        System.debug('list---->'+listOfCases);
        List<Contact> listOfContact=[SELECT Id,Email FROM Contact];
        Map<Id,String> MapOfContact=new Map<Id,String>();
        for(Contact cs:listOfContact)
        {
            MapOfContact.put(cs.Id, cs.Email);
        }
        System.debug('mails--->'+MapOfContact);
        for(Case c:listOfCases)
        {
            if(c.ContactId!=Null)
            {
                Integer noOfDays=(Date.valueOf(c.CreatedDate).daysBetween(System.today()));
                System.debug('days--------->'+noOfDays);
                if((noOfDays>30 && noOfDays<60)&&(c.Contact_Reason__c=='Electrcity & Gas' || c.Contact_Reason__c=='List Of Support manegement'))
                {
                    c.Status='working';
                    Emailcalling.sendMail(MapOfContact.get(c.ContactId),'Reminder','your case is about to close');
                    System.debug('sendMail--------');
                }
                else if((noOfDays>60) && (c.Contact_Reason__c=='Electrcity & Gas' || c.Contact_Reason__c=='List Of Support manegement'))
                {
                    c.Status='Closed';
                    Emailcalling.sendMail(MapOfContact.get(c.ContactId),'Reminder','your case is already closed');   
                }
            }
        }
        update listOfCases;
        System.debug('asdfghjk--------->'+listOfCases);
    }   
    Public void finish(Database.BatchableContext BC)
    {
        
    }
}