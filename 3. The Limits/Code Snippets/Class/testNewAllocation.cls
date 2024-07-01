/**
 * @description : demonstrates a number of interesting measurements 
 * including memory allocation and the difference in field access time between dynamic and static Apex.
 */
@isTest
public without sharing class testNewAllocation {
    @istest
    public static void testBenchmarking(){
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
}