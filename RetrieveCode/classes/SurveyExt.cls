public class SurveyExt 
{
 public String HotelTemp;
 public String display {get; set;}
 public SurveyExt() {}
 public SurveyExt(ApexPages.StandardController controller) {}
 public String var = ApexPages.currentPage().getParameters().get('band');

public String getAbc()
{
if(var=='abc')
{
HotelTemp = 'Travolicity';
}
if(var=='expedia')
{
HotelTemp ='HOTEL';
}
return HotelTemp;
}
}