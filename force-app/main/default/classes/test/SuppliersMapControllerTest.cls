/**
 * Created by dmitrychausov on 29/05/2022.
 */
@IsTest
private class SuppliersMapControllerTest {

    @IsTest
    private static void geMapMarkersListTest() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        Id accId = fflib_IDGenerator.generate(Account.SObjectType);
        Account acc = new Account(
            Id = accId,
            BillingCity = 'Poznan'
        );
        Supplier__c supp = new Supplier__c(City__c = acc.BillingCity);
        IAccountsSelector mockAccSelector = (IAccountsSelector) mocks.mock(IAccountsSelector.class);
        ISuppliersSelector mockSuppSelector = (ISuppliersSelector) mocks.mock(ISuppliersSelector.class);

        mocks.startStubbing();
        mocks.when(mockAccSelector.sObjectType()).thenReturn(Schema.Account.SObjectType);
        mocks.when(mockAccSelector.selectById(new Set<Id> { accId })).thenReturn(new List<Account> { acc });
        mocks.when(mockSuppSelector.sObjectType()).thenReturn(Schema.Supplier__c.SObjectType);
        mocks.when(mockSuppSelector.selectByCity(new Set<String> { acc.BillingCity })).thenReturn(new List<Supplier__c> { supp });
        mocks.stopStubbing();

        Application.Selector.setMock(mockAccSelector);
        Application.Selector.setMock(mockSuppSelector);

        System.Test.startTest();
        System.assertEquals(1, SuppliersMapController.geMapMarkersList(accId).size(), 'Wrong size of Suppliers List');
        System.Test.stopTest();
    }

    @IsTest
    private static void geMapMarkersListWithoutCityTest() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        Id accId = fflib_IDGenerator.generate(Account.SObjectType);
        Account acc = new Account(
                Id = accId,
                BillingCity = 'Poznan'
        );
        IAccountsSelector mockAccSelector = (IAccountsSelector) mocks.mock(IAccountsSelector.class);

        mocks.startStubbing();
        mocks.when(mockAccSelector.sObjectType()).thenReturn(Schema.Account.SObjectType);
        mocks.when(mockAccSelector.selectById(new Set<Id> { accId })).thenReturn(new List<Account> { acc });
        mocks.stopStubbing();

        Application.Selector.setMock(mockAccSelector);

        try {
            SuppliersMapController.geMapMarkersList(accId);
            System.assert(false, 'Should be an Exception');
        }
        catch(AuraHandledException e) {
            System.assertEquals('Script-thrown exception', e.getMessage(), 'Should be an Exception');
        }
    }

    @IsTest
    private static void geMapMarkersListEmptyTest() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        Id accId = fflib_IDGenerator.generate(Account.SObjectType);
        Account acc = new Account(
                Id = accId
        );
        IAccountsSelector mockAccSelector = (IAccountsSelector) mocks.mock(IAccountsSelector.class);

        mocks.startStubbing();
        mocks.when(mockAccSelector.sObjectType()).thenReturn(Schema.Account.SObjectType);
        mocks.when(mockAccSelector.selectById(new Set<Id> { accId })).thenReturn(new List<Account> { acc });
        mocks.stopStubbing();

        Application.Selector.setMock(mockAccSelector);

        try {
            SuppliersMapController.geMapMarkersList(accId);
            System.assert(false, 'Should be an Exception');
        }
        catch(AuraHandledException e) {
            System.assertEquals('Script-thrown exception', e.getMessage(), 'Should be an Exception');
        }
    }

}