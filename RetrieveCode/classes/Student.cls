public class Student
{
Static Integer i = 1;
//String name;
//Integer roll;
//Integer marks;
public Student(String a, Integer b, Integer c)
{
a='Mithilesh';
System.debug(a);

b=4;
System.debug(b);

c=70;
System.debug(c);

System.debug('Name is \t' + a + 'Roll Number is \t' + b + 'Marks is \t' + c);
}
public static void main()
{
Student obj = new Student('Mithilesh', 4, 70);
}
}