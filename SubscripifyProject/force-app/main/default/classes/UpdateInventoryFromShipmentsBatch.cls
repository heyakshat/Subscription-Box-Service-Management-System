public class UpdateInventoryFromShipmentsBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Invoice__c FROM Shipment__c WHERE Status__c = \'Shipped\' AND Inventory_Processed__c = false'
        );
    }
    
    // THE FIX IS HERE: The 'scope' parameter must be of type List<sObject>.
    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        
        // We then "cast" the generic list to the specific list type we need.
        List<Shipment__c> shipments = (List<Shipment__c>)scope;
        
        // Now we can call our service class with the correctly typed list.
        FulfillmentService.updateInventory(shipments);
    }
    
    public void finish(Database.BatchableContext bc) {
        System.debug('UpdateInventoryFromShipmentsBatch job finished.');
    }
}