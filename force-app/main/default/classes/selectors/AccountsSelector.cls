/**
 * Created by dmitrychausov on 28/05/2022.
 */

public with sharing class AccountsSelector extends fflib_SObjectSelector implements IAccountsSelector {

    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }

    public static IAccountsSelector newInstance() {
        return (IAccountsSelector) Application.Selector.newInstance(Account.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
                Account.Id,
                Account.BillingCity,
                Account.Satisfaction_Rating__c
        };
    }

    public List<Account> selectById(Set<ID> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }

}