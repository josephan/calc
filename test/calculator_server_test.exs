defmodule CalculatorServerTest do
  use ExUnit.Case
  alias Calc.CalculatorServer, as: CS

  test "basic addition" do
    {:ok, server} = CS.start_link
    assert "0" == CS.get_display(server)
    server |> CS.number(1)
    assert "1" == CS.get_display(server)
    server |> CS.add
    assert "1" == CS.get_display(server)
    server |> CS.number(2)
    assert "2" == CS.get_display(server)
    server |> CS.equals
    assert "3" == CS.get_display(server)
  end

  test "basic subtraction" do
    {:ok, server} = CS.start_link
    server |> CS.number(1)
    server |> CS.subtract
    server |> CS.number(2)
    server |> CS.equals
    assert "-1" == CS.get_display(server)
  end

  test "basic multiplication" do
    {:ok, server} = CS.start_link
    server |> CS.number(9)
    server |> CS.multiply
    server |> CS.number(9)
    server |> CS.equals
    assert "81" == CS.get_display(server)
    server |> CS.number(9)
    server |> CS.multiply
    server |> CS.number(9)
    server |> CS.equals
    assert "81" == CS.get_display(server)
  end

  test "basic division" do
    {:ok, server} = CS.start_link
    server |> CS.number(18)
    server |> CS.divide
    server |> CS.number(9)
    server |> CS.equals
    assert "2.0" == CS.get_display(server)
  end

  test "clear button" do
    {:ok, server} = CS.start_link
    server |> CS.number(1)
    server |> CS.clear
    assert "0" == CS.get_display(server)
  end
end
