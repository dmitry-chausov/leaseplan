/**
 * Created by dmitrychausov on 29/05/2022.
 */

public interface ICasesSelector extends fflib_ISObjectSelector {
    Map<Id, Decimal> getAccountRating(Set<Id> idSet, Set<String> closedStatuses);
}