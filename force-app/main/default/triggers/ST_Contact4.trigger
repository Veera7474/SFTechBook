trigger ST_Contact4 on SF_Contact__c (After Insert) 
{
    set<ID> aId=new set<ID>();
    list<SF_Contact__c> lcontact1=new list<SF_Contact__c>();
    list<SF_Contact__c> lcontact2=new list<SF_Contact__c>();
    list<Account> listAccount1=new list<Account>();
    list<Account> listAccount2=new list<Account>();
    map<id,integer> noOfContacts=new map<id,integer>();
     if(Trigger.isInsert)
        {
            for(SF_Contact__c c:Trigger.New)
                aId.add(c.Account__c);
        }
}