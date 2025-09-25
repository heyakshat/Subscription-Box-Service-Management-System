import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import pauseSubscription from '@salesforce/apex/SubscriptionService.pauseSubscription';
import cancelSubscription from '@salesforce/apex/SubscriptionService.cancelSubscription';

export default class SubscriptionActions extends LightningElement {
    
    handlePause() {
        pauseSubscription()
            .then(() => {
                this.showToast('Success', 'Subscription paused successfully.', 'success');
            })
            .catch(error => {
                this.showToast('Error', 'Failed to pause subscription.', 'error');
                console.error('Error pausing subscription:', error);
            });
    }

    handleCancel() {
        cancelSubscription()
            .then(() => {
                this.showToast('Success', 'Subscription canceled successfully.', 'success');
            })
            .catch(error => {
                this.showToast('Error', 'Failed to cancel subscription.', 'error');
                console.error('Error canceling subscription:', error);
            });
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}
