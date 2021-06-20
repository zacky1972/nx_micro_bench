# NxMicroBench

NxMicroBench is benchmarks that aim to identify how long each Nx function takes to execute.

# Run benchmarks

Before running this benchmarks, you will need to run the following command to install libraries:

```
$ mix deps.get
```

Then, you can run each benchmark in the `bench` directory. For example:

```
$ mix run bench/nx_tensor_bench.exs 
```
