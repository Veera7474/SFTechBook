@isTest
public class TestClassForBatchApex
{
    @testSetUp
    public static void TestSetup()
    {
        Contact c=new Contact();
        c.LastName='veeranjaneyulu';
        c.Email='veerayadav7474@gmail.com';
        insert c;
        System.debug('c-------->'+c);
        List<Case> listOfCase=new List<case>();
        
        for(Integer i=1;i<=5;i++)
        {
            Case  caseObj = new Case(Contact_Reason__c='Electrcity & Gas',RecordTypeId=Schema.SObjectType.case.getRecordTypeInfosByName().get('General').getRecordTypeId(),createdDate=date.Today()-70,ContactId=c.Id);
            listOfCase.add(caseObj);
        }
        insert listOfCase; //Electrcity & Gas
        System.debug('listOfCase------>'+listOfCase);
        
    }
    @isTest
    Public static void updateMethod()
    {
        
        List<Case> newList1=[SELECT Contact_Reason__c,status
                             FROM Case
                             WHERE Contact_Reason__c='Electrcity & Gas'];
        for(case c: newList1)
        {
            c.Status='closed';            
        }
        update newList1;
        Test.startTest();
        
        BatchOnCase bc=new BatchOnCase();
        Database.executeBatch(bc);
        Test.stopTest(); 
        List<Case> newList2=[SELECT Contact_Reason__c,status
                             FROM Case
                             WHERE Contact_Reason__c='Electrcity & Gas'];
        System.assertEquals('closed',newList1[0].Status);
        
    }
}