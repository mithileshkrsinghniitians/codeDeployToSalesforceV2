public with sharing class COrderLineItemsController
{
  public  id  mp_idOpportunity  {get; set;}
  public String  mp_serviceDate    {get; set;}
  
  public COrderLineItemsController()
  {
    mp_idOpportunity = null;
  }
  
  public list<OpportunityLineItem> GetLineItems()
  {
    if(mp_idOpportunity == null)
    {
      System.Debug('Null opportunity ID used for order email.');
      return null;
    }
    
    list<OpportunityLineItem> liProducts = [SELECT ServiceDate FROM OpportunityLineItem];
    
    if(liProducts == null)
    {
      System.Debug('No products loaded for order: ' + mp_idOpportunity);
      return null;
    }
    
    for(OpportunityLineItem oProd : liProducts)
    {
      mp_serviceDate += oProd.ServiceDate;
    }
    
    return liProducts;
  }
}