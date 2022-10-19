public class CustomForm {
    public Student_Details__c conlist{get;set;}
    public CustomForm(){
        conlist=new Student_Details__c();
    }
    public pagereference Save(){
        insert conlist;
        return new pagereference('/'+conlist.id);
    }
    
}