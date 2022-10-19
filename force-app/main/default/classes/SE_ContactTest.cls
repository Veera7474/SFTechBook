@isTest
public class SE_ContactTest
{
    @testSetup 
    private static void testingConditionInsert() 
    {
        Account a= new Account(Name='testacc1');
        INSERT a;
        List<SE_Contact__c> conList1=new List<SE_Contact__c>();
        conList1.add(new SE_Contact__c(SName__c='test22',Account__c=a.Id));
        conList1.add(new SE_Contact__c(SName__c='test33',Account__c=a.Id));
        insert conList1;
        System.assertEquals(2,conList1.size());
    }
	@isTest
    private static void testingConditionDelete()
    {   
         Account a= new Account(Name='testacc1');
        List<SE_Contact__c> conList2=[SELECT Id, SName__c 
                                      FROM SE_Contact__c 
                                      WHERE Account__c=:a.Id AND SName__c='test22'];
        delete conList2;
    }
    @isTest 
    private static void testingConditionupdate()
    {
	     Account a= new Account(Name='testacc1');
        List<SE_Contact__c> conList3=[SELECT Id 
                                      FROM SE_Contact__c
                                      WHERE Account__c=:a.Id];
        System.assertEquals(1, conList3.size());
    	update conList3;
        
    }
    
}