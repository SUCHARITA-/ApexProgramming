### Bulk Pattern

**"All of your Apex code should be designed to handle bulk operations. All of it – no exceptions."**


**Use Case**

Logic to automatically assign an existing contact as the primary contact based on the following logic: 

1. Contacts are often associated with multiple opportunities. Whichever contact is a primary contact on the most opportunities should be chosen as primary.
2.If there is a tie on the above criteria, whichever contact is associated with the most opportunities (primary or not) should be chosen as primary.
3.If there is a tie, choose an arbitrary contact to be primary.
4.If there are no related contacts on an opportunity, create a task for the opportunity owner (if a task doesn’t already exist).
5.This is based on the idea that the contact who is involved in the most opportunities would be the most likely contact on new opportunities.


**Note : Regarding Unit Testing**
**How do you ensure that the tasks being queried during the validation are those that were created during this execution context?**

It’s a trick question – unit tests, by default, only see data that was created during the unit test. There are a few exceptions – for example, unit tests can see existing static resources and User objects (user data). 

You can change this behavior and allow your unit tests to see existing organization data by using the **SeeAllData=true** attribute on the unit test. When you do so, you must be careful to differentiate in your tests between test data and existing data. A common way to do this is by maintaining a list of IDs for created test data and using it in queries to make sure you only validate records that you have created. Don’t worry though, even when SeeAllData is true, any modifications you make to the database during a unit test are discarded when the test is complete.


**Design Patterns**
1. Create Utility function that can be shared by multiple test methods
2. You can also initialize test data in a unit test by creating a method with the @testSetup annotation as you saw earlier in the TestHeapAndSOQL class. 

While more efficient, the approach used here is more flexible, in that it allows each class using the initialization function to specify different numbers of objects. This approach also allows the initialization function to return references to the created objects to the test code without the need for a separate query. 

As is generally the case when there is more than one way to accomplish a task, you should choose the approach that is best for your particular scenario. Don’t assume that the newer feature (in this case the @testSetup annotation) is always the best choice for every situation. 

3. Unit tests are unique in that they have two sets of governor limits available: one set used for setting up data and verifying results, and one set for the test itself (the code between a call to the Test.StartTest and Test.StopTest methods).

4. You learned that limit issues are generally addressed by trading off one limit against another. And indeed, the way you typically bulkify code with SOQL or DML operations inside of loops, is to use collections to prepare the necessary data and hold the results, moving the SOQL or DML out of the loop - trading additional code for a reduction in SOQL and DML operations.
  
 