## CAP Theorem

### General thoughts

What should we keep in mind while designing the service is that all the banks update their rate information at different time.
And since there is not a lot of banks, the write requests will be rather rare unlike read requests.
Rare write requests at unpredicted time mean that we can sarcifice strict consistency during milliseconds after update and eventual consistency is enough.

Also, from the point of view of a user they don't see the difference between the exchange rate that is not updated yet and already updated exchange rate.
The first type means that it can be updated anytime.
To give more context about the current situation to users we can add update timestamp to the exchange rate representation.

But what will happen in case of partition?
If we are lucky and there are no updates during this time then any solution works for us, but what will happen if some bank wants to update its exchange rate?

### CP

If we choose the CP way then the following behaviour is expected:

* Banks are not allowed to update their information.
* All the users see the same information.

But excange rates are not controlled by our database and not changing it there will not prevent banks from changing it on their side.
It means that users will see information inconsistent with real world and, what is worse, we will know that it is inconsistent.

Another problem is that we have no ability to notify banks that they can update their information after patition problems are solved.

### AP

If we choose the AP side then we can follow the behaviour below:

* Banks are able to update their information but only on some machines.
* Users can see different information (some of it is up-to-date and some is not).

In this case it is less inconvenient to banks because they can update information anytime once at least one server is available.
Users see more up-to-date information because we show as much recent information as possible in case of connection failure between servers.

### Decision and technologies

Considering to the tradeoff it seems like AP is more appropriate to such service because we are more available to the banks and more fair to the users.

To ensure AP we can use Cassandra without consistency level set up. With this configuration Cassandra works in eventual consistency mode.
In order to resolve merge issues we will use update timestamp criteria: the more recent timestamp has higher priority.


