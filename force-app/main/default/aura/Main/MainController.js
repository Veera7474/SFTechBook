({
    doInit : function(component, event, helper) {
        $A.createComponent("c:CreateLoginForm", {
            
        }, function(newCmp) {
            if (component.isValid()) {
                component.set("v.body", newCmp);
            }
        });
    },
    NavigateComponent : function(component, event, helper) {
        if(event.getParam("navigate") == "true")
        {
            $A.createComponent("c:LoginSucess", {
                
            }, function(newCmp) {
                if (component.isValid()) {
                    component.set("v.body", newCmp);
                }
            });
        }
    },
    NavigateComponent1 : function(component, event, helper) {
        $A.createComponent("c:ForgetPassword", {
            
        }, function(newCmp) {
            if (component.isValid()) {
                component.set("v.body", newCmp);
            }
        });
    },
    NavigateComponent2 : function(component, event, helper) {
        $A.createComponent("c:RegisterForm", {
            
        }, function(newCmp) {
            if (component.isValid()) {
                component.set("v.body", newCmp);
            }
        }); 
    }
})