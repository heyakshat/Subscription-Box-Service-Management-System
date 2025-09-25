@isTest
private class SubscriptionServiceTest {

    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest request) {
            System.assertEquals('POST', request.getMethod(), 'The method should be POST.');
            
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"id": "ch_12345", "status": "succeeded"}');
            response.setStatusCode(200);
            return response;
        }
    }
    
    @isTest
    static void testCreatePaymentCharge_Success() {
        Subscription__c testSub = new Subscription__c(
            Status__c = 'Active',
            Start_Date__c = Date.today(),
            Next_Billing_Date__c = Date.today().addDays(30),
            Street__c = '123 Main St',
            Country__c = 'USA'
        );
        insert testSub;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        SubscriptionService.createPaymentCharge(testSub.Id);
        Test.stopTest();
        

    }
}
