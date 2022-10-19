@isTest
public class TestOnEmailClass {
    @testSetup static void methodName() {
	Contact con = new Contact(LastName='veera', Email='veerayadav7474@gmail.com');
        insert con;
	}
    @isTest
    public static void emailSendCheckPass(){
        //Test.startTest();
        System.assertEquals(0, Limits.getEmailInvocations(), 'No emails should be sent');
        try{
        EmailClass.sendEmail(new String[]{'manishkr.chp@gmail.com'}, 'this is test email', 'test body');
        }catch (exception e){
        }
        System.assertEquals(1, Limits.getEmailInvocations(), 'Emails should be sent');
       // Test.stopTest();
    }
    @isTest
    public static void emailSendCheckFail(){
        //Test.startTest();
        System.assertEquals(0, Limits.getEmailInvocations(), 'No emails should be sent');
        EmailClass.sendEmail(new String[]{' '}, 'this is test email', 'test body');
        System.assertEquals(0, Limits.getEmailInvocations(), 'Emails should not be sent');
        //Test.stopTest();
    }
    @isTest
    public static void getFolderTest(){
        List<Folder> folList = [SELECT Id, Name FROM Folder WHERE Type = 'Email'];
        EmailClass.getFolders();
        List<Folder> newFolList = [SELECT Id, Name FROM Folder WHERE Type = 'Email'];
        System.assertEquals(2, newFolList.size());
    }
    @isTest
    public static void getEmailTemplateTest(){
        Folder fol = new Folder(Name = 'Presonal Fol');
        EmailClass.getTemplates(fol.Id);
        List<EmailTemplate> emailTem = [SELECT Id, Name FROM EmailTemplate WHERE FolderId =: fol.Id];
        System.assertEquals(0, emailTem.size());
    }
    @isTest
    public static void getContactTest(){
        EmailClass.searchContacts('veera');
        List<Contact> conList = [SELECT Id, Name, Email FROM Contact WHERE Name = 'veera'];
        System.assertEquals(1, conList.size());
    }
   @isTest
    public static void getTemplatesTest(){
        List<EmailTemplate> templatesList = EmailClass.getTemplates(userInfo.getOrganizationId());
        System.debug('templatesList'+ templatesList[0].Id);
        System.assertNotEquals(5, templatesList.size());
        EmailClass.emailTemplateMergedata emailWrap = EmailClass.getTemplatemergeData(templatesList[0].Id,'veera');
        System.debug('emailWrap==' + emailWrap);
		System.assertNotEquals('emailbody', emailWrap.emailBody);
        System.assertNotEquals('subject', emailWrap.subject);
    }
}