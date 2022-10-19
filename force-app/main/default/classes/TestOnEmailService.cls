@isTest
public class TestOnEmailService{
     @testSetUp
    public static void EmailAttachmentTester(){
        System.debug('Im starting a method');
        List<Contact> conList=new List<Contact>();
        conList.add(new Contact(LastName='veertest', Phone='12345', Email='veerayadav747@gmail.com'));
        insert conList;   
    }
    @isTest
    public static void emailSending(){
        
         // Create a new email, envelope object and Attachment
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        envelope.fromAddress='veerayadav7474@gamil.com';
        email.plainTextBody='Name:veeranjaneyulujonnalagadda1 Phone:81814838541 Email:81814838541@gmail.com\n';
        
        //Create a object by using apex class
        CreateContactFrmEmail1 objconfirm = new CreateContactFrmEmail1();
        Test.startTest();
        Messaging.InboundEmailResult result = objconfirm.handleInboundEmail(email,envelope);
        Test.stopTest();
        System.assertEquals(true,result.success); 
        List<Contact> conList = [SELECT Id FROM Contact WHERE LastName='veeranjaneyulujonnalagadda1'];
        system.debug('conId--->'+conList);
        system.assertEquals(1,conList.size(),'error message');   
    }
    @isTest
    Public static void insertContact(){
        List<Contact> conId = [SELECT Id FROM Contact WHERE LastName = 'veertest'];
        system.debug('conId--->'+conId);
        system.assertEquals(1,conId.size(),'error message');
    }
}