import { LightningElement, api, track, wire} from 'lwc';
import getContact from '@salesforce/apex/AccountTable.getContact';
import getContact1 from '@salesforce/apex/AccountTable.getContact1';
import deleteContact from '@salesforce/apex/AccountTable.deleteContact';
import UpdateContact from '@salesforce/apex/AccountTable.UpdateContact';
import deleteSeletedCon from '@salesforce/apex/AccountTable.deleteSeletedCon';
import {deleteRecord} from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { NavigationMixin } from 'lightning/navigation';
export default class contactList  extends LightningElement {
    @api recordId;
    @track contactLists = [];
    @track contactLists1 = [];
    @track columns = [];
    @track bShowModal = false;
    @track deleteShowModal = false;
    @track selectedId;
    @api deleteIdList =[];

    @wire(getContact, { accId: '$recordId' })
    WireContactRecords({ error, data }) {
        if (data) {
            this.contactLists = data;
        } else if (error) {
            this.error = error;
        }
        this.updateRecordView();
       //return refreshApex(this.WireContactRecords);
    }
    @wire(getContact1, { contactId: '$selectedId' })
    WireContactRecords1({ error, data }) {
        if (data) {
            this.contactLists1 = data;
        } else if (error) {
            this.error = error;
        }
      //  return refreshApex(this.contactLists1);
      this.updateRecordView();
    }
    showModalBox(event){
        // open modal box
        this.bShowModal = true;
        this.isEditForm = true;
        // assign record id to the record edit form
        this.selectedId = event.target.value;
        console.log('sel== ' + this.selectedId);
    }
    closeModalBox(){
        this.bShowModal = false;
    }
    getCon={
        FirstName :this.FirstName,
        LastName : this.LastName,
        Email : this.Email,
        Phone : this.Phone,
        Description : this.Description
    }
    LeadSourceChange(event){
        this.getCon.LeadSource = event.target.value;
        console.log("LeadSource", this.getCon.LeadSource);
    }
    DescriptionChange(event){
        this.getCon.Description = event.target.value;
        console.log("Description", this.getCon.Description);
    }
    FirstNameChange(event) {
        this.getCon.FirstName = event.target.value;
        console.log("Fname", this.getCon.FirstName);
    }
          LastNameChange(event) {
            this.getCon.LastName = event.target.value;
            console.log("Lname", this.getCon.LastName);
        }
        EmailChange(event) {
          this.getCon.Email = event.target.value;
          console.log("Email", this.getCon.Email);
      }
      MobileChange(event) {
        this.getCon.Mobile = event.target.value;
        console.log("Mobile", this.getCon.Mobile);
      }
    saveModalBox(event){
        this.bShowModal = true;
        const isInputsCorrect = [
            ...this.template.querySelectorAll('.validate')
          ].reduce((validSoFar, inputField) => {
            inputField.reportValidity();
            return validSoFar && inputField.checkValidity();
          }, true);
          if (isInputsCorrect) {
            var fields = {
                Name : this.Name,
            };
          //this.bShowModal = true;
        //var contactId = event.target.value;
        //console.log("contactId---------->",contactId )
        UpdateContact({con: this.getCon, conId: this.selectedId})
         .then(() => {
            this.updateRecordView();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record Update',
                    variant: 'success'
                })
            );
            this.bShowModal = false;
            // refreshing table data using refresh apex
            //return refreshApex(this.WireContactRecords);
            // eval("$A.get('e.force:refreshView').fire();");
         })
        }
    }
    // handleSuccess() {
    //    return refreshApex(this.WireContactRecords1);
    // }
    //here i'm fetching the recordid and deleting the record
    deleteContact1(currentRow){
        var contactId = currentRow.target.value;
        console.log("contactId---------->",contactId )
        deleteContact({conId: contactId})
         .then(() => {
            this.updateRecordView();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record deleted',
                    variant: 'success'
                })
            );
            //return this.refresh();
            // refreshing table data using refresh apex
           // refreshApex(this.WireContactRecords);
         })
        .catch(error => {
            console.log("Unable to delete the records due to " + error.body.message);
        });
    }
    updateRecordView(){
        setTimeout(() => {
             eval("$A.get('e.force:refreshView').fire();");
        }, 0);
    }
    // Select the all rows
    selectAll(event){
        let rowsSelected=this.template.querySelectorAll('lightning-input')
        for(let i=1;i<rowsSelected.length;i++){
            if(rowsSelected[i].type==='checkbox'){
                rowsSelected[i].checked=event.target.checked;
                console.log('rows',rowsSelected[i].checked);
            }
        }
        for(let i=1;i<rowsSelected.length;i++){
           if(rowsSelected[i].checked==true){
                console.log('val',rowsSelected[i].value);
                var deleteHelper=rowsSelected[i].value;
                console.log('deleteHelper',deleteHelper);
                this.deleteIdList.push(deleteHelper);
                console.log('list',this.deleteIdList);
           }else{
            this.deleteIdList.pop();
            console.log('list',this.deleteIdList);
           }  
        }
    }
    selectedRow(event){
        let selectedRow = this.template.querySelector('lightning-input');
        if(selectedRow.type ==='checkbox'){
            var isSelected = event.target.checked;
            console.log("isselected---->"+isSelected);
        }
        if(isSelected==true){
            this.deleteId= event.target.value;
            console.log('deleteId',this.deleteId);
            this.deleteIdList.push(this.deleteId);
            console.log("Id--->"+this.deleteIdList);
        }
        if(isSelected==false){
            this.deleteIdList.pop(this.deleteId);
            console.log("Id--->"+this.deleteIdList);
        }
    }
    
    deleteSelectedItems(event){
            this.deleteShowModal = true;
        }
        cancelModalBox(){
            this.deleteShowModal = false;
        }
    deleteAll(){
        deleteSeletedCon({deleterecord: this.deleteIdList})
            .then(() => {
            this.deleteShowModal = false;
            this.updateRecordView();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record deleted',
                    variant: 'success'
                })
            );
            //return this.refresh();
            // refreshing table data using refresh apex
            // refreshApex(this.WireContactRecords);
            })
        .catch(error => {
            console.log("Unable to delete the records due to " + error.body.message);
        });
    }
    
}