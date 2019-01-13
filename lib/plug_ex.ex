defmodule PlugEx do
  @moduledoc """
  Hahahah
  """
  use Application
  require Logger

  def start(_type, _args) do
    port = Application.get_env(:plug_ex, :cowboy_port, 8080)
    Logger.info("Application started on port #{port}")

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: PlugEx.Router,
        options: [
          port: port,
          dispatch: dispatch()
        ]
      ),
      %{
        id: Phoenix.PubSub.PG2,
        start: {Phoenix.PubSub.PG2, :start_link, [:time_tracker, []]}
      },
      {PlugEx.ClockServer, %{}}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp dispatch do
    [
      {:_,
       [
         {"/ws/[...]", PlugEx.SocketHandler, []},
         {:_, Plug.Cowboy.Handler, {PlugEx.Router, []}}
       ]}
    ]
  end

  @doc """
  Hey
  """
  @spec sum(integer, integer) :: integer
  def sum(a, b) do
    a + b
  end

  @spec hello() :: :world
  def hello() do
    :world
  end
end
