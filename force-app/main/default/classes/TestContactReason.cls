@isTest
public class TestContactReason {
    @testSetUp
    static void TestSetup(){
        List<Case> c=new List<Case>();
        List<Task> listTask = new List<Task>();
        System.debug('c'+c);
        for(Integer i=1;i<=20;i++){
        Case  cList = new Case( Contact_Reason__c='Electricity and Gas',RecordTypeId=Schema.SObjectType.case.getRecordTypeInfosByName().get('General').getRecordTypeId());
            c.add(cList);
        }
        insert c;
        System.assertEquals(20,c.size());
        System.debug(c);
    }
    @isTest
    static void ContactReasonTest(){
        List<Case> newList=new List<Case>();
        Case[] newList1=[SELECT Contact_Reason__c
                       FROM Case
                       WHERE Contact_Reason__c='Electricity and Gas'];
        for(Case c : newList1){
            c.Contact_Reason__c='Voice Service';
            newList.add(c);
        }
        update newList;
        Case[] newList2=[SELECT Contact_Reason__c
                         FROM Case
                         WHERE Contact_Reason__c='Electricity and Gas'];
        system.debug(newList2);
        System.assertEquals(0, newList2.size());
    }
}