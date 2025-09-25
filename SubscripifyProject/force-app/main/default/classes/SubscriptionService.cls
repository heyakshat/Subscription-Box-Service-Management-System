public with sharing class SubscriptionService {

    @AuraEnabled(cacheable=true)
    public static Subscription__c getSubscriptionDetails() {
        return [SELECT Id, Status__c, Next_Billing_Date__c, Tier_c__c FROM Subscription__c LIMIT 1];
    }

    @AuraEnabled
    public static String pauseSubscription() {
        Subscription__c sub = [SELECT Id, Status__c FROM Subscription__c LIMIT 1];
        sub.Status__c = 'Paused';
        update sub;
        return 'Paused';
    }

    @AuraEnabled
    public static String cancelSubscription() {
        Subscription__c sub = [SELECT Id, Status__c, Cancellation_Date__c FROM Subscription__c LIMIT 1];
        sub.Status__c = 'Cancelled';
        sub.Cancellation_Date__c = System.now();
        update sub;
        return 'Cancelled';
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Payment__c> getPaymentHistory() {
        return [SELECT Id, Payment_Date__c, Payment_Amount__c, Payment_Status__c FROM Payment__c ORDER BY Payment_Date__c DESC];
    }
    
    @AuraEnabled(cacheable=true)
    public static Subscription__c getAddress() {
        return [SELECT Id, Street__c, City__c, State__c, PostalCode__c, Country__c FROM Subscription__c LIMIT 1];
    }
    
    @AuraEnabled
    public static void saveAddress(Map<String, String> address) {
        Subscription__c sub = [SELECT Id FROM Subscription__c LIMIT 1];
        sub.Street__c = address.get('street');
        sub.City__c = address.get('city');
        sub.State__c = address.get('state');
        sub.PostalCode__c = address.get('postalCode');
        sub.Country__c = address.get('country');
        update sub;
    }
    
    @future(callout=true)
    public static void createPaymentCharge(Id subscriptionId) {

    }
}
