# benchmark scripts

## Benchmark any http endpoint

```sh
export APP_URL=localhost:8000
time (for i in {1..5}; do curl -L $APP_URL;echo \n;done)
```
