/**
 * 
 */
@isTest
private class ResponseSchedulerTest {
    
    static testMethod void excuteMethodTest() {
        Test.startTest();
        ResponseScheduler schedulerInstance = new ResponseScheduler();
        schedulerInstance.execute();
        Test.stopTest();
    }
}