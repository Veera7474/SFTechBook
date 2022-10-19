import { LightningElement, track, wire } from 'lwc';
import getUserDetails from '@salesforce/apex/Userinput.getUserDetails';
export default class UserInput extends LightningElement 
{
    @track mapData = [];
    @track error;
     // Getting Contacts using Wire Service
     @wire(getUserDetails)
     contacts(result) {
         if (result.data) {
             console.log('data===>',JSON.stringify(this.mapData));
           var cont=result.data;
           for(var key in cont){
            this.mapData.push({value:cont[key], key:key}); //Here we are creating the array to show on UI.
        }
 
        }
     }
}