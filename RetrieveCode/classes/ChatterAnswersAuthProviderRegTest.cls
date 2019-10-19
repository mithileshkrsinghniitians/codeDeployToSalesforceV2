@isTest
private class ChatterAnswersAuthProviderRegTest {
  static testMethod void validateCreateUpdateUser() {
    User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
    System.runAs ( thisUser ) {
      Auth.UserData userData = new Auth.UserData('testId', 'testFirst', 'testLast',
      'testFirst testLast', 'no-reply@salesforce.com', null, 'testuserlong', 'en_US', 'facebook',
      null, new Map<String, String>{'language' => 'en_US'});
      ChatterAnswersAuthProviderRegistration reg = new ChatterAnswersAuthProviderRegistration();
      Profile[] p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
      User[] adminUser = [SELECT Id, Firstname, Lastname FROM User WHERE IsActive = true and ProfileId =: p[0].Id LIMIT 1];
      Account a = new Account(Name='Test');
      insert a;
      Contact c = new Contact();
      c.AccountId = a.Id;
      c.LastName = 'contactLast';
      insert c;
      
      User newUser = new User();
      newUser.Alias = 'firstusr';
      newUser.Username = 'Usernametesting@gmail.com';
      newUser.LastName = 'testing';
      newUser.Email = 'Usernametesting@gmail.com';
      newUser.CommunityNickname = 'Testing';
      newUser.TimeZoneSidKey = 'America/Los_Angeles';
      newUser.LocaleSidKey = 'en_US';
      newUser.EmailEncodingKey = 'UTF-8';
      newUser.LanguageLocaleKey = 'en_US';
      newUser.ContactId = c.Id;
      newUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'High Volume Customer Portal 2' LIMIT 1].Id;
      insert newUser;
      
      Auth.UserData updateUserData = new Auth.UserData('testId', 'updatedFirst', 'updatedLast',
      'updatedFirst updatedLast', 'no-reply@new.salesforce.com', null, 'testuserlong', 'en_US', 'facebook',
      null, new Map<String, String>{'language' => 'en_US'});
      reg.updateUser(newUser.Id, null, updateUserData);
      
      User dbUser =  [SELECT Id, Firstname, Lastname, Email FROM User WHERE Id = :newUser.Id];
    }
  }
  
}