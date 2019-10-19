@isTest
    private class testCheckInController {
    static testMethod void testCheckInController() {
       Account a = new Account(Name='Test Account', Location__Latitude__s=37.783900,Location__Longitude__s=-122.389332);
       insert a;

       CheckInController.getNearby('37.794428', '-122.394782');
       CheckInController.insertTask(a.id, 'Completed','test comment');
    }
}