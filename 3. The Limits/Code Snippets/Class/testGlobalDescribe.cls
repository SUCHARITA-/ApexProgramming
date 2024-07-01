/**
 * @description : The Schema.getGlobalDescribe function is documented as using internal caching, so it should run slowly the first time and more quickly on subsequent calls.
 */
@isTest
public without sharing class testGlobalDescribe {
    @istest
    public static void testBenchmarking(){
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