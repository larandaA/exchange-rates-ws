# Representations

## Bank

```{json}
{
    "name": str,
    "id": str,
    "self": str,
}
```

## Rate info

```{json}
{
    "cost": float,
    "toUnit": int,
    "toName": str,
    "fromUnit": int,
    "fromName": str,
}
```

## Exchange rate

```{json}
{
    "bank": bank,
    "rate": rateInfo,
    "self": str,
}
```
