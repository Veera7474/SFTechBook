public with sharing class CreateRecord {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accId){
        return [SELECT Id,Name, FirstName,LastName, Email, MobilePhone,Description FROM Contact WHERE AccountId =:accId];
   }
    
}