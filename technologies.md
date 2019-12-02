## Technologies

### Overview

I decided to try different technologies and to compare them later while load testing:

* Haskell with the Scotty web framework
* Crystal with the Kemal web framework

Both hello world implementations can reply to the same request `GET /hello/:word` in the following format:

```{json}
{
    "hello": word
}
```

Both implementations have customized 404 responses for all other requests.

In both cases the applications will behave like standalone HTTP servers because no recent FastCGI libraries were found for them that support the latest `libfcgi` version.

### Haskell & Scotty

Haskell is a pure functional language that is designed to be easily parallelized so it seems interesting to see how it will behave under high load.

Sources can be found [here](erws-scotty). Run the following command to start the server:

```
stack run -- --protocol http --port 3000
```

### Crystal & Kemal

Crystal is a new programming language that is heavily influenced and inspired by Ruby which is a well-established language in the web-developer community but it is statically typed and compiles to native code which makes it much faster.

Sources can be found [here](erws-kemal). Run the following command to start the server:

```
crystal run hello.cr
```
