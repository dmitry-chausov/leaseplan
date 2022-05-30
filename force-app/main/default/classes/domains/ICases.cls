/**
 * Created by dmitrychausov on 29/05/2022.
 */

public interface ICases extends fflib_ISObjects {
    Set<Id> getAccountIds(Map<Id,SObject> existingRecords, Set<String> closedCaseStatuses );
}