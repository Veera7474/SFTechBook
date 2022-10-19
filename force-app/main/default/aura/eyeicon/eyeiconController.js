({
    togglePassword : function(component, event, helper) {
        if(component.get("v.showpassword",true)){
            component.set("v.showpassword",false);
        }else{
            component.set("v.showpassword",true);
        }
    }
})