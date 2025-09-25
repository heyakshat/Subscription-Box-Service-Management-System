public class FulfillmentService {
    
    public static void updateInventory(List<Shipment__c> shipments) {
        
        Set<Id> invoiceIds = new Set<Id>();
        for(Shipment__c sh : shipments) {
            invoiceIds.add(sh.Invoice__c);
        }
        
        Map<Id, Decimal> productQuantities = new Map<Id, Decimal>();
        
        for (Invoice_Line__c ili : [
            SELECT Product__c, Quantity__c 
            FROM Invoice_Line__c 
            WHERE Invoice__c IN :invoiceIds
        ]) {
            if (productQuantities.containsKey(ili.Product__c)) {
                productQuantities.put(ili.Product__c, productQuantities.get(ili.Product__c) + ili.Quantity__c);
            } else {
                productQuantities.put(ili.Product__c, ili.Quantity__c);
            }
        }
        
        if (productQuantities.isEmpty()) {
            return;
        }
        
        List<Product_Inventory__c> inventoriesToUpdate = [
            SELECT Id, Quantity_In_Stock__c, Product__c 
            FROM Product_Inventory__c 
            WHERE Product__c IN :productQuantities.keySet()
        ];
        
        for (Product_Inventory__c inv : inventoriesToUpdate) {
            Decimal soldQuantity = productQuantities.get(inv.Product__c);
            if (inv.Quantity_In_Stock__c != null) {
                inv.Quantity_In_Stock__c = inv.Quantity_In_Stock__c - soldQuantity;
            }
        }
        
        List<Shipment__c> shipmentsToUpdate = new List<Shipment__c>();
        for (Shipment__c sh : shipments) {
            shipmentsToUpdate.add(new Shipment__c(Id = sh.Id, Inventory_Processed__c = true));
        }
        
        update inventoriesToUpdate;
        update shipmentsToUpdate;
    }
}