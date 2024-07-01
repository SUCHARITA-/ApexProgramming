/**
 * @description : Here want to measure the time to perform a very simple operation – say, incrementing an integer number.
 */
@isTest
public without sharing class primitiveTests {

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
}  