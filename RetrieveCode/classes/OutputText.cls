public class OutputText
{
public Account acc {get;set;}
public OutputText(ApexPages.StandardSetController controller)
{
acc = [Select Name from Account where Name='HCL Technologies Ltd'];
}
}