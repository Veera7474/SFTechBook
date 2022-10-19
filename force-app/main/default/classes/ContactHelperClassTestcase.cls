@isTest
private class ContactHelperClassTestcase 
{
	@testSetup
    static void setup()
    {
        Case listOfCase=new Case();
        listOfCase.Contact_Reason__c='List Of Support manegment';
        listOfCase.RecordTypeId=Schema.SObjectType.Case.getRecordTypeInfosByName().get('General').getRecordTypeId();
        insert listOfCase;
        System.debug('listOfCase------>'+listOfCase);
    }
}