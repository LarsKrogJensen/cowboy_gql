defmodule PlugEx.SocketHandler do
  require Logger

  @behaviour :cowboy_websocket
  def init(req, state) do
    Logger.info("Init")
    {:cowboy_websocket, req, state}
  end

  def websocket_init(_state) do
    Logger.info("WebSocket.init")
    state = %{}
    {:ok, state}
  end

  def websocket_info(info, state) do
    {:reply, {:text, info}, state}
  end

  def websocket_handle({:text, message}, state) do
    Logger.info("WebSocket handle text #{message}")
    {:ok, json} = Jason.decode(message)
    IO.puts inspect(json)
    websocket_handle({:json, json}, state)
    # {:reply, {:text, "hello world"}, state}
  end

  def websocket_handle({:json, json}, state) do
    Logger.info("WebSocket handle json #{json}")
    {:reply, {:text, "hello world"}, state}
  end

  # def websocket_info(_info, state) do
  #     {:reply, state}
  # end

  def terminate(_reason, _req, _state) do
    Logger.info("WebSocket terminate")
    :ok
  end
end
