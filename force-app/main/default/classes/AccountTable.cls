public with sharing class AccountTable {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(String accId) {
        return [
            SELECT AccountId, Id, FirstName, LastName, MobilePhone, Email, Description
            FROM Contact
            WHERE AccountId = :accId
        ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact1(String contactId) {
        return [
            SELECT Id, FirstName, LastName, MobilePhone, Email, Description
            FROM Contact
            WHERE Id = : contactId
        ];
    }
    @AuraEnabled
    public static void deleteContact(Id conId) {
        Contact conObj = [SELECT Id FROM Contact WHERE Id = : conId ];
        system.debug('====='+ conObj);
        delete conObj;
    }
    @AuraEnabled
    public static void UpdateContact(Contact con, Id conId) {
        Contact conObj1 = [SELECT Id, FirstName, LastName, MobilePhone, Email, Description
        FROM Contact
        WHERE Id = : conId ];
        con.Id = conId;
        system.debug('====='+ con);
        update con;
    }
    @AuraEnabled
    public static void deleteSeletedCon(list<String> deleterecord){
        List<Contact> deleteSeletedList = new List<Contact>();
        for(Contact con : [SELECT Id FROM Contact WHERE Id = : deleterecord]){
            deleteSeletedList.add(con);
        }
        if(deleteSeletedList.size() > 0){
            delete deleteSeletedList;
        }
    }
    
}