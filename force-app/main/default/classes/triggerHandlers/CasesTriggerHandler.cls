/**
 * Created by dmitrychausov on 29/05/2022.
 */

public with sharing class CasesTriggerHandler extends fflib_SObjectDomain {

    private static Set<String> closedCaseStatuses {get {
        if(closedCaseStatuses == null) {
            return CaseStatusesSelector.newInstance().getClosedCaseStatuses();
        }
        return closedCaseStatuses;
    } set;}

    public CasesTriggerHandler(List<Case> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new CasesTriggerHandler(sObjectList);
        }
    }

    public override void onAfterInsert() {
        updateAccountRating(null);
    }

    public override void onAfterUpdate(Map<Id,SObject> existingRecords) {
        updateAccountRating(existingRecords);
    }

    private void updateAccountRating(Map<Id,SObject> existingRecords) {
        Set<Id> accountIds = Cases.newInstance(this.Records).getAccountIds(existingRecords, closedCaseStatuses);
        Map<Id, Decimal> accountNewRatingMap = CasesSelector.newInstance().getAccountRating(accountIds, closedCaseStatuses);
        List<Account> existedAccountList = AccountsSelector.newInstance().selectById(accountIds);
        List<Account> accountsToUpdate = new List<Account>();
        for(Account accountRecord : existedAccountList) {
            if(accountRecord.Satisfaction_Rating__c != accountNewRatingMap.get(accountRecord.Id)) {
                accountRecord.Satisfaction_Rating__c = accountNewRatingMap.get(accountRecord.Id);
                accountsToUpdate.add(accountRecord);
            }
        }
        update accountsToUpdate;
    }
}
