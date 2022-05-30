/**
 * Created by dmitrychausov on 29/05/2022.
 */

public with sharing class CasesSelector extends fflib_SObjectSelector implements ICasesSelector {
    public Schema.SObjectType getSObjectType() {
        return Case.sObjectType;
    }

    public static ICasesSelector newInstance() {
        return (ICasesSelector) Application.Selector.newInstance(Case.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
                Case.AccountId
        };
    }

    public Map<Id, Decimal> getAccountRating(Set<Id> idSet, Set<String> closedStatuses) {
        //QueryFactory isn't support AggregatedResult
        Map<Id, Decimal> accountIdToRatingMap = new Map<Id, Decimal>();
        for(AggregateResult result: [
                SELECT      AccountId, AVG(Satisfaction_Rating__c) avgRating FROM Case
                WHERE       AccountId IN :idSet AND Status IN :closedStatuses
                GROUP BY    AccountId
        ]){
            accountIdToRatingMap.put((Id) result.get(Case.AccountId.getDescribe().getName()), ((Decimal) result.get('avgRating'))?.setScale(2));
        }
        return accountIdToRatingMap;
    }
}