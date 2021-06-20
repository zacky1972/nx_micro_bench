Application.put_env(:exla, :clients,
  default: [platform: :host],
  cuda: [platform: :cuda]
)

sizes =
  1..6//1
  |> Enum.map(& Integer.pow(10, &1))

rands = Enum.map(sizes, fn size -> for(_ <- 1..size, do: :rand.uniform()) end)

rands_uint =
  rands
  |> Enum.map(
    fn rand ->
      [8, 16, 32, 64]
      |> Enum.map(fn bit ->
        NxMicroBench.round_pow(rand, bit)
      end)
    end
  )

rands_sint =
  rands
  |> Enum.map(
    fn rand ->
      [8, 16, 32, 64]
      |> Enum.map(fn bit ->
        Enum.map(NxMicroBench.round_pow(rand, bit), & &1 - Integer.pow(2, bit - 1))
      end)
    end
  )

benches =
  Enum.zip([sizes, rands, rands_uint, rands_sint])
  |> Enum.map(
    fn {size, rand, rand_uint, rand_sint} ->
      [rand_uint8, rand_uint16, rand_uint32, rand_uint64] = rand_uint
      [rand_sint8, rand_sint16, rand_sint32, rand_sint64] = rand_sint

      [
        {"Nx.tensor f16 #{size}", fn -> Nx.tensor(rand, type: {:f, 16}) end},
        {"Nx.tensor f32 #{size}", fn -> Nx.tensor(rand, type: {:f, 32}) end},
        {"Nx.tensor f64 #{size}", fn -> Nx.tensor(rand, type: {:f, 64}) end},
        {"Nx.tensor s8 #{size}", fn -> Nx.tensor(rand_sint8, type: {:s, 8}) end},
        {"Nx.tensor s16 #{size}", fn -> Nx.tensor(rand_sint16, type: {:s, 16}) end},
        {"Nx.tensor s32 #{size}", fn -> Nx.tensor(rand_sint32, type: {:s, 32}) end},
        {"Nx.tensor s64 #{size}", fn -> Nx.tensor(rand_sint64, type: {:s, 64}) end},
        {"Nx.tensor u8 #{size}", fn -> Nx.tensor(rand_uint8, type: {:u, 8}) end},
        {"Nx.tensor u16 #{size}", fn -> Nx.tensor(rand_uint16, type: {:u, 16}) end},
        {"Nx.tensor u32 #{size}", fn -> Nx.tensor(rand_uint32, type: {:u, 32}) end},
        {"Nx.tensor u64 #{size}", fn -> Nx.tensor(rand_uint64, type: {:u, 64}) end}
      ]
    end
  )
  |> List.flatten
  |> Map.new

Benchee.run(
  benches,
  time: 10,
  memory_time: 2
)
