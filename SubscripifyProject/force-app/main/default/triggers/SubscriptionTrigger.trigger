trigger SubscriptionTrigger on Subscription__c (before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        SubscriptionTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
}