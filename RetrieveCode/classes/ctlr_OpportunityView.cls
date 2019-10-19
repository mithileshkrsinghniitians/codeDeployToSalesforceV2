public with sharing class ctlr_OpportunityView
{
    public ctlr_OpportunityView(ApexPages.StandardController controller) 
    {
    }

    public PageReference init() 
    {   
        try
        {  
            Opportunity opp = [select ID from Opportunity where Id = : ApexPages.currentPage().getParameters().get('id') Limit 1];
            ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
            /*ctlr_TabbedProductList controller = new ctlr_TabbedProductList(stdController);
            String redirectTo = controller.getRevenueSchedulePage();

            if(redirectTo!='')
            {                
                pagereference page=new pagereference(redirectTo);
                page.setredirect(true);
                return page;
            }*/
        }
        catch(Exception e)
        {
            apexPages.addMessages(e); 
        }
        return null;
    }   
}