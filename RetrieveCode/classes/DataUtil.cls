@isTest 
private class DataUtil {
    static testmethod void testLoadData() {
        // Load the test accounts from the static resource
        List<sObject> ls = Test.loadData(Account.sObjectType, 'mks');
        // Verify that all 3 test accounts were created
        //System.assert(ls.size() == 3);

        // Get first test account
        Account a1 = (Account)ls[1];
        System.debug('a1 Value' + a1);
        String acctName = a1.Name;
        System.debug('Account Name' + acctName);
        Id acctRecordTypeID = a1.RecordTypeId;
		System.debug('RecordTypeId' + acctRecordTypeID);
        
        // Perform some testing using the test records
    }
}