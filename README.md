# NxMicroBench

NxMicroBench is a benchmark suite that aims to identify how long each Nx function takes to execute.

# Run benchmarks

Before running this benchmark suite, you will need to run the following command to install libraries:

```
$ mix deps.get
```

Then, you can run each benchmark in the `bench` directory. For example:

```
$ mix run bench/nx_tensor_bench.exs 
```
