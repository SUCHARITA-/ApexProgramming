**Limits! Where it come from**

We know that Salesforce is into Cloud Computing.On the cloud, where servers are shared among many clients, but how do you deal with those situations that suddenly demand a huge amount of resources? 

One approach, used by cloud systems such as Amazon Web Services, is to provide users with virtual machines that have a specified limit on computational resources (memory, CPU speed, etc.) and if more
is needed that can be purchased.

But Salesforce took a different approach befits its different architecture(multi-tenancy architecture).

To protect the cloud from having any one bug,problem or requirement tie up too many resources, monitoring was built-in to the underlying application programming language to prevent applications from exceeding certain LIMITs.