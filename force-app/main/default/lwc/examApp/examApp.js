import { LightningElement, api, wire, track } from 'lwc';
import getExamList from "@salesforce/apex/ExamAppController.getExamList";
import getQuestionList from "@salesforce/apex/ExamAppController.getQuestionList";
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class ExamApp extends LightningElement {
    @api recordId;
    @track questionList=[];
    @track examList=[];
    @track newExamList=[];
    @track averageScore;
    @track questionVisibility = {};
    @track examListShow = false;
    columnList = [
        {label:"QuestionName", fieldName:"Name"},
        {label:"Score", fieldName:"Score__c"}
    ];
    @wire(getExamList, { recordId: '$recordId'})
    examList({ data }) {
        if(data){
            let tscore=0;
            let count=0;
            this.examList=data;
            for (let i=0; i < this.examList.length; i++) {
                this.examListShow=true;
                this.newExamList[i]=JSON.parse(JSON.stringify(this.examList[i]))
                if(this.newExamList[i].Total_Score__c)
                {
                    tscore+=this.newExamList[i].Total_Score__c;
                    count++;
                }
            }
            this.averageScore=tscore/count;
        }
        
    }
    
    handleClick(event){
        let examId=event.target.dataset.examId;
        getQuestionList({ examId : examId})
        .then(result=>{
            this.questionList=result;
            if(this.questionList.length>0){
                this.questionList=result; 
                for (let i=0; i < this.newExamList.length; i++) {
                    if(this.newExamList[i].Id == examId){
                        this.newExamList[i].show=!this.newExamList[i].show;
                    }
                    else{
                        this.newExamList[i].show=false;
                        
                    }
                }             
            }else{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'No Questions available',
                        variant: 'success'
                    }),
                );
            }
        })
        .catch(error=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error,
                    variant: 'error'
                }),
            );
        })   
    }
    get averageScoreShow(){
        if(this.averageScore>0){
            return true;
        }else{
            return false;
        }
    }

}