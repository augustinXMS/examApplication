public with sharing class ExamAppController {
    @AuraEnabled(cacheable=true)
    public static List<Exam__c> getExamList(Id recordId) {
       
        return [SELECT Id,Name,Datetime_of_Exam__c,Total_Score__c  from Exam__c WHERE Contact__c=:recordId ];
    }
    //map which will contain ExamId and Question 
    @AuraEnabled(cacheable=true)
    public static List<Question__c> getQuestionList(Id examId) {
        return [SELECT id,Name,Exam__r.Name,Score__c  FROM Question__c WHERE Exam__c=:examId];
    }
}