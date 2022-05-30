/**
 * Created by dmitrychausov on 30/05/2022.
 */

@IsTest
private class SuppliersSelectorTest {

    @IsTest
    private static void selectByCityTest() {
        Supplier__c supp = new Supplier__c(Name = 'Poznan', City__c = 'Poznan', Location__Latitude__s = 10, Location__Longitude__s = 10);
        insert supp;
        List<Supplier__c> suppliers =
                SuppliersSelector.newInstance().selectByCity(new Set<String> { supp.City__c });
        System.assertEquals(supp.City__c, suppliers[0].City__c, 'City should be equals');
    }

}