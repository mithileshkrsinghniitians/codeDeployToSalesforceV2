Public class CaseViewController
{
Case c;
public CaseViewController (ApexPages.StandardController ctr)
{
c = (Case)ctr.GetRecord();
}

list<CaseHistory> histories = new list<CaseHistory>();

public List<CaseHistory> getHistories()
{
histories =
[Select CreatedDate, CreatedBy.Name, CreatedBy.Id, Field, NewValue, OldValue 
from CaseHistory where CaseId = :c.ID order by CreatedDate desc ];
return histories ;
}
}