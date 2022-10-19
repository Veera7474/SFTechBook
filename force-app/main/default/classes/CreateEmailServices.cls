Public class CreateEmailServices implements Messaging.InboundEmailHandler {
    Public String LastName = ' ';
    Public String Phone = ' ';
    Public String Email1 = ' ';
            Public Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
                                                            Messaging.InboundEnvelope envelope) {
                Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
                string emailBody = email.plainTextBody;
                if(email.plainTextBody!=null)
                {
                    if(emailBody.containsIgnoreCase('Name:')) {
                        LastName = getParsedValue('LastName:', emailBody, '\n');
                        System.debug('The lastName '+LastName);
                    }
                    system.debug('emailBody'+emailBody);
                    if(emailBody.containsIgnoreCase('Phone:')) {
                        Phone = getParsedValue('Phone:', emailBody, '\n');
                        System.debug('The Phone '+Phone);
                    }
                     system.debug('emailBody'+emailBody);
                    if(emailBody.containsIgnoreCase('Email1:')) {
                        Email1 = getParsedValue('Email1:', emailBody, '\n');
                        System.debug('The Email1 '+Email1);
                    }
                }
                return result;
    }
    public static String getParsedValue(String fieldName, String emailBody, String indexOfChar){
        String fieldNameStr = emailBody.substringAfter(fieldName);
        Integer endChar = fieldNameStr.indexOf(indexOfChar);
        String returnStr = fieldNameStr.substring(0, endChar);
        System.debug('returnStr: '+returnStr);
        return returnStr;
    }
}