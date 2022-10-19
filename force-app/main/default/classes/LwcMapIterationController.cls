public with sharing class LwcMapIterationController {
    @AuraEnabled(cacheable=true)
    public static Map < String, String > fetchMapData() {
        Map < String, String > mapOppAccount = new Map < String, String >();
        for(Opportunity opp : [SELECT ID, Account.Name, Name FROm Opportunity LIMIT 5])
        	mapOppAccount.put(opp.Name, opp.Account.Name);
        return mapOppAccount;
    }
}