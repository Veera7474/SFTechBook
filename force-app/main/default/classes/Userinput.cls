public with sharing class Userinput {
    @AuraEnabled(Cacheable = true)
    public static Map<Id,String> getUserDetails() {
        List<User_Details__c> listOfUserDetails = [SELECT Id,Name FROM User_Details__c LIMIT 5];
        System.debug('listOfUserDetails--->'+listOfUserDetails);

        Map<Id,String> mapOfUserDetails = new Map<Id,String>();
        System.debug('mapOfLists--->'+mapOfUserDetails);
        
        for(User_Details__c usn:listOfUserDetails)
        {
          mapOfUserDetails.put(usn.Id, usn.Name);
        }
        System.debug('mapOfLists--->'+mapOfUserDetails);
        return mapOfUserDetails;

    }
}