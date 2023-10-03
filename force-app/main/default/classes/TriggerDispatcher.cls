public class TriggerDispatcher {

    public static void Run(TriggerInterface handler){
        
        // Check to see if the trigger has been disabled. If it has, return
        if (handler.IsDisabled()){
            return;
        }    

        //Detect the current trigger context and fire the relevant methods on the trigger handler:
        //Before trigger logic
        if (Trigger.IsBefore){
            
            if (Trigger.IsInsert){
                //Call the BeforeInsert method of the handler if the trigger event is isInsert and IsBefore.
                handler.BeforeInsert(trigger.new);
            }
            
            if (Trigger.IsUpdate){
                //Call the BeforeUpdate method of the handler if the trigger event is isUpdate and IsBefore.
                handler.BeforeUpdate(trigger.newMap, trigger.oldMap);
            }
            
            if (Trigger.IsDelete){
                //Call the BeforeDelete method of the handler if the trigger event is IsDelete and IsBefore.
                handler.BeforeDelete(trigger.oldMap);
            }
        }
        
        // After trigger logic
        if (Trigger.IsAfter){
           
            if (Trigger.IsInsert){
                
                //Call the AfterInsert method of the handler if the trigger event is IsAfter and IsInsert.
                handler.AfterInsert(Trigger.newMap);
            }
            
            if (Trigger.IsUpdate){
               
                //Call the AfterInsert method of the handler if the trigger event is IsAfter and IsInsert.
                handler.AfterUpdate(trigger.newMap, trigger.oldMap);
            }
            
            if (trigger.IsDelete){
                //Call the AfterDelete method of the handler if the trigger event is IsAfter and IsDelete.
                handler.AfterDelete(trigger.oldMap);
            }
            
            if (trigger.isUndelete){
                //Call the AfterUndelete method of the handler if the trigger event is IsAfter and isUndelete.
                handler.AfterUndelete(trigger.oldMap);
            } 
        }
    } 
}