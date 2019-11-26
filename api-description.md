## API description

The WEB-service uses REST architecture style. Some of the reasons why this architecture style is appropriate are the following:

* WEB-service has a client-server architecture.
* No client state is transferred during the client-server communication.
* The messages are actually resources representations.
* The server responses to GET requests can be cached.

But comparing to the pure REST this service has some differences:

* The messages are not self-descriptive, i.e. clients will have to hard-code the message description and parsing.
* Not all of the resources have their identifiers.
