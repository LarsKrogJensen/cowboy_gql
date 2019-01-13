defmodule PlugEx.SocketHandler do
  require Logger

  @behaviour :cowboy_websocket
  def init(req, state) do
    Logger.info("Init #{format_self()}")
    {:cowboy_websocket, req, state}
  end

  def websocket_init(_state) do
    Logger.info("WebSocket.init #{format_self()}")
    state = %{}
    {:ok, state}
  end

  def websocket_info(info, state) do
    {:reply, {:text, info}, state}
  end

  def websocket_handle({:text, message}, state) do
    Logger.info("WebSocket handle text #{message} #{format_self()}")
    json = Jason.decode(message)
    IO.puts(inspect(json))
    websocket_handle_command(json, state)
  end

  defp websocket_handle_command({:ok, json}, state) do
    Logger.info("WebSocket handle json #{inspect(json)}")
    {:ok, result} = Absinthe.run(json["query"], Gqlone.Schema)
    result |> inspect() |> IO.puts
    {:reply, {:text, Jason.encode!(result)}, state}
  end

  defp websocket_handle_command({:error, error}, state) do
    Logger.info("WebSocket handle json error  #{inspect(error)}")

    {:reply, {:text, Jason.encode!(%{"invalid_json" => error.data})}, state}
  end

  def terminate(_reason, _req, _state) do
    Logger.info("WebSocket terminate")
    :ok
  end

  defp format_self, do: inspect(self())
end
