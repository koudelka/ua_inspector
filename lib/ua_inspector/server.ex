defmodule UAInspector.Server do
  @moduledoc """
  UAInspector poolboy worker (server).
  """

  use GenServer

  @behaviour :poolboy_worker

  def start_link(default \\ %{}) do
    GenServer.start_link(__MODULE__, default)
  end

  def handle_call({ :parse, ua }, _from, state) do
    { :reply, UAInspector.Parser.parse(ua), state }
  end
end
