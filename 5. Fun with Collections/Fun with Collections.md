### Fun with Collections

The Apex collections : List,Set and Map. Here are some of the issues that you may run into.

**1. Using Map to obtain Set**

One of the most common operations in Apex involves retrieving a related list of objects. In this example, assume you have a list of contacts and wish to retrieve the related tasks. You certainly wouldn’t use a loop to perform a query for each contact, as that would quickly fail in a bulk operation. Instead, you need a list or set of the contact IDs, so that you can retrieve all of the tasks for those contacts in one query. You could build the set and perform the query like this:  

```
Set<ID> contactIds = new Set<ID>();
for(Contact ct: cts) contactIds.add(ct.id);
 
List<Task> tasks = [Select ID from Task where Whoid in :contactIds  Limit 500];

//But in most cases you’ll prefer to do it like this: 
Map<ID, Contact> contactMap = new Map<ID, Contact>(cts);
       
List<Task> tasks2 = [Select ID from Task where Whoid in :contactMap.keyset()  Limit 500];  

```
       
When you pass a list as a constructor parameter to a newly created map with an ID key, the map is created using the ID property of the object as the map key. Using a map in this manner is a slightly inefficient use of memory (assuming you don’t actually need the map itself), but it is much more efficient than using a loop to populate a set (typically better than 5 times as fast).

**2. Case Sensitivity**

Keys on maps are case sensitive, except when they are not.


**3. Avoid using Objects as keys**

Apex uses a hash of the field values as the internal value to use when searching for the object in the map or set. Changing a field on an object changes this hash value, causing the same object to appear as two distinct objects when used as keys.

The **right design pattern** is to use the object ID as the key or set value. 


**4. Keeping Track of Objects to Update**

There are good reasons to design your code so that you can add functionality to a trigger, or combine all of the updates required by several distinct triggers or classes into a single update operation. For this reason, you should always use a map that is keyed to the object ID (or other unique field). 

```
Map<ID,Contact> contactsToUpdate = new Map<ID, Contact>();
      
// First set of operations
for(Contact ct: cts)
{
    // Do various operations
    // If an update is needed:
    contactsToUpdate.put(ct.id, ct);
}

// Second set of operations
for(Contact ct: cts)
{
    // Do various operations
    // If an update is needed:
    contactsToUpdate.put(ct.id, ct);
}

if(contactsToUpdate.size()>0) 
    update contactsToUpdate.values();
```

**5. The Contains Method**

Avoid using the List.contains method for very long lists. What is a very long list? That depends on many factors. For example: it depends on what you are comparing – the harder it is to compare two elements, the greater the advantage of using a Set. 

That’s because a **Set uses a hashtable index** to speed up searches. It’s literally designed for that purpose. Whereas the List.contains method scans the list for the element you are looking for.


**6. Eliminating Duplicate Fields from Queries**

Dynamic SOQL is used to query objects when you don’t know ahead of time what fields will need to be in the query.

Clearly, unless your field list is hardcoded, it’s a good idea to test for and remove any duplicates. By far the easiest way to do this is using a Set, as Sets ensure that every element is unique. You might try to maximize efficiency by taking the following approach: 

```
Set<String> fieldSet = new Set<String>();
String fields = string.join(fieldList,',');
fieldSet.addAll(fields.toLowerCase().split(','));
fieldList = new List<String>(fieldSet);

```
**There is, however, one situation where this approach may fail – specifically, if you are in a namespaced org – that is, an org used for developing a package.**

A better approach

```
Set<String> fieldSet = new Set<String>();
String ourprefix = 'xyz' + '__';

for(String f: fieldList)
{
    f = f.toLowerCase();
   
    // Strip off your own namespace here if necessary
    if(!String.isEmpty(ourprefix) && f.startsWith(ourprefix)) 
        f = f.replace(ourprefix,'');

    // Optionally test for presense of the field using 
    // describe info (not shown here)
    fieldSet.add(f);
}
fieldList = new List<String>(fieldSet);

```
 
 