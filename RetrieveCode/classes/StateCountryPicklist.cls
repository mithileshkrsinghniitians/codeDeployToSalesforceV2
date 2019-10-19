public class StateCountryPicklist
 {

    public StateCountryPicklist(ApexPages.StandardController controller) {

    }

  public List<SelectOption> getCountries()
   {
    List<SelectOption> options = new List<SelectOption>();
        
     Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
     List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
   for( Schema.PicklistEntry f : ple)
   {
      options.add(new SelectOption(f.getLabel(), f.getValue()));
   }       
   return options;
 }
}