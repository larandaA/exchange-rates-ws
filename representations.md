# Representations

## Bank

Representation of a bank information. It contains a full bank name (`name`) and a short unique descriptor (`id`).

The `rates` field contains a link to rates information offered by this bank (used in [this][get-rate] request).

```{json}
{
    "name": str,
    "id": str,
    "rates": "/banks/:id/rates",
}
```

## Rate info

Representation of an exchange rate info. The `toName` and `toUnit` fields contain the name of the currency to buy and amount of money to buy. The `fromName` and `fromUnit` fields contain information about the currency to sell respectively. The `cost` field contains the amount of units of the currency that you need to sell in order to by one unit of the destination currency. It means that in order to buy `N` of the destination currency you need to sell `(N / toUnit) * cost * fromUnit` of the initial currency.

```{json}
{
    "cost": float,
    "toUnit": float,
    "toName": str,
    "fromUnit": float,
    "fromName": str,
}
```

## Exchange rate

Representation that contains the full information about the excange rate in a single bank. The `bank` field contains the [representaion of the bank][bank-representation] that offers the rate described in the `rate` field in format of [rate info representation][rate-representation]. The `self` field contains the link to this resource that can be used either in [this][get-rate] either in [this][get-min] request.

```{json}
{
    "bank": bank,
    "rate": rateInfo,
    "self": str,
}
```

[rate-representation]: representations.md#rate-info
[bank-representation]: representations.md#bank
[get-bank]: requests.md#getting-a-single-bank-info
[get-rate]: requests.md#getting-rate-that-is-offered-by-a-single-bank
[get-min]: requests.md#getting-the-minimum-rate
