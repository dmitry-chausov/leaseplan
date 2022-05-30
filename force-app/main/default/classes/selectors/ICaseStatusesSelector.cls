/**
 * Created by dmitrychausov on 29/05/2022.
 */

public interface ICaseStatusesSelector extends fflib_ISObjectSelector {
    Set<String> getClosedCaseStatuses();
}