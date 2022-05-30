/**
 * Created by dmitrychausov on 29/05/2022.
 */

public with sharing class CaseStatusesSelector extends fflib_SObjectSelector implements ICaseStatusesSelector {

    public Schema.SObjectType getSObjectType() {
        return CaseStatus.sObjectType;
    }

    public static ICaseStatusesSelector newInstance() {
        return (ICaseStatusesSelector) Application.Selector.newInstance(CaseStatus.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            CaseStatus.ApiName
        };
    }
    public Set<String> getClosedCaseStatuses() {
        Set<String> closedCaseStatusList = new Set<String>();
        for(CaseStatus caseStatusItem: (List<CaseStatus>) Database.query(
            newQueryFactory(true).
                setCondition('IsClosed = true').
                toSOQL()
        )) {
            closedCaseStatusList.add(caseStatusItem.ApiName);
        }
        return closedCaseStatusList;
    }

}