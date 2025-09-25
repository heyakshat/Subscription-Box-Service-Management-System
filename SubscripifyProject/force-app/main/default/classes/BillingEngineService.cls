public class BillingEngineService {
    
    public static void generateInvoices() {
        
        try {
            Date today = Date.today();
            
            List<Subscription__c> dueSubscriptions = [
                SELECT Id, Subscriber__c, Price_Override__c, Next_Billing_Date__c
                FROM Subscription__c
                WHERE Status__c = 'Active' AND Next_Billing_Date__c = :today
            ];
            
            if (dueSubscriptions.isEmpty()) {
                return;
            }
            
            List<Invoice_c__c> newInvoices = new List<Invoice_c__c>();
            List<Subscription__c> subscriptionsToUpdate = new List<Subscription__c>();
            
            for (Subscription__c sub : dueSubscriptions) {
                Invoice_c__c newInvoice = new Invoice_c__c(
                    Subscription__c = sub.Id,
                    Status__c = 'Unpaid',
                    Invoice_Date__c = today,
                    Due_Date__c = today.addDays(14),
                    Amount__c = (sub.Price_Override__c != null) ? sub.Price_Override__c : 999.00
                );
                newInvoices.add(newInvoice);
                
                Subscription__c updatedSub = new Subscription__c(Id = sub.Id);
                updatedSub.Next_Billing_Date__c = sub.Next_Billing_Date__c.addMonths(1);
                subscriptionsToUpdate.add(updatedSub);
            }
            
            if (!newInvoices.isEmpty()) {
                insert newInvoices;

                List<Id> newInvoiceIds = new List<Id>();
                for (Invoice_c__c inv : newInvoices) {
                    newInvoiceIds.add(inv.Id);
                }
                System.enqueueJob(new ProcessPaymentQueueable(newInvoiceIds));
            }

            if (!subscriptionsToUpdate.isEmpty()) {
                update subscriptionsToUpdate;
            }

        } catch (Exception e) {

            System.debug('An error occurred in the Billing Engine: ' + e.getMessage() + ' at line ' + e.getLineNumber());
        }
    }
}