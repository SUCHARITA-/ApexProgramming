### Limits! Where it come from

We know that Salesforce is into Cloud Computing.On the cloud, where servers are shared among many clients, but how do you deal with those situations that suddenly demand a huge amount of resources? 

One approach, used by cloud systems such as Amazon Web Services, is to provide users with virtual machines that have a specified limit on computational resources (memory, CPU speed, etc.) and if more
is needed that can be purchased.

But Salesforce took a different approach befits its different architecture(multi-tenancy architecture).

To protect the cloud from having any one bug,problem or requirement tie up too many resources, monitoring was built-in to the underlying application programming language to prevent applications from exceeding certain LIMITs.

**Nature of Limits**
There is a trick when looking at limits in Apex. Don’t focus on the values that you aren’t supposed to exceed. Instead, consider each limit a pointer to an operation that you want to optimize throughout your code. 

There are two reasons for taking this approach: 

1. If you focus on optimizing all of your limit related code, in many cases you will never come close to using the available limits.

2. Remember that your code may not be the only code running in an execution context or organization. There may already be existing code in an organization. Some other developer may add other triggers after you are no longer around. If you are creating a package, there may be other packages installed that might be sharing some limits. If you focus on minimizing your own resource use, you are much more likely to avoid conflicts with other code.

**Important to Note**
All of the Apex code on your system will share one set of limits. There are **two exceptions** to this. 

The first, and most important, is that when creating unit tests, you have one set of limits for test initialization and validation, and another for running the test itself (the code between the StartTest and StopTest methods – you’ll read more about this in chapter 11). 

The other exception relates to managed packages that are listed on the AppExchange by Salesforce.com ISV partners. These packages can receive their own set of governor limits within an execution context. This is important both for users – who can install packages with less worry that they will cause existing code to start failing due to Apex limits, and for package developers, who can be more confident that their packages will not fail due to limits caused by other packages or custom code on an organization.