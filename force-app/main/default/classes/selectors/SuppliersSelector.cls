/**
 * Created by dmitrychausov on 28/05/2022.
 */

public with sharing class SuppliersSelector extends fflib_SObjectSelector implements ISuppliersSelector {

    public Schema.SObjectType getSObjectType() {
        return Supplier__c.sObjectType;
    }

    public static ISuppliersSelector newInstance() {
        return (ISuppliersSelector) Application.Selector.newInstance(Supplier__c.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Supplier__c.Id,
            Supplier__c.Name,
            Supplier__c.City__c,
            Supplier__c.Location__Latitude__s,
            Supplier__c.Location__Longitude__s
        };
    }

    public List<Supplier__c> selectByCity(Set<String> citiesSet) {
        return (List<Supplier__c>) Database.query(
            newQueryFactory(true).
                setCondition('City__c in :citiesSet').
                toSOQL()
        );
    }

}