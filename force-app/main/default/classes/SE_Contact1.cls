@isTest
public class SE_Contact1
{
    @isTest
    private static void testingConditionInsert()
    {
        List<SE_Contact__c> conList1=new List<SE_Contact__c>();
        for(Integer i=1;i<=2;i++)
        {
          SE_Contact__c c=new SE_Contact__c();
            c.SName__c='Test'+ i;
            c.Id='Account__c'+i;
            conList1.add(c);
        }
        insert conList1;
    }    
    
}