@isTest
public without sharing class BenchmarkingTest {
    /**
    * @description : Here want to measure the time to perform a very simple operation – say, incrementing an integer number.
    */
    @istest
    public static void primitiveTests()
    {
        Integer v = 0;
        Benchmarking.markReferenceStartTime();
        for(Integer x = 0; x<1000000; x++) {}
        Benchmarking.markReferenceEndTime();
    
        Benchmarking.markTargetStartTime();
        for(Integer x = 0; x<1000000; x++)
        {
            v += 5;
        }
        Benchmarking.reportResults(1000000);
    }

    /**
    * @description : demonstrates a number of interesting measurements 
    * including memory allocation and the difference in field access time between dynamic and static Apex.
    */

    @istest
    public static void testNewAllocation(){
        List<List<Integer>> numbers = new List<List<Integer>>();
        List<Integer> emptyList = new List<Integer>();
        Benchmarking.markReferenceStartTime();
        for(Integer x = 0; x<1000000; x++)
        {
            numbers.add(emptyList);  //adding static array
        }
        Benchmarking.markReferenceEndTime();
        Benchmarking.markTargetStartTime();
        for(Integer x = 0; x<1000000; x++)
        {
            numbers.add(new List<Integer>{x}); // adding dynamic array
        }
        Benchmarking.reportResults(1000);
    }

    /**
    * @description : The Schema.getGlobalDescribe function is documented as using internal caching, so it should run slowly the first time and more quickly on subsequent calls.
    */

    @istest
    public static void testGlobalDescribe(){
        Benchmarking.markReferenceStartTime();
        for(Integer x = 0; x<1; x++)
        {
            Map<String, Schema.SObjectType> 
                describeInfo = Schema.getGlobalDescribe();
        }
        Benchmarking.markReferenceEndTime();
        Benchmarking.markTargetStartTime();
        for(Integer x = 0; x<1000; x++)
        {
            Map<String, Schema.SObjectType>

            describeInfo = Schema.getGlobalDescribe();
        }
        Benchmarking.reportResults(1000);
    }
}