trigger Trigger103 on SE_Contact__c (after insert,after delete,after update) 
{
    set<id> setOfAccIds = new set<id>();
    list<SE_Contact__c> listOfSimilarContacts = new list<SE_Contact__c>();
    list<SE_Contact__c> listContact = new list<SE_Contact__c>();
    list<Account> listOfSimilarAccounts=new list<Account>();
    list<Account> listAcc=new list<Account>();
    map<id,Integer> mapOfnoOfContacts=new map<id,Integer>();
    if(Trigger.isInsert || Trigger.isUpdate){
        for(SE_Contact__c c: Trigger.New){
            setOfAccIds.add(c.Account__c);
        }
    }
    if(Trigger.isDelete || Trigger.isUpdate){
        for(SE_Contact__c c:Trigger.Old){
            setOfAccIds.add(c.Account__c);
        }
    }
    listOfSimilarAccounts=[SELECT Id, Name
                           FROM Account
                           WHERE Id In:setOfAccIds];
    listOfSimilarContacts=[SELECT id, name , Account__c
                           FROM SE_Contact__c
                           WHERE Account__c In:setOfAccIds];
    for(account acc:listOfSimilarAccounts){
        listContact.clear();
        for(SE_Contact__c c:listOfSimilarContacts){
            if(c.Account__c == acc.id){
                listContact.add(c);
                mapOfnoOfContacts.put(c.Account__c,listContact.size());
            }
        }
    }
    if(listOfSimilarAccounts.size()>0){
        for(Account a:listOfSimilarAccounts){
            if(mapOfnoOfContacts.get(a.id)!=null){
                a.no_of_contacts__c=mapOfnoOfContacts.get(a.id);
                listAcc.add(a);
            }
        }
    }
    if(listAcc.size()>0)
        update listAcc;
}