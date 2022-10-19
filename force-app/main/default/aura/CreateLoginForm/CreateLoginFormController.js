({
    buttonFunction : function(component, event,helper) 
    {
        var name=component.find("Username").get("v.value");
        var pass=component.find("Password").get("v.value");
        if(name=="veera" && pass=="veera")
        {    
            var event = $A.get("e.c:navigateToCmp");
            event.setParams
            ({
                "navigate" : "true"
            });
            event.fire();
        }
        else
        {
            alert("Enter the valid Username & Password");  
            component.find("Username").set("v.value",null);
            component.find("Password").set("v.value",null);
            
        }
        
    },
   ForgetPassword : function(component, event,helper){
        var event = $A.get("e.c:ForgetPasswordEvent");
        event.fire();
    },
    RegisterNewUser : function(component, event,helper){
        var event = $A.get("e.c:RegisterNewUserEvent");
        event.fire();
    }
    
})