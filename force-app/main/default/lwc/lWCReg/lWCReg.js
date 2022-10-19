import { LightningElement, track } from 'lwc';
// import NAME_FIELD from '@salesforce/schema/User.Name';
// import EMAIL_FIELD from '@salesforce/schema/User.Email';
// import MOBILE_FIELD from '@salesforce/schema/User.Mobile';
// import GENDER_FIELD from '@salesforce/schema/User.Gender';
// //import DOB_FIELD from '@salesforce/schema/User.DOB__c';
// import USERNAME_FIELD from '@salesforce/schema/User.UserName';
// import PASSWORD_FIELD from '@salesforce/schema/User.Password';
// import submitScoreAction from '@salesforce/apex/LWCRegApex.submitScoreAction';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';



export default class LWCRegApex extends LightningElement {
    @track Name = NAME_FIELD;
    @track Email = EMAIL_FIELD;
    @track Mobile = MOBILE_FIELD;
    @track Gender = GENDER_FIELD;
    @track DOB = DOB_FIELD;
    @track UserName = USERNAME_FIELD;
    @track Password = PASSWORD_FIELD;
    
    User = {};

    userObj = {
      Name : this.Name,
      Email : this.Email__c,
      Mobile : this.Mobile__c,
      Gender : this.Gender__c,
      DOB : this.DOB__c,
      UserName : this.UserName__c,
      Password : this.Password__c,
      
  }

  handleChangeName(event){
         
        this.userObj.Name = event.target.value;
        console.log("userName", this.userObj.Name);
        }
        handleChangeEmail(event){
         
          this.userObj.Email__c = event.target.value;
          console.log("userEmail", this.userObj.Email__c);
          }

          handleChangeMobile(event){
         
            this.userObj.Mobile__c = event.target.value;
            console.log("userMobile", this.userObj.Mobile__c);
            }
            @track value='';

            get options() {
                return [
                    { label: 'Others', value: 'Others' },
                    { label: 'Male', value: 'Male' },
                    { label: 'Female', value: 'Female' },
                ];
            }
        
            handleChangeGender(event) {
                this.value = event.detail.value;
            }
              handleChangeDOB(event){
         
                this.userObj.DOB__c = event.target.value;
                console.log("userDOB", this.userObj.DOB__c);
                }
                handleChangeUserName(event){
         
                  this.userObj.UserName__c = event.target.value;
                  console.log("userUserName", this.userObj.UserName__c);
                  }
                  handleChangePassword(event){
         
                    this.userObj.Password__c = event.target.value;
                    console.log("userPassword", this.userObj.Password__c);
 }
 submitAction() {
   var fields = {
              Name : this.Name,
              Email : this.Email__c,
              Mobile : this.Mobile__c,
              Gender : this.Gender__c,
              DOB : this.DOB__c,
              UserName : this.UserName__c,
              Password : this.Password__c
             
          };

        if (this.validationforRec()) {
         
          submitScoreAction({ userDetailsObj : this.userObj})
          .then(result => {
              this.userObj={};
              this.updateRecordView();
                  this.dispatchEvent(
                      new ShowToastEvent({
                          title: 'Success',
                          message: 'Record Created',
                          variant: 'success',
                      }),
                  );
          })
          .catch(error => {
              this.message = undefined;
              this.error = error;
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Error creating record',
                      message: 'error.body.message contact',
                      variant: 'error',
                  }),
              );
              console.log("error", JSON.stringify(this.error));
          });
      }
  }
  updateRecordView(){
      setTimeout(() => {
           eval("$A.get('e.force:refreshView').fire();");
      }, 0);
  }
  validationforRec(){
    console.log('tested ');
    let isValid = true;
        let inputFields = this.template.querySelectorAll('.reqInpFld');
        console.log('inputFields ',inputFields);
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
            this.User[inputField] = inputField.value;
        });
        return isValid;
  }
    
 }