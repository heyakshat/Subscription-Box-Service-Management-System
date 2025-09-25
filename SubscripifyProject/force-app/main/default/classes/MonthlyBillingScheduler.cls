public class MonthlyBillingScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        BillingEngineService.generateInvoices();
    }
}