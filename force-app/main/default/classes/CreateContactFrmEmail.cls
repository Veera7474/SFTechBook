global class CreateContactFrmEmail implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
                                                    Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String plainTextBody = Email.plainTextBody;
         system.debug('plainTextBody'+plainTextBody);                                               
            Contact c = new Contact();                                         
            c.LastName = plainTextBody.subStringBetween('<LastName>','</LastName>');
            c.Phone = plainTextBody.subStringBetween('<Phone>','</Phone>');
            c.Email = plainTextBody.subStringBetween('<Email>','</Email>');
            Database.SaveResult insertContactRecord = Database.insert(c);
           
            System.debug('c'+c);
            return result;
   }
}