### Integration in Salesforce

[!IMPORTANT]
This topic is not part of / from Dan Appleman's book Advance Apex Programming. This file is sneak-peak for integration stuff in one place.

In this section, we'll see how Integration can be performed in Salesforce. The screenshots and data is taken from Salesforce + Trailhead. Below points are going to be covered

1. Integration Patterns in Salesforce
2. Pattern selection / When to choose whom
3. Scenarios and solutions


**Integration Patterns**

We have many intgration patterns and these patterns are divided into 3 categories. Which are Data Integration, Process Integration and Virtual/UI Integrations.

![alt text](IntegrationPatternsCategory.png)

Read More : (https://developer.salesforce.com/docs/atlas.en-us.integration_patterns_and_practices.meta/integration_patterns_and_practices/integ_pat_pat_approach.htm)


Now let's see Integration Patterns as below:

![alt text](IntegrationPatterns.png)


**Pattern Selection**

The matrix for selecting integration pattern is Type (i.e. Type of Integration) and Time (i.e. Synchronous or Asynchronous).

(https://developer.salesforce.com/docs/atlas.en-us.integration_patterns_and_practices.meta/integration_patterns_and_practices/integ_pat_selection_guide.htm)

Apart from above, below image (from Apex Hours) shows what tools you can use to execute integration for a given type.

![alt text](PatternSelection.png)


**Scenarions and Solutions**

Now choosing correct integration pattern is not trival, lot of understandings, thought process goes in to select it. Salesforce has already provided document. Where it show scenarios and corresponding solutions

Read More : (https://developer.salesforce.com/docs/atlas.en-us.integration_patterns_and_practices.meta/integration_patterns_and_practices/integ_pat_remote_process_invocation_state.htm)

Additional Reference :
1. Common Salesforce Integration Scenarios and Solutions (https://www.youtube.com/watch?v=p6UsHsNulzc)
2. Salesforce Integration Patterns & Best Practices (https://www.youtube.com/watch?v=2ITAPPQaCig)
3. https://resources.docs.salesforce.com/latest/latest/en-us/sfdc/pdf/integration_patterns_and_practices.pdf


