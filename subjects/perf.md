# Perf

## Performance Analysis

<details>
<summary>Measure the processor events using perf?</summary>

> ```sh
> perf record -o /tmp/perf.data --call-graph dwarf --event instructions,cpu-cycles,cache-misses,branches,branch-misses --aio --sample-cpu <exec>
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Uw7FF5MLxZE
> ---
> **References**
> ---
</details>

## Hotspot

<details>
<summary>Visually analyze the output of perf?</summary>

> ```sh
> sudo hotspot
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=Uw7FF5MLxZE
>
> ---
> **References**
> ---
</details>
