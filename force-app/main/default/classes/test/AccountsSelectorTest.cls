/**
 * Created by dmitrychausov on 30/05/2022.
 */
@IsTest
private class AccountsSelectorTest {

    @IsTest
    private static void selectByIdTest() {
        Account acc = new Account(Name = 'Poznan', BillingCity = 'Poznan');
        insert acc;
        List<Account> accounts =
                AccountsSelector.newInstance().selectById(new Set<Id> { acc.Id });
        System.assertEquals(acc.BillingCity, accounts[0].BillingCity, 'Account name should be equals');
    }

}