public class QuestionTriggerHelper {
    public static void calculateTotalExamScore(List<Question__c> Questions){
        Set<Id> examIdsToUpdate = new Set<Id>();
        try{
            //create a set of examIds which are required for update
            for (Question__c question : Questions) {
                if (question.Score__c != null || question.Exam__c != null) {
                    examIdsToUpdate.add(question.Exam__c);
                }
            }
            //update Total Score for each Exam where the Questions score was changed.
            if (!examIdsToUpdate.isEmpty()) {
                List<Exam__c> examsToUpdate = [
                    SELECT Id, (SELECT Score__c FROM Questions__r WHERE Score__c != null)
                    FROM Exam__c
                    WHERE Id IN :examIdsToUpdate
                ];
        
                for (Exam__c exam : examsToUpdate) {
                    Decimal totalScore = 0;
                    for (Question__c question : exam.Questions__r) {
                        totalScore += question.Score__c;
                    }
                    exam.Total_Score__c = totalScore;
                }
        
                update examsToUpdate;
            }
        }catch(Exception e){
            throw new AuraHandledException('Error on Updating Exam Score'+e.getMessage());
        }
    }
}