### <u>The Execution Context in Apex</u>

**An execution context has two characteristics:**

1. It defines the scope and lifetime of static variables.
2. It defines the context for those governor limits that are reset between execution contexts.


An execution context begins when one of a number of possible external events or operations happen that have the ability to start running Apex code:

Below is the list :
1. Trigger
2. Future Calls
3. Queueable Apex
4. Scheduled Apex
5. Batch Apex
6. Platform events
7. Web Service
8. VF and LWC
9. Flows
10. Global Apex / Global methods
11. Anonymous Apex


#### Use Case:

Consider the simple use case of a trigger on the update of a Lead Object.

Execution context with two triggers and a workflow As you can see, the field update workflow not only runs in the same execution context, it can cause the triggers to execute again within the same context. This brings up an interesting question. How can you know if your trigger is executing for the first time, or if it is executing again for the same update because of a workflow or other trigger?
 
**This is where static variables come into play. Remember, their lifetime and scope are defined by the execution context.**

```
public Static Boolean firstcall = false;

```

You could use the following **design pattern** in your trigger to determine if this was the first or subsequent call for this execution context.

```
if(!myclass.firstcall)
{
    // First call into trigger
    myclass.firstcall = true;
}
else
{
    // Subsequent call into trigger
} 

```

**Let’s consider the ramifications of what you have just seen: **

1. You can have multiple triggers on an event, but have no control over the order in which they execute.

2. Limits are shared within an Execution Context; thus you may be sharing limits with other code over which you have no control, and which may be added after yours is built and tested. 

3. Workflows, Flows and Lightning Processes, which can be created by non-programmers, can impact the order and execution of your Apex code in unpredictable ways, even causing your code to execute again for the same object and within the same execution context.


**Reference Link:** <br/>
https://salesforce.stackexchange.com/questions/33395/trigger-execution-context-and-limits

https://salesforce.stackexchange.com/questions/81361/in-apex-what-is-the-difference-between-the-execution-context-and-a-transactio

