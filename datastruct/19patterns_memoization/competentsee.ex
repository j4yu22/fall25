"""
In your editor, implement a memoized function to determine the optimal price for a product based on competitor data.
"""
defmodule PriceOptimizer do
  @doc """
  Starts the memoization cache.
  """
  def start_cache() do
    Agent.start_link(fn -> %{} end, name: __MODULE__.Cache)
  end

  @doc """
  Computes the optimal price based on competitor prices.
  Uses memoization to avoid recomputation.
  """
  def optimal_price(competitor_prices) when is_list(competitor_prices) do
    key = Enum.sort(competitor_prices)

    Agent.get_and_update(__MODULE__.Cache, fn cache ->
      case Map.fetch(cache, key) do
        {:ok, cached} ->
          {cached, cache}

        :error ->
          price = compute_optimal_price(key)
          {price, Map.put(cache, key, price)}
      end
    end)
  end

  # --- internal logic ---

  # placeholder business logic:
  # choose a price slightly below the average competitor price
  defp compute_optimal_price(prices) do
    avg =
      prices
      |> Enum.sum()
      |> Kernel./(length(prices))

    Float.round(avg * 0.95, 2)
  end
end
