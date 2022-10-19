@isTest
public with sharing class AccountTableTest {
    @testSetup static void setup() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        List<Contact> listContact = new List<Contact>();
        for(Integer i=0;i<5;i++) {
            listContact.add(new Contact(LastName = 'Test Contact'+i, AccountId = acc.Id));
        }
        insert listContact;
    }
    @isTest
    public static void testCon(){
        Account acc1=[select id from account where name ='Test Account'];
        List<Contact> con=[select Id,LastName,Email,Phone from contact where AccountId=:acc1.Id];
        System.debug('con value is====='+con+'-- con.Id -- '+acc1.Id);
        List<Contact> conList=AccountTable1.getContact (acc1.Id);
        System.debug('cont value>>>>>>>>>>>>='+conList);
        System.assertEquals(5,conList.size(),'may be error');
    }
    @isTest
    static void testGetContact(){
        Contact con = [Select Id, Name FROM Contact WHERE LastName = 'Test Contact1'];
        String idCon = con.Id;
        System.debug('==='  + idCon);
        List<Contact> conId = AccountTable1.getContact1(idCon);
        System.debug('===11'  + conId);
        System.assertEquals(1,conId.size(),'may be error');
    }
    @isTest
    public static void singleDelete()
    {
        Contact con =[select Id from contact where LastName='Test Contact1'];
        system.debug('contact con -- '+con);
        String conId=con.Id;
        system.debug('string conId -- '+conId);
        AccountTable1.deleteContact(conId);
        Integer count = [SELECT count() FROM Contact];
        system.debug('count -- '+count);
        system.assertEquals(4, count, 'msg error');
    }
    @isTest
    public static void singleEdit(){
        Contact conList=[SELECT Id,LastName,Email,Phone FROM contact WHERE LastName='Test Contact1'];
        conList.LastName='Manish';
        update conList;
        System.debug('conlist valieferf'+conList);
        String conId=conList.Id;
        System.debug('=12'+ conId );
        AccountTable1.UpdateContact(conList, conId);
        system.assertEquals('Manish', [SELECT LastName FROM Contact WHERE LastName='Manish'].LastName, 'Error msg');
    }
}