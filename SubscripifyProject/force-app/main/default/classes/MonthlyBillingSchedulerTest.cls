@isTest
private class MonthlyBillingSchedulerTest {

    @isTest
    static void testBillingEngineCreatesInvoice() {
        Account acc = new Account(Name='Test Account');
        insert acc;
        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;
        
        Subscription__c sub = new Subscription__c(
            Subscriber__c = con.Id,
            Status__c = 'Active',
            Next_Billing_Date__c = Date.today() 
        );
        insert sub;

        Test.startTest();

        String cronExpr = '0 30 * * * ?';
        System.schedule('Monthly Billing Test', cronExpr, new MonthlyBillingScheduler());

        Test.stopTest();

        List<Invoice_c__c> createdInvoices = [
            SELECT Id, Status__c, Subscription__c 
            FROM Invoice_c__c
        ];
        
        System.assertEquals(1, createdInvoices.size(), 'An invoice should have been created.');
        System.assertEquals('Unpaid', createdInvoices[0].Status__c, 'The new invoice should be Unpaid.');
        System.assertEquals(sub.Id, createdInvoices[0].Subscription__c, 'The invoice should be linked to the correct subscription.');

        Subscription__c updatedSub = [SELECT Id, Next_Billing_Date__c FROM Subscription__c WHERE Id = :sub.Id];
        System.assertEquals(Date.today().addMonths(1), updatedSub.Next_Billing_Date__c, 'The next billing date should have been moved forward by one month.');
    }
}