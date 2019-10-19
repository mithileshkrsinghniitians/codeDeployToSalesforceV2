public with sharing class PDF_Class
{
private ApexPages.StandardController stdController  { get; set; }
    public Project__c v { get; set; }
    
    public PDF_Class(ApexPages.StandardController controller) {

        System.debug('is it in the constructor');
      this.stdController = Controller;
    }

    public PageReference saveAsPdf() {
        PageReference detailPage = stdController.save();
         System.debug('is it insave as pdf before view');
        PageReference editPage1 = stdController.view();
        if (detailPage != null) {
            // Construct URL of edit page or whatever other page you want
            PageReference editPage = new PageReference('/apex/pdf');
            return editPage;
        } else {
            return detailPage;
        }
    }
    
    public PageReference saveANDnew() {
        PageReference detailPage = stdController.save();
         /* System.debug('jayesh_saboo');
            this.v = (Project__c)this.stdController.getrecord();*/
            // Construct URL of edit page or whatever other page you want
            PageReference editPage = new PageReference('/apex/project');
          editpage.setRedirect(true);
        return editpage;
        
        }

}