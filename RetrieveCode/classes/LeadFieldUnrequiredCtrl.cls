Public class LeadFieldUnrequiredCtrl
{
   
   public Lead lead { get; set; }
    
    public LeadFieldUnrequiredCtrl() {
        this.lead  = getLead();
    }

    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Lead.FieldSets.LastName.getFields();
    }

    private Lead  getLead() {
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : this.getFields()) {
            query += f.getFieldPath() + ', ';
        }
        query += 'Id,FirstName,Company FROM Lead LIMIT 1';
        return Database.query(query);
    }

    public pageReference save()
    {
         update lead;
         return New pageReference ('/apex/LeadFieldUnrequired?id=' + lead.ID);
    
    }
    
}