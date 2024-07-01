/**
 * @description : Each unit test profiles a single operation using two different loops. Both loops are identical except for the use of the operation being measured. 
 * The Limits.getCpuTime() function is used to retrieve amount of CPU time consumed up until that point. 
 * This value is stored at the start and end of each loop using the functions shown here:
 */
public without sharing class Benchmarking {
    @testvisible private static Integer referenceStartTime;
    @testvisible private static Integer referenceEndTime;
    @testvisible private static Integer targetStartTime;
    @testvisible private static Integer targetEndTime;

    @testvisible
    private static void markReferenceStartTime() {
        referenceStartTime = Limits.getCpuTime();
    }
    @testvisible
    private static void markReferenceEndTime() {
        referenceEndTime = Limits.getCpuTime();
    }
    @testvisible
    private static void markTargetStartTime() {
        targetStartTime = Limits.getCpuTime();
    }
    @testvisible
    private static void markTargetEndTime() {
        targetEndTime = Limits.getCpuTime();
    }
    /**
     * calculates the elapsed duration of the reference and target loops, 
     * then reports the time for each operation based on the number of loops specified in the loops parameter.
    */
    @testvisible
    private static void reportResults(Integer loops)
    {
        if(targetEndTime==null){
            markTargetEndTime();
        } 
        Integer referenceDuration = referenceEndTime - referenceStartTime;
        Integer targetDuration = targetEndTime - targetStartTime;
        Integer benchmarkResults = targetDuration - referenceDuration;

        // Time in microseconds is duration * 1000 / loops
        Decimal eachItem = benchmarkResults * 1000;
        eachItem /= loops;
        eachItem.setScale(2);
        
        system.debug(LoggingLevel.Error,
        'Reference Duration: ' + referenceDuration +
        ' Target duration: ' + targetDuration +
        ' Benchmark Results: ' + benchmarkResults +
        'ms or ' + eachItem + ' us per operation');
    } 
}