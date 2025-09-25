import { LightningElement, track, wire } from 'lwc';
import getAddress from '@salesforce/apex/SubscriptionService.getAddress';
import saveAddress from '@salesforce/apex/SubscriptionService.saveAddress';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AddressManager extends LightningElement {
    @track shippingAddress = {};
    @track isEditing = false;
    wiredAddressResult;

    @wire(getAddress)
    wiredAddress(result) {
        this.wiredAddressResult = result;
        const { data, error } = result;
        if (data) {
            this.shippingAddress = data;
        } else if (error) {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error loading address',
                message: error.body.message,
                variant: 'error'
            }));
        }
    }

    handleEdit() {
        this.isEditing = true;
    }

    handleSave() {
        this.isEditing = false;
        // Logic to save address will go here
    }

    handleCancel() {
        this.isEditing = false;
    }

    handleInputChange(event) {
        const fieldName = event.target.name;
        this.shippingAddress[fieldName] = event.target.value;
    }
}