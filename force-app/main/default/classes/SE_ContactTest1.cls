@isTest
public class SE_ContactTest1
{
    @testSetup
    public static void setup()
    {
        Account accountList=new Account(Name='testAccount');
        insert accountList;
        List<SE_Contact__c> contactList1=new List<SE_Contact__c>();
        for(Integer i=1;i<=30;i++)
        {
            SE_Contact__c c=new SE_Contact__c();
            c.SName__c='test'+i;
            c.Account__c=accountList.Id;
            contactList1.add(c);
        }
        insert contactList1;
        System.debug('List of Contacts is '+contactList1.size());
    } 
    
    
    @isTest
    public static void testingConditionDelete()
    {
        Account AccountID=[Select Id, no_of_contacts__c from Account where Name='testAccount'];
        List<SE_Contact__c> DeleteContact=[SELECT Id
                                           FROM SE_Contact__c 
                                           WHERE Account__c=:AccountID.id Limit 10];
        
        delete DeleteContact;
        System.debug('DeleteContact'+DeleteContact.size());
        List<SE_Contact__c> RemainingContacts=[SELECT Id
                                    FROM SE_Contact__c
                                    where Account__c=:AccountID.id];
        System.debug('remconsize'+RemainingContacts.size());
        System.assertEquals(20, RemainingContacts.size());
    }
    @isTest
    public static void testingConditionUpdate()
    {
        Account AID=[Select Id from Account where Name='testAccount'];
        List<SE_Contact__c> list1=[SELECT Id
                                           FROM SE_Contact__c];
        System.debug('Size Of List Is'+list1.size());
        List<SE_Contact__c> DeleteContact=[SELECT Id
                                           FROM SE_Contact__c 
                                           WHERE Account__c=:AID.id Limit 5];
        delete DeleteContact;
        System.debug('delete'+DeleteContact.size());
        list<SE_Contact__c> AddContact=new List<SE_Contact__c>();
        for(Integer i=1;i<=10;i++)
        {
            SE_Contact__c c=new SE_Contact__c();
            c.SName__c='testing'+i;
            AddContact.add(c);
        }
        insert AddContact;
        System.debug('AddContact'+AddContact.size());
        
        list<SE_Contact__c>RemainingContacts=[select id
                                              from SE_Contact__c
                                              where Account__c=:AID.id];
        System.debug(RemainingContacts.size());
        System.assertEquals(25,RemainingContacts.size());
    }
    
}