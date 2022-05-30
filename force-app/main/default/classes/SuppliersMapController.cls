/**
 * Created by dmitrychausov on 27/05/2022.
 */

public with sharing class SuppliersMapController {

    @AuraEnabled(cacheable=true)
    public static List<MapMarkerWrapper> geMapMarkersList(Id accountId) {
        List<MapMarkerWrapper> mapMarkersList = new List<MapMarkerWrapper>();
        String city = AccountsSelector.newInstance().selectById(new Set<Id> { accountId })[0].BillingCity;
        if(String.isBlank(city)) {
            throw new AuraHandledException(Label.SuppliersMapController_city_is_empty);
        }
        if(!Supplier__c.getSObjectType().getDescribe().isAccessible()) {
            throw new AuraHandledException(Label.SuppliersMapController_no_supplier_access);
        }
        for(Supplier__c supplierItem : SuppliersSelector.newInstance().selectByCity(new Set<String> { city })) {
            mapMarkersList.add(new MapMarkerWrapper(supplierItem));
        }
        if(mapMarkersList.size() == 0) {
            throw new AuraHandledException(String.format(Label.SuppliersMapController_no_suppliers_in_the_city, new List<String> { city }));
        }
        return mapMarkersList;
    }

}