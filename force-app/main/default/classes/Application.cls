/**
 * Created by dmitrychausov on 28/05/2022.
 */

public with sharing class Application {

    public static final fflib_Application.SelectorFactory Selector =
        new fflib_Application.SelectorFactory(
            new Map<SObjectType, Type> {
                    Account.SObjectType => AccountsSelector.class,
                    Supplier__c.SObjectType => SuppliersSelector.class,
                    Case.SObjectType => CasesSelector.class,
                    CaseStatus.SObjectType => CaseStatusesSelector.class
            }
        );

    public static final fflib_Application.DomainFactory Domain =
        new fflib_Application.DomainFactory(
            Application.Selector,
            new Map<SObjectType, Type>{
                Case.SObjectType => Cases.Constructor.class//,
                //Account.SObjectType => Accounts.Constructor.class,
            }
        );

}