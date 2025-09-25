import { LightningElement, track, wire } from 'lwc';
import getSubscriptionDetails from '@salesforce/apex/SubscriptionService.getSubscriptionDetails';
import { refreshApex } from '@salesforce/apex';

export default class SubscriptionDetails extends LightningElement {
    @track status;
    @track tier;
    @track nextBillingDate;
    @track error;

    // A property to hold the provisioned data
    wiredSubscriptionResult;

    @wire(getSubscriptionDetails)
    wiredSubscriptionDetails(result) {
        this.wiredSubscriptionResult = result;
        if (result.data) {
            this.status = result.data.Status__c;
            // Note: Tier is not in the query, so we'll set it to a default or remove it
            this.nextBillingDate = result.data.Next_Billing_Date__c;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.status = undefined;
            this.nextBillingDate = undefined;
        }
    }

    connectedCallback() {
        this.addEventListener('subscriptionupdated', this.handleSubscriptionUpdate);
    }

    handleSubscriptionUpdate() {
        refreshApex(this.wiredSubscriptionResult);
    }
}
