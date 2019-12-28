## Load testing of Hello World

### Haskell & Scotty

The goal of [this test](https://overload.yandex.net/240414) was to see what load the service can handle.
Number of RPS was linearly increasing all the time.
Here we can easily see that on the point of ~1800 RPS the service stops responding.
We can see the higly increasing number of context switches on the monitoring tab and highly increasing number of threads of the loader.
These statistics may mean that the server constantly creates new threads to handle incoming requests and finally the number of possible open sockets exceeds the limit that leads to unrecoverable error in the server.

The load of 600 RPS [was tested](https://overload.yandex.net/240421) to be enough for the service to handle the load stably.
99% of requests got response in 34 ms, 75% and 50% — in ~1 ms. CPU and memory usage were not over 75% (CPU usage is much lower).

### Crystal & Kemal

[This test](https://overload.yandex.net/240423) was used to find the maximum load for the service.
Here we can see that the requests are probably kept in some queue and then processed by workers of which the number is controlled.
That's why the maximum response time is always increasing but all (except 1) the responses were received.
So the problem of this server is the number of threads that is much higher than the number of CPUs what makes context switching too expensive.
It means that increasing number of CPUs will help to increase the load that the server can handle.

[This test](https://overload.yandex.net/240425) shows that the service can handle the load of 1000 RPS.
99% of requests got their responses in 16 ms, 75% and 50% — in <1 ms. CPU usage is always below 25% and no limits for memory.

### Decision

The rest of the service will be implemented in Crystal because it shows more stable results handling much higher load.
It is more reliable since the overload doesn't lead to unrecoverable errors. Moreover it more efficiently utilizies CPU.
