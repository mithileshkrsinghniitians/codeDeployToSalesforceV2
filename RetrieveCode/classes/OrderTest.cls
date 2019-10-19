public class OrderTest
 {
   public String status{get;set;}
   public boolean checkboxTest{get;set;}
   public String name{get;set;}
   
   public List<selectOption> getaccts() 
   {
        List<selectOption> options = new List<selectOption>(); 
        options.add(new selectOption('Draft', 'Draft'));
        options.add(new selectOption('Quote', 'Quote'));
        options.add(new selectOption('Place Order', 'Place Order'));
        options.add(new selectOption('Invoiced', 'Invoiced'));
        return options;
    }
    
    public PageReference Submit()
    {
     Order__c obj = new Order__c(Name=name, Priority_Shipment__c=checkboxTest, Status__c=status);
     insert obj;
     String URL = 'https://google.com';
     PageReference pageref = new PageReference(URL);
     return pageref; 
     return null;
    }  
}