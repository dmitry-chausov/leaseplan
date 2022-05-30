/**
 * Created by dmitrychausov on 29/05/2022.
 */

public with sharing class Cases extends fflib_SObjects implements ICases {

    public static ICases newInstance(List<Case> recordList) {
        return (ICases) Application.Domain.newInstance(recordList);
    }

    public static ICases newInstance(Set<Id> recordIdSet) {
        return (ICases) Application.Domain.newInstance(recordIdSet);
    }

    public Cases(List<Case> sObjectList) {
        // Domain classes are initialised with lists to enforce bulkification throughout
        super(sObjectList);
    }

    public class Constructor implements fflib_IDomainConstructor {
        public fflib_SObjects construct(List<Object> objectList) {
            return new Cases((List<SObject>) objectList);
        }
    }

    public Set<Id> getAccountIds(Map<Id,SObject> existingRecords, Set<String> closedCaseStatuses ) {
        Set<Id> result = new Set<Id>();
        for (Case record : (List<Case>) getRecords()) {
            Case existingRecord = (Case) existingRecords?.get(record.Id);
            if (
                (record.AccountId != existingRecord?.AccountId
                    || record.Satisfaction_Rating__c != existingRecord?.Satisfaction_Rating__c
                    || record.Status != existingRecord?.Status
                )
                && (record.AccountId != null || existingRecord?.AccountId != null)
                && (record.Satisfaction_Rating__c != null || existingRecord?.Satisfaction_Rating__c != null)
                && (closedCaseStatuses.contains(record.Status) || closedCaseStatuses.contains(existingRecord?.Status))
            ) {
                addAccountIds(result, record, existingRecord);
            }
        }
        return result;
    }

    private static void addAccountIds(Set<Id> result, Case newRecord, Case oldRecord) {
        if(oldRecord?.AccountId != null) {
            result.add(oldRecord.AccountId);
        }
        if(newRecord.AccountId != null) {
            result.add(newRecord.AccountId);
        }
    }

}