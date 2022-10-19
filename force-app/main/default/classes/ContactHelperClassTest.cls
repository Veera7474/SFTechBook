@isTest
public class ContactHelperClassTest
{
    @testSetUp
    static void TestSetup()
    {
        List<Case> listOfcase=new List<Case>();
        System.debug('listOfcase----->'+listOfcase);
        for(Integer i=1;i<=30;i++)
        {
            Case  caseList = new Case( Contact_Reason__c='Electrcity & Gas',RecordTypeId=Schema.SObjectType.case.getRecordTypeInfosByName().get('General').getRecordTypeId());
            listOfcase.add(caseList);
           
            Case  caseList1 = new Case( Contact_Reason__c='Voice Service',RecordTypeId=Schema.SObjectType.case.getRecordTypeInfosByName().get('Public').getRecordTypeId());
            listOfcase.add(caseList1);
        }
        insert listOfcase;
        System.debug('listOfcase'+listOfcase.size());
        System.assertEquals(60,listOfcase.size());
        
    }
    @isTest
    static void ContactReasonTest()
    {
        List<Case> newList=new List<Case>();
        Case[] newList1=[SELECT Contact_Reason__c
                         FROM Case
                         WHERE Contact_Reason__c='Electricity and Gas'];
        for(Case cl : newList1)
        {
            cl.Contact_Reason__c='Voice Service';
            newList.add(cl);
        }
        update newList;
        Case[] newList2=[SELECT Contact_Reason__c
                         FROM Case
                         WHERE Contact_Reason__c='Electricity and Gas'];
        system.debug('newList2---->'+newList2.size());
        System.assertEquals(0, newList2.size());
    }
    @isTest
    static void messageTest()
    {
        List<Case> list1=new List<Case>();
        Case[] list2=[SELECT Contact_Reason__c
                      FROM Case
                      WHERE Contact_Reason__c='Voice Service'];
        try{
            for(Case c1 : list2)
            {
                c1.Contact_Reason__c = 'Electricity and Gas';
                list1.add(c1);
            }
            update list1;
        }catch(Exception error)
        {
            System.assert(error.getMessage().contains('Update failed.'));
        }
    }
}