trigger ST_Contact3 on SF_Contact__c (After insert) {
    set<id> accid=new set<id>();
        list<SF_Contact__c> listOfCon=new list<SF_Contact__c>();
        list<SF_Contact__c> listofAct=new list<SF_Contact__c>();
        list<Account> accList=new list<Account>();
        list<Account> listAcc=new list<Account>();
        map<id,integer> noOfContacts=new map<id,integer>();
     if(Trigger.isInsert || Trigger.isUpdate){
            for(SF_Contact__c c:Trigger.New){
                accId.add(c.Account__c); 
            }
        }
    if(Trigger.isDelete || Trigger.isUpdate){
            for(SF_Contact__c c:Trigger.Old){
                accId.add(c.Account__c);
            }
        }
      accList=[SELECT Id,Name 
               FROM Account
               WHERE Id In:accId];
        listofCon = [SELECT Id,Name,Account__c
               FROM SF_Contact__c
               WHERE Account__c In:accId];
        for(Account acc:accList){
            listOfCon.clear();
            for(SF_Contact__c c:listofCon){
                if(c.Account__c==acc.id){
                    listOfCon.add(c);
                    noofcontacts.put(c.Account__c, listOfCon.size());
                }
            }
        }
    if(accList.size()>0){
            for(Account a:accList){
                if(noOfContacts.get(a.id)==null)
                    a.no_Of_Contacts__c=0;
                else
                    a.no_Of_Contacts__c=noOfContacts.get(a.id);
                listAcc.add(a);
            }
        }
        if(listAcc.size()>0)
            update listAcc;
}