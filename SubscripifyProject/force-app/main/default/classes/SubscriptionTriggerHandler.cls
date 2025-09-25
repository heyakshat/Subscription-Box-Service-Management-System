public class SubscriptionTriggerHandler {

    public static void handleBeforeUpdate(List<Subscription__c> newSubscriptions, Map<Id, Subscription__c> oldSubscriptionMap) {
        
        Set<Id> canceledSubscriptionIds = new Set<Id>();

        for (Subscription__c sub : newSubscriptions) {
            Subscription__c oldSub = oldSubscriptionMap.get(sub.Id);
            if (sub.Status__c == 'Canceled' && oldSub.Status__c != 'Canceled') {
                canceledSubscriptionIds.add(sub.Id);
            }
        }

        if (canceledSubscriptionIds.isEmpty()) {
            return;
        }

        List<Invoice_c__c> unpaidInvoices = [
            SELECT Id, Subscription__c 
            FROM Invoice_c__c  
            WHERE Status__c = 'Unpaid' 
            AND Subscription__c IN :canceledSubscriptionIds
        ];

        if (!unpaidInvoices.isEmpty()) {
            Map<Id, Subscription__c> subMap = new Map<Id, Subscription__c>(newSubscriptions);

            for (Invoice_c__c inv : unpaidInvoices) {  
                Subscription__c subWithError = subMap.get(inv.Subscription__c);
                if(subWithError != null){
                     subWithError.addError('This subscription cannot be canceled because it has outstanding unpaid invoices.');
                }
            }
        }
    }
}