Public class CreateContactFrmEmail1 implements Messaging.InboundEmailHandler {
    public String lastName1 = ' ';
    public String Phone123 = ' ';
    public String Email123 = ' ';
            Public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
                                                            Messaging.InboundEnvelope envelope) {
                Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
                string emailBody = email.plainTextBody;
                if(email.plainTextBody!=null)
                {
                    if(emailBody.containsIgnoreCase (getParsedValue('',emailBody,':'))) {
                        string name1 = getParsedValue('',emailBody,':');
                        lastName1 = getParsedValue(name1,emailBody,' ');
                        String temp = name1+lastName1;
                        emailBody = emailBody.remove(temp);
                        System.debug('The lastName '+lastName1);
                    }
                    
                    if(emailBody.containsIgnoreCase (getParsedValue('',emailBody,':'))) {
                        string Phone1=getParsedValue('', emailBody,':');
                        Phone123 = getParsedValue(Phone1,emailBody,' ');
                        String temp = Phone1+Phone123;
                        emailBody = emailBody.remove(temp);
                        System.debug('The Phone '+Phone123);
                    }
                     
                    if(emailBody.containsIgnoreCase (getParsedValue('',emailBody,':'))) {
                        String Email1=getParsedValue('',emailBody,':');
                        Email123 = getParsedValue(Email1,emailBody, ' ');
                        System.debug('The Email123 '+Email123);
                    }
                    
                }
                Contact con = new Contact();
                con.LastName = lastName1;
                con.Phone = Phone123;
                con.Email = Email123;
                system.debug('con->'+con);
                insert con;  
                system.debug('con--->'+con);
                result.success=true;
                result.message='Your contact has been created sucessfully..';
                return result;
                
                
    }
    public static String getParsedValue(String fieldName, String emailBody, String indexOfChar){
        String fieldNameStr = emailBody.substringAfter(fieldName);
        Integer endChar = fieldNameStr.indexOf(indexOfChar);
        String returnStr = fieldNameStr.substring(0,(endChar+1));
        System.debug('returnStr: '+returnStr);
        return returnStr;
    }
}