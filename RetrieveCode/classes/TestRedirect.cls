public class TestRedirect{

public TestRedirect(){

}


public PageReference save(){

//PageReference p = new PageReference();

PageReference redirectpaege = new PageReference('/SSOCommunities/secur/logout.jsp?retUrl=https%3A%2F%2Fwww.google.com');

return redirectpaege;

}

}