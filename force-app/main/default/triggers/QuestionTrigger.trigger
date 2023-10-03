trigger QuestionTrigger on Question__c (before insert,after insert,before update,after update,before delete,after delete,after undelete) {
    TriggerDispatcher.Run(new QuestionTriggerHandler());

}