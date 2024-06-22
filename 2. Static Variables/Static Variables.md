### <u>Static Variables in Apex</u>

**Static variables in traditional languages**
Developers are accustomed to use static variables in a variety of design patterns, such as sharing data between classes, counting pr maintaining lists of class instances etc.
Devlopers of multi-threaded applications also know to take care to synchronize access to static variables, in order to avoid the race condition or data curruption.

**Except for Apex**
The Static variables in Apex is different from traditional languages and has huge impact the way they are used.
In other words, static variables can only be accessed from within the execution context in which they are created and are deleted when the execution context complestes.


