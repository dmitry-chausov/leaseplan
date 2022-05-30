/**
 * Created by dmitrychausov on 27/05/2022.
 */

public with sharing class MapMarkerWrapper {

    @AuraEnabled
    public Location location;
    @AuraEnabled
    public String title;

    public MapMarkerWrapper(Supplier__c supplierRecord) {
        this.title = supplierRecord.Name;
        this.location = new Location(supplierRecord.Location__Latitude__s, supplierRecord.Location__Longitude__s);
    }

    public class Location {
        @AuraEnabled
        public Decimal Latitude;
        @AuraEnabled
        public Decimal Longitude;

        public Location(Decimal latitude, Decimal longitude) {
            this.Latitude = latitude;
            this.Longitude = longitude;
        }
    }

}