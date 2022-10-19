@isTest
public class TestCustomSendEmails1 {
    @isTest
    public static void emailSendCheckPass(){
        Test.startTest();
        System.assertEquals(0, Limits.getEmailInvocations(), 'No emails should be sent');
        EmailClass.sendEmail(new String[]{'manishkr.chp@gmail.com'}, 'this is test email', 'test body');
        System.assertEquals(1, Limits.getEmailInvocations(), 'Emails should be sent');
        Test.stopTest();
    }
}