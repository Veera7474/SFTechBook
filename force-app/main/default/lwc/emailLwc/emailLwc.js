import { LightningElement, track, wire } from 'lwc';
import sendEmail from '@salesforce/apex/EmailClass.sendEmail';
import getFolders from '@salesforce/apex/EmailClass.getFolders';
import getTemplates from '@salesforce/apex/EmailClass.getTemplates';
import getBody from '@salesforce/apex/EmailClass.getBody';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchContacts from '@salesforce/apex/EmailClass.searchContacts';
import getTemplatemergeData from '@salesforce/apex/EmailClass.getTemplatemergeData';

export default class SendEmail extends LightningElement {
    @track email;
    @track subject;
    @track body;
    @track folderId;
    @track selectedOption;
    @track error;
    @track optionsList=[];
    @track templateList=[];
    @track folderOption;
    @track templateId;
    @track nameStr;
    @track contactList='';
    @track disable = false;
    @track tempId;
    @track templateData=[];
    
    @wire(getFolders)
    Folders({ error, data }) {//to get the folder options
        if (data) {
            console.log('data',JSON.stringify(data));
            let arr=[];
            for(var key in data){
            arr.push({label:data[key], value:key}); //Here we are creating the array to show on UI.
            console.log('folderData--->',data[key]);
            console.log('folderId--->',key);
            if(data[key] === 'Unified Public Classic Email Template')
            {
                this.folderOption = data[key];
                console.log('FolderOption--->',this.folderOption);
            }
        }
            this.optionsList=arr;
        } else if (error) {
            this.error=error;
        }
    }
    get folderOptions()
    {
        return this.optionsList;
    }
     
    handleChangeComboBoxFolder(event) {
        this.folderId = event.detail.value;
        console.log('folders',this.folderId);
     }


    // @wire(getTemplates,{folderOption:'$folderId'})//After clicking the floder option i got id of particular folder id that passed into a apex class
    // wiredTemplates({data}){
    //     if(data){
    //     console.log('data--->',JSON.stringify(data));
        
    //     let arr=[];//to store the particular template options
    //    for(var i=0;i<data.length;i++)
    //    {
    //     arr.push({label:data[i].Name, value:data[i].Id});
    //     console.log('templateName--->',data[i].Name);
    //     console.log('templateId---->',data[i].Id);
    //    }
    //    this.templateList=arr;   //to store the one list what we pushed the template option one by one 
    //     }
    // }
    // get templateOptions()
    // {
    //     return this.templateList;
    // }
    // handleChangeTemplateComboBox(event) {
    //     this.templateId = event.detail.value;
    //     console.log('templateId',this.templateId);
    //  }
    @wire(getTemplates,{folderOption:'$folderId'})
    wiredTemplates({data}){
        if(data){
           console.log('data--->',JSON.stringify(data));
           this.templateData=data;
           console.log('template data---->',this.templateData);
        }
    }
    @wire(getBody,{templateOption:'$templateId'})
    wiredTemplateValue({data}){
        if(data){
            console.log('data--->',JSON.stringify(data));
            console.log('Id--->',data.Id);
            console.log('body--->',data.Body);
            console.log('subject--->',data.Subject);
            this.body=data.Body;
            console.log(' body--->', this.body);
            this.subject=data.Subject;
            console.log('subject--->', this.subject);
            

        }
        
    }
    searchBoxHandleChange(event){
        this.contactList = event.detail.value;
        console.log('Name-->',this.contactList);
        console.log('id',this.templateId);
        // getTemplatemergeData({emailTempId:this.templateId,mergeFieldObjId:this.contactList})
        // .then(result=>{
        //     console.log('DisplayBody--->',JSON.stringify(result));
        //     this.body=result.emailbody;
        //     console.log('finalBody--->',this.body);
        //     this.subject=result.subject;

        // });
        if(this.contactList!=''){
            this.disable=false;
        }
        
     }
    @wire(searchContacts,{nameStr:'$contactList'})  //accountname getting that id from search box
    wiredSearchValue({data}){
        if(data){
            console.log('data--->',JSON.stringify(data));
            var cont=data;
            var con =data;
            for(var key in cont){               
                this.email = cont[key];
                console.log('emaildata----->',this.email);
                }   
        } 
        if(JSON.stringify(data) === '{}'){   //contactlist empty or undefined name then will be to address is empty
            this.email='';
            this.disable=true;
            console.log('emptyemail--->',this.email);
            //console.log('button disable--->',this.disable);
        }
    }
    toAddressHandleChange(event) {
        
            this.email = event.target.value;//to address handdlechange
            console.log('Email--->',this.email);
        
    }
    subjectHandleChange(event) {
        
            this.subject = event.target.value;//subject handlechange
            console.log('Subject---->',this.subject);
    }
    handleBodyChange(event) {
        
            this.body = event.target.value;//bodyhandlechange
            console.log('Body---->',this.body);
        
    }
    sendEmailHandler(event) {
        // send mail
        console.log("Sending email to", this.email);//onclick send email handle
        sendEmail({ toAddress: this.email, subject: this.subject, body: this.body})
        .then(()=>{
            const event = new ShowToastEvent({
                title: 'Toast message',
                message: 'Mail send successfully...!',//after send the email toast meassage is comming
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            this.updateRecordView();//this method is used for records are updated automatically
        });
    }
    updateRecordView() {
        setTimeout(() => {
             eval("$A.get('e.force:refreshView').fire();");
        }, 1000);
     }
     @track isModalOpen = false;
    openModal() {
       
        this.isModalOpen = true;
    }
    closeModal() {
        
        this.isModalOpen = false;
    }
    submitDetails() {
       
        this.isModalOpen = false; 
        getTemplatemergeData({emailTempId:this.templateId,mergeFieldObjId:this.contactList})//here i am passing the 
        .then(result=>{
            console.log('DisplayBody--->',JSON.stringify(result));
            this.body=result.emailbody;//after clicking the submit button display the body 
            console.log('finalBody--->',this.body);
            this.subject=result.subject;//after clicking the submit button display the subject

        });
    }
   
    changeHandlerDropDown(event) {
    const field = event.target.name;
    if (field === 'optionSelect') {
        this.selectedOption = event.target.value;
            alert("you have selected : ",this.selectedOption);
        } 
    }
    templateselect(event){
        this.templateId=event.target.dataset.id;
    console.log('AWSDFGHJKL;-->',event.target.dataset.id);
    this.templateData.forEach(ele=>{
        console.log('element--->',ele);
        if(ele.Id == this.templateId){
            this.body=ele.Body;
            console.log('eleBody--->',this.body);
            this.subject=ele.Subject;
            console.log('elesubject',this.subject);
        }
    });
    }

}