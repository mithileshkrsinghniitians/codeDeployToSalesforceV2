public class theController{
public String out{
get{
if(out == null) 
out='getter';
return out;
}
set;
}

public theController()
{
//out='constructor';
}
public void setOut()
{
out='action';
}
}