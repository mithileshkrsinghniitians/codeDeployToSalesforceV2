public class AccountAddressTrigger
{
public static void updateAccount()
{
List<Account> acc = [Select Id, mks1__Match_Billing_Address__c, BillingPostalCode, ShippingPostalCode from account where id = '0019000001jWFpH'];
acc[0].Match_Billing_Address__c = true;
acc[0].ShippingPostalCode = acc[0].BillingPostalCode;
update acc;
}

private static boolean run = true;
public static boolean runOnce()
{
if(run)
{
run=false;
return true;
}
else
{
return run;
}
}

}