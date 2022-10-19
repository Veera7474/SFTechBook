import { LightningElement,track} from 'lwc';
export default class LOGIN extends LightningElement {
UserName;
Password;
@track errorCheck;
@track errorMessage;

handleChangeUserName(event){

    this.UserName = event.target.value;
}

handleChangePassword(event){
    
    this.Password = event.target.value;
}
handleChangeLoginButton(event){

    if(this.username && this.password){

     event.preventDefault();

     doLogin({ UserName: this.UserName, Password: this.Password })
         .then((result) => {
             
             window.location.href = result;
         })
         .catch((error) => {
             this.error = error;      
             this.errorCheck = true;
             this.errorMessage = error.body.message;
         });

     }

 }

}