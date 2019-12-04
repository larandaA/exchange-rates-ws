## Requests

### The `rates` collection

The `rates` collection contains information about the exchange rates that are offered by different banks. End users have no access to change this information.

#### Getting all rates

Method: `GET /rates`

Content type: `application/vnd.erws.ratelist+json`

Response:

```{json}
{
   "rates": [rate],
   "self": "/rates",
}
```

where `rate` is an [exchange rate representation][rate-representation].

#### Getting the minimum rate

Method: `GET /rates/min`

Content type: `application/vnd.erws.rate+json`

Response: `rate` where `rate` is an [exchange rate representation][rate-representation].

### Rate by a bank

#### Getting rate that is offered by a single bank

Method: `GET /banks/:id/rates` where `id` is a unique bank descriptor.

Content type: `application/vnd.erws.rate+json`

Response: `rate` where `rate` is an [exchange rate representation][rate-representation].

#### Updating rate that is offered by a single bank

Method: `PUT /banks/:id/rates` where `id` is a unique bank descriptor.

Content type: `application/vnd.erws.rate+json`

Request: `rate` where `rate` is an [exchange rate representation][rate-representation]. Fields `self`, `bank.rates`, `bank.name` are ignored.

Response: `rate` where `rate` is an [exchange rate representation][rate-representation].

[bank-representation]: representations.md#bank
[rate-representation]: representations.md#exchange-rate
