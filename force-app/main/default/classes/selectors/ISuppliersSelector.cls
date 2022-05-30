/**
 * Created by dmitrychausov on 29/05/2022.
 */

public interface ISuppliersSelector extends fflib_ISObjectSelector {
    List<Supplier__c> selectByCity(Set<String> citiesSet);
}