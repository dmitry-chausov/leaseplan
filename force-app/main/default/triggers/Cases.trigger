/**
 * Created by dmitrychausov on 29/05/2022.
 */

trigger Cases on Case (after delete, after insert, after update, before delete, before insert, before update) {
    fflib_SObjectDomain.triggerHandler(CasesTriggerHandler.class);
}