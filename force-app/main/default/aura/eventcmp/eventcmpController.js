({
    submitScoreAction123: function(component, event, helper) {
        var isValidate = true;
        
        var userName = component.find('userName');
        var userEmail = component.find('userEmail');
        var userPhone = component.find('userPhone');
        var userGender = component.find('userGender');
        var userDOB = component.find('userDOB');
        var userUserName = component.find('userUserName');
        var userPassword = component.find('userPassword');
        
        
        var userNameVal = component.find('userName').get('v.value');        
        var userEmailVal = component.find('userEmail').get('v.value');
        var userPhoneVal = component.find('userPhone').get('v.value');
        var userGenderVal = component.find('userGender').get('v.value');
        var userDOBVal = component.find('userDOB').get('v.value');
        var userUserNameVal = component.find('userUserName').get('v.value');
        var userPasswordVal = component.find('userPassword').get('v.value');
        
        
        
        if($A.util.isUndefinedOrNull(userNameVal) || $A.util.isUndefined(userNameVal) || $A.util.isEmpty(userNameVal)){
            userName.set("v.errors",[{message:'Name is required'}]);
            isValidate = false;
        }else{
            userName.set("v.errors",null);
        }        
        
        
        if($A.util.isUndefinedOrNull(userEmailVal) || $A.util.isUndefined(userEmailVal) || $A.util.isEmpty(userEmailVal)){
            userEmail.set("v.errors",[{message:'Email is required'}]);
            isValidate = false;
        }else{
            userEmail.set("v.errors",null);
        }
        
        
        if($A.util.isUndefinedOrNull(userPhoneVal) || $A.util.isUndefined(userPhoneVal) || $A.util.isEmpty(userPhoneVal)){
            userPhone.set("v.errors",[{message:'Phone is required'}]);
            isValidate = false;
        }else{
            userPhone.set("v.errors",null);
        }
        
        if(userGenderVal == '--None--'){
            userGender.set("v.errors",[{message:'Please select state option'}]);
            isValidate = false;
        }else{
            userGender.set("v.errors",null);
        }
        
        if($A.util.isUndefinedOrNull(userDOBVal) || $A.util.isUndefined(userDOBVal) || $A.util.isEmpty(userDOBVal)){
            userDOB.set("v.errors",[{message:'DOB is required'}]);
            isValidate = false;
        }else{
            userUserName.set("v.errors",null);
        }
        if($A.util.isUndefinedOrNull(userUserNameVal) || $A.util.isUndefined(userUserNameVal) || $A.util.isEmpty(userUserNameVal)){
            userUserName.set("v.errors",[{message:'UserName is required'}]);
            isValidate = false;
        }else{
            userUserName.set("v.errors",null);
        }
        if($A.util.isUndefinedOrNull(userPasswordVal) || $A.util.isUndefined(userPasswordVal) || $A.util.isEmpty(userPasswordVal)){
            userPassword.set("v.errors",[{message:'Password is required'}]);
            isValidate = false;
        }else{
            userPassword.set("v.errors",null);
        }
        
        if(isValidate){
            //alert('Form submitted successfully');
            
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title":"Success",
                "type":"success",
                "message":"Form submitted successfully.",                        
            });
            toastEvent.fire();
            
            $A.get('e.force:refreshView').fire();
        }
        
        
    },
    
    
})