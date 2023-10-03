public class QuestionTriggerHandler implements TriggerInterface {
    // Allows unit tests (or other code) to disable this trigger for the transaction
    public static Boolean TriggerDisabled = false;
    
    public Boolean IsDisabled(){
        return TriggerSettings__mdt.getInstance('QuestionTrigger').isDisabled__c;  
    }
    public void BeforeInsert(List<SObject> newItems) {
    }
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
    }
    public void BeforeDelete(Map<Id, SObject> oldItems) {
    }
    public void AfterInsert(Map<Id, SObject> newItems) { 
        List<Question__c> Questions =newItems.values();
        QuestionTriggerHelper.calculateTotalExamScore(Questions);
    }
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        List<Question__c> Questions =newItems.values();
        QuestionTriggerHelper.calculateTotalExamScore(Questions);  
    }
    public void AfterDelete(Map<Id, SObject> oldItems) {   
    }
    public void AfterUndelete(Map<Id, SObject> oldItems) {
    }
}