/**
 * Created by dmitrychausov on 29/05/2022.
 */

public interface IAccountsSelector extends fflib_ISObjectSelector {
    List<Account> selectById(Set<Id> idSet);
}