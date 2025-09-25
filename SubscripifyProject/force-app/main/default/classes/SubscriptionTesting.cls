@isTest
private class SubscriptionTesting {

    @isTest
    static void testCancelSubscription_Success() {

        Account acc = new Account(Name='Test Account');
        insert acc;

        Contact con = new Contact(LastName='Test Contact', AccountId=acc.Id);
        insert con;

        Subscription__c sub = new Subscription__c(
            Subscriber__c = con.Id,
            Status__c = 'Active',
            Start_Date__c = Date.today().addMonths(-1)
        );
        insert sub;

        Test.startTest();

        SubscriptionService.cancelSubscription();

        Test.stopTest();

        Subscription__c resultSub = [SELECT Id, Status__c FROM Subscription__c WHERE Id = :sub.Id];
        System.assertEquals('Cancelled', resultSub.Status__c, 'The subscription status should have been updated to Cancelled.');
    }
}
