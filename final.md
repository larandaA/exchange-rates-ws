## Final

### Implementation

Sources can be found [here](erws/erws.cr).

### Testing

Database was populated using [this script](load-testing/populate.py).
Requests were generated using [this script](load-testing/generate_requests.py).
Final requests were constructed using ammo generator can be found [here](load-testing/ammo.txt).

Number of min rate requests is the same as number of requests for a single bank rate. Few update requests were added as well.

[This test](https://overload.yandex.net/240808) shows that the server can handle up to 500 RPS.
Basing on experiments the reason of failure is impossibility of increasing the size of the connection pool to the database because of low resources available on the machine.

[This test](https://overload.yandex.net/24081) shows the stable performance of the service on 250 RPS. Update requests are handled within <100ms, min rate and single bank rate  requests are handled within <50ms.

