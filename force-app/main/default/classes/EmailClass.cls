public with sharing class EmailClass {
    @AuraEnabled
   public static void sendEmail(List<String> toAddress, String subject, String body) {
       Messaging.reserveSingleEmailCapacity(1);
       try{
       messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
       System.debug(toAddress);
       System.debug(body);
       System.debug(subject);
       // toAddress.add('er.rajat15@gmail.com');
       mail.setToAddresses(toAddress);
       mail.setReplyTo('no-reply@xooa.com');
       mail.setSenderDisplayName('Your name here');
       mail.setSubject(subject);
       mail.setHtmlBody(body);
       // mail.setEntityAttachments(files);
       Messaging.sendEmail(new List<messaging.SingleEmailMessage> {mail});
       }
       catch (exception e){
           throw new AuraHandledException(e.getMessage());
           //return null;
       }
   }
  //@AuraEnabled
   //public static List<Folder> getFolders(){
    //return[SELECT Id,Name FROM Folder];
   //}
   @AuraEnabled(cacheable = true)
   public static Map<Id,String> getFolders()
   {
    Map<Id,String> mapOfFolders = new Map<Id,String>();
    mapOfFolders.put(UserInfo.getOrganizationId(),'Unified Public Classic Email Template');
    for(Folder folderObj : [SELECT Id , Name , DeveloperName, Type FROM Folder WHERE Type ='Email'])
    {
        mapOfFolders.put(folderObj.Id,folderObj.Name);
    }
    System.debug('mapOfFolderId---->'+mapOfFolders);
    return mapOfFolders;
    
   }
   @AuraEnabled(cacheable = true)
   public static List<EmailTemplate> getTemplates(Id folderOption)
   {
    return [SELECT Id, Name, Subject, Body, folderId FROM EmailTemplate WHERE folderId =:folderOption];
   }
   @AuraEnabled(cacheable = true)
   public static EmailTemplate getBody(Id templateOption)
   {
    return [SELECT Id, Subject, Body FROM EmailTemplate WHERE Id=:templateOption];
   }
   @AuraEnabled(cacheable = true)
   public static Map<Id,String> searchContacts(String nameStr)
   {
      Map<Id,String> mapOfContacts = new Map<Id,String>();
      for(Contact con : [SELECT Id, Name,Email FROM Contact
                        WHERE Id=:[SELECT Id FROM Contact WHERE Name=:nameStr]]){
                            mapOfContacts.put(con.Id,con.Email);
                        }
        System.debug(mapOfContacts);
        return mapOfContacts;
   }
   @AuraEnabled
         public static emailTemplateMergedata getTemplatemergeData(Id emailTempId,String mergeFieldObjId){
            String emailbody='';
            String subject='';
            system.debug('emailTempId--->'+emailTempId);
            system.debug('mergeFieldObjId--->'+mergeFieldObjId);
            if (emailTempId != null || emailTempId != '') {
                Contact conObj=[SELECT Id,Name,Email
                                FROM Contact
                                WHERE Id=:[SELECT Id FROM Contact WHERE Name=:mergeFieldObjId]];
               system.debug('conObj---->'+conObj);
                 Messaging.reserveSingleEmailCapacity(1);
                Messaging.SingleEmailMessage tempEmail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[]{'invalid@email.es'};
                tempEmail.setToAddresses(toAddresses);
                tempEmail.setTemplateId(emailTempId);
                tempEmail.setTargetObjectId(conObj.Id);
                SavePoint sp=Database.setSavePoint();
                List<Messaging.SendEmailResult> results;
                results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {tempEmail});
                if(String.isNotBlank (tempEmail.getSubject())){
                    subject = tempEmail.getSubject();
                }
                if(String.isNotBlank(tempEmail.getHtmlBody())){
                    emailbody = tempEmail.getHtmlBody();
                }
                else{
                    emailbody=tempEmail.getPlainTextBody();
                }
                Database.rollback(sp);
            }
            emailTemplateMergedata emailWrap = new emailTemplateMergedata();
            emailWrap.subject = subject;
            emailWrap.emailbody = emailbody;
            system.debug('emailWrap---->'+emailWrap);
            return emailWrap;
         }
         public class emailTemplateMergedata{
            @AuraEnabled
            public String subject{get;set;}
            @AuraEnabled
            public String emailbody{get;set;}
         }
}