import { LightningElement, track, wire } from 'lwc';
import getPaymentHistory from '@salesforce/apex/SubscriptionService.getPaymentHistory';

const columns = [
    { label: 'Date', fieldName: 'Payment_Date__c', type: 'date' },
    { label: 'Amount', fieldName: 'Payment_Amount__c', type: 'currency' },
    { label: 'Status', fieldName: 'Payment_Status__c', type: 'text' }
];

export default class PaymentHistory extends LightningElement {
    @track payments;
    @track error;
    columns = columns;

    @wire(getPaymentHistory)
    wiredPayments({ error, data }) {
        if (data) {
            this.payments = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.payments = undefined;
        }
    }
}