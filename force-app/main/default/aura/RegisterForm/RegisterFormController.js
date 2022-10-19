({
    submit: function(component, event) {
        var isValidate = true;
        
        var Name = component.find('Name');
        var Email = component.find('Email');
        var Phone = component.find('Phone');
        var Gender = component.find('Gender');
        var DOB = component.find('DOB');
        var UserName = component.find('UserName');
        var Password = component.find('Password');
           var newcon = component.get("v.UserDetails");
        var action = component.get("c.newUser");
        var NameVal = component.find('Name').get('v.value');        
        var EmailVal = component.find('Email').get('v.value');
        var PhoneVal = component.find('Phone').get('v.value');
        var GenderVal = component.find('Gender').get('v.value');
        var DOBVal = component.find('DOB').get('v.value');
        var UserNameVal = component.find('UserName').get('v.value');
        var PasswordVal = component.find('Password').get('v.value');
        
        
        
        if($A.util.isUndefinedOrNull(NameVal) || $A.util.isUndefined(NameVal) || $A.util.isEmpty(NameVal)){
            Name.set("v.errors",[{message:'Name is required'}]);
            isValidate = false;
        }else{
            Name.set("v.errors",null);
        }        
        
        
        if($A.util.isUndefinedOrNull(EmailVal) || $A.util.isUndefined(EmailVal) || $A.util.isEmpty(EmailVal)){
            Email.set("v.errors",[{message:'Email is required'}]);
            isValidate = false;
        }else{
            Email.set("v.errors",null);
        }
        
        
        if($A.util.isUndefinedOrNull(PhoneVal) || $A.util.isUndefined(PhoneVal) || $A.util.isEmpty(PhoneVal)){
            Phone.set("v.errors",[{message:'Phone is required'}]);
            isValidate = false;
        }else{
            Phone.set("v.errors",null);
        }
        
        if(GenderVal == '--None--'){
            Gender.set("v.errors",[{message:'Please select Gender option'}]);
            isValidate = false;
        }else{
            Gender.set("v.errors",null);
        }
        
        if($A.util.isUndefinedOrNull(DOBVal) || $A.util.isUndefined(DOBVal) || $A.util.isEmpty(DOBVal)){
            DOB.set("v.errors",[{message:'DOB is required'}]);
            isValidate = false;
        }else{
            UserName.set("v.errors",null);
        }
        if($A.util.isUndefinedOrNull(UserNameVal) || $A.util.isUndefined(UserNameVal) || $A.util.isEmpty(UserNameVal)){
            UserName.set("v.errors",[{message:'UserName is required'}]);
            isValidate = false;
        }else{
            UserName.set("v.errors",null);
        }
        if($A.util.isUndefinedOrNull(PasswordVal) || $A.util.isUndefined(PasswordVal) || $A.util.isEmpty(PasswordVal)){
            Password.set("v.errors",[{message:'Password is required'}]);
            isValidate = false;
        }else{
            Password.set("v.errors",null);
        }
    
  if(isValidate){
            action.setParams({
                "Details":newcon
            });
       action.setCallback(this, function(a) {
                var state = a.getState();
                console.log('state ',state);
                if (state === "SUCCESS") {
                    a.getReturnValue();
                    alert("Registration Successfull");
                }
                else{
                }
            });
            
            $A.enqueueAction(action)
        }
    },  
})