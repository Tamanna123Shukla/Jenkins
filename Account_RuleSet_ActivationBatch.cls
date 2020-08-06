/*
* @Purpose      : used to perform accountruleset approval and activation API callout.
*/
global class Account_RuleSet_ActivationBatch{
    /*
global class Account_RuleSet_ActivationBatch implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful,Schedulable{
    
    global Set<Id> ruleSetIds   	=  new Set<Id>();
    global Map<id,API_Callout_Status__c> acsUpdateMap   = new Map<id,API_Callout_Status__c>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Integer count         = Integer.valueOf(PEUtility.getMerchantDetails().Account_Activation_Callout_Count__c);
        String ratecardstatus = Constants.Not_Activated;
        return Database.getQueryLocator('SELECT id,Status_c__c,RateCards_c__c,API_Callout_Status__c,API_Callout_Status__r.Account__r.Merchant_Id__c,API_Callout_Status__r.Account__c,API_Callout_Status__r.Account__r.Response_ID__c,API_Callout_Status__r.Success_Count__c,API_Callout_Status__r.Callout_Count__c FROM RuleSet__c WHERE Status_c__c=:ratecardstatus AND API_Callout_Status__r.Callout_Count__c<:count');
    }
    
    global void execute(SchedulableContext SC){
        Database.executeBatch(new Account_RuleSet_ActivationBatch(), 1);
    }
    
    global void execute(Database.BatchableContext BC, List<RuleSet__c> ruleSetList){  
        try{
            List<RuleSet__c> ruleSetUpdateList 			= new List<RuleSet__c>();
            List<API_Callout_Status__c> acsUpdateList   = new List<API_Callout_Status__c>();
            Map<String,List<RuleSet__c>> finalCallout   = new Map<String,List<RuleSet__c>>();
            API_Callout_Service.RulesetApicalloutWrapper ruleSetWrp = new API_Callout_Service.RulesetApicalloutWrapper();
            RuleSet__c rlSet1 = new RuleSet__c();
            
            for(RuleSet__c ruleSet : ruleSetList){
                rlSet1 = API_Callout_Service.accountRulesetApprovalCallout(ruleSet.API_Callout_Status__r.Account__r.Merchant_Id__c,ruleSet.RateCards_c__c,String.valueOf(ruleSet.API_Callout_Status__r.Account__c),ruleSet.API_Callout_Status__r.Account__r.Response_ID__c,ruleSet.id);
                ruleSetWrp = API_Callout_Service.accountRulesetActivationCallout(ruleSet.API_Callout_Status__r.Account__r.Merchant_Id__c,ruleSet.RateCards_c__c,String.valueOf(ruleSet.API_Callout_Status__r.Account__c),ruleSet.API_Callout_Status__r.Account__r.Response_ID__c,ruleSet.id,ruleSet.API_Callout_Status__c,Integer.valueOF(ruleSet.API_Callout_Status__r.Callout_Count__c));
                ruleSetWrp.rSet.Approval_ruleset__c = rlSet1.Approval_ruleset__c;
                
                if(ruleSetWrp.rSet.Approval_ruleset__c == true && ruleSetWrp.rSet.Activation_ruleset__c == true){
                    ruleSetWrp.rSet.Status_c__c = Constants.Activated;
                }
                ruleSetUpdateList.add(ruleSetWrp.rSet);
                
                if(!acsUpdateMap.containsKey(ruleSetWrp.apiCalloutStatus.id)){
                    acsUpdateMap.put(ruleSetWrp.apiCalloutStatus.id,ruleSetWrp.apiCalloutStatus);
                }
            }
            
            if(!ruleSetUpdateList.isEmpty())
                update ruleSetUpdateList;
            
            if(!acsUpdateMap.isEmpty())
                update acsUpdateMap.values();
            
        }Catch(Exception e){
            HandleBusinessException.captureError('Account_RuleSet_ActivationBatch', 'execute Method', e);
        }
    }
    
    global void finish(Database.BatchableContext BC){
        try{
            List <API_Callout_Status__c> acslist  	= [SELECT id,Success_Count__c,Callout_Count__c,Callout_Status__c,Account__r.Response_ID__c,Account__c,(SELECT id from RuleSets__r) from API_Callout_Status__c where id=:acsUpdateMap.keySet()];
            List<Account> updateAccList = new List<Account>();
            for(API_Callout_Status__c acs : acslist){
                if(acs.Success_Count__c == acs.RuleSets__r.size()){
                    updateAccList.add(new Account(ID = acs.Account__c,Callout_Status__c = Constants.Ruleset_Activated));
                 }
            }
            
            if(!updateAccList.isEmpty())
                update updateAccList;
            
        }Catch(Exception e){
            HandleBusinessException.captureError('Account_RuleSet_ActivationBatch', 'execute Method', e);
        }
    }
    */
}