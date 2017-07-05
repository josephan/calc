defmodule Calc do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    Calc.Window.start

    children = []
    opts = [strategy: :one_for_one, name: Calc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
