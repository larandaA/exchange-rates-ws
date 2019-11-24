## Requests

### The `banks` collection

The `banks` collection contains information about all the banks represented in this system. End users have no access to change this information.

#### Getting the list of all banks

Method: `GET /banks`.

Response:

```{json}
{
    "banks": [bank],
    "self": "/banks",
}
```

where `bank` is a [bank representation][bank-representation].

#### Getting a single bank info

Method: `GET /banks/:id` where `id` is a unique bank descriptor.

Response: `bank` where `bank` is a [bank representation][bank-representation].

### The `rates` collection

The `rates` collection contains information about the exchange rates that are offered by banks described in the above section. End users have no access to change this information.

#### Getting all rates

Method: `GET /rates`

Response:

```{json}
{
   "rates": [rate],
   "self": "/rates",
}
```

where `rate` is a [rate representation][rate-representation].

#### Getting the minimum rate

Method: `GET /rates/min`

Response: `rate` where `rate` is a [rate representation][rate-representation].

### Rate by a bank

#### Getting rate that is offered by a single bank

Method: `GET /banks/:id/rates` where `id` is a unique bank descriptor.

Response: `rate` where `rate` is a [rate representation][rate-representation].

#### Updating rate that is offered by a single bank

Method: `PUT /banks/:id/rates` where `id` is a unique bank descriptor.

Request: `rate` where `rate` is a [rate representation][rate-representation]. Fields `self`, `bank.self`, `bank.name` are ignored.

Response: `rate` where `rate` is a [rate representation][rate-representation].

[bank-representation]: representations.md#bank
[rate-representation]: representations.md#exchange-rate
