public class BillingAddress
{
 public void testing()
 {
  List<Account> acc = [Select id, BillingAddress from Account];
  //acc.BillingAddress != null;
 }
}