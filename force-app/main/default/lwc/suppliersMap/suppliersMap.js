/**
 * Created by dmitrychausov on 27/05/2022.
 */

import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import BILLING_CITY_FIELD from '@salesforce/schema/Account.BillingCity';
import enterSupplierNameLabel from '@salesforce/label/c.suppliersMap_enter_supplier_name';
import searchLabel from '@salesforce/label/c.suppliersMap_search';

import geMapMarkersList from '@salesforce/apex/SuppliersMapController.geMapMarkersList';

export default class SuppliersMap extends LightningElement {
    @api recordId;
    fullMapMarkersList;
    mapMarkersList;
    zoomLevel = 10;
    strSearchSuppName;
    error;

    label = {
        enterSupplierNameLabel,
        searchLabel,
    };

    get center() {
        return { location : { City: getFieldValue(this.account.data, BILLING_CITY_FIELD) }};
    }

    @wire(getRecord, { recordId: '$recordId', fields: [BILLING_CITY_FIELD] })
    account;

    @wire(geMapMarkersList, { accountId: '$recordId' })
    wiredMapMarkers({ error, data }) {
        if (data) {
            this.fullMapMarkersList = data;
            this.mapMarkersList = [ ...data ];
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.showToast(error);
        }
    }
    handleSupplierName(event) {
        this.strSearchSuppName = event.currentTarget.value;
    }

    handleSearch() {
        if(this.strSearchSuppName) {
            const result = this.fullMapMarkersList.filter(record => record.title?.toLowerCase().includes(this.strSearchSuppName.toLowerCase()));
            this.mapMarkersList = [ ...result ];
        }
        else {
            this.mapMarkersList = [ ...this.fullMapMarkersList ];
        }
    }

    showToast(error) {
        const event = new ShowToastEvent({
            title: 'Error',
            message: error?.body?.message,
            variant: 'error',
        });
        this.dispatchEvent(event);
    }

}