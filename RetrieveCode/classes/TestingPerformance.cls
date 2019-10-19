public class TestingPerformance
{
public static void checkPerformance() 
{
//Sample Code:
// Create a string with 10000 instances of 'wow'

String startStr = 'wow;wow;wow;wow;wow;wow;wow;wow;wow;wow';
String endStr = '';
Long startTime, endTime;

for(Integer i=0; i<1000; i++) {
endStr = endStr + startStr;
}

System.debug('END String' + endStr);
System.debug('Start String' + startStr);

// Test the time it takes to replace them all one at a time
startTime = DateTime.now().getTime();
while(endStr.contains('wow')) {
endStr = endStr.replaceFirst('wow','nope');
}
endTime = DateTime.now().getTime();
System.debug('Time to replace all instances of \'wow\' : ' + String.valueOf(endTime - startTime));
}
}