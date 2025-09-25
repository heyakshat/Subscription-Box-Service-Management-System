
public class ProcessPaymentQueueable implements Queueable, Database.AllowsCallouts {

    private List<Id> invoiceIds;

    public ProcessPaymentQueueable(List<Id> newInvoiceIds) {
        this.invoiceIds = newInvoiceIds;
    }
    public void execute(QueueableContext context) {
        System.debug('Simulating payment processing for Invoice IDs: ' + this.invoiceIds);
        
        List<Invoice_c__c> invoicesToUpdate = [SELECT Id, Status__c FROM Invoice_c__c WHERE Id IN :this.invoiceIds];
        
        for(Invoice_c__c inv : invoicesToUpdate) {
            inv.Status__c = 'Paid'; 
        }
        
        if (!invoicesToUpdate.isEmpty()) {
            update invoicesToUpdate;
        }
    }
}