defmodule Calc.Window do
  import Bitwise
  alias Calc.CalculatorServer

  require Record
  Record.defrecordp :wx, Record.extract(:wx, from_lib: "wx/include/wx.hrl")
  Record.defrecordp :wxClose, Record.extract(:wxClose, from_lib: "wx/include/wx.hrl")
  Record.defrecordp :wxCommand, Record.extract(:wxCommand, from_lib: "wx/include/wx.hrl")

  @one 11
  @two 12
  @three 13
  @four 14
  @five 15
  @six 16
  @seven 17
  @eight 18
  @nine 19
  @zero 20

  @display 30
  @dot 21
  @clear 22
  @add 41
  @subtract 42
  @mult 43
  @div 44
  @equal 45

  def start do
    wx = :wx.new
    panel = :wxFrame.new(wx, -1, 'Hello World')
    display = setup(panel)
    :wxFrame.connect(panel, :close_window)
    :wxFrame.connect(panel, :command_button_clicked)
    :wxFrame.show(panel)
    {:ok, calc} = CalculatorServer.start_link
    loop(panel, calc, display)
    :wxFrame.destroy(panel)
  end

  def loop(panel, calc, display) do
    :wxTextCtrl.setValue(display, to_char_list(CalculatorServer.get_display(calc)))
    receive do
      wx(event: wxClose()) ->
        IO.puts "close_window received"
      wx(id: id, event: wxCommand(type: :command_button_clicked)) ->
        handle_button(id, calc)
        loop(panel, calc, display)
      event ->
        IO.inspect(event)
        IO.puts "Message received"
        loop(panel, calc, display)
    end
  end

  def handle_button(@one, calc), do: calc |> CalculatorServer.number(1)
  def handle_button(@two, calc), do: calc |> CalculatorServer.number(2)
  def handle_button(@three, calc), do: calc |> CalculatorServer.number(3)
  def handle_button(@four, calc), do: calc |> CalculatorServer.number(4)
  def handle_button(@five, calc), do: calc |> CalculatorServer.number(5)
  def handle_button(@six, calc), do: calc |> CalculatorServer.number(6)
  def handle_button(@seven, calc), do: calc |> CalculatorServer.number(7)
  def handle_button(@eight, calc), do: calc |> CalculatorServer.number(8)
  def handle_button(@nine, calc), do: calc |> CalculatorServer.number(9)
  def handle_button(@add, calc), do: calc |> CalculatorServer.add
  def handle_button(@subtract, calc), do: calc |> CalculatorServer.subtract
  def handle_button(@mult, calc), do: calc |> CalculatorServer.multiply
  def handle_button(@div, calc), do: calc |> CalculatorServer.divide
  def handle_button(@equal, calc), do: calc |> CalculatorServer.equals
  def handle_button(_, _), do: IO.puts("button clicked")

  def setup(panel) do
    first_row  = :wxBoxSizer.new(:wx_const.wx_horizontal)
    second_row = :wxBoxSizer.new(:wx_const.wx_horizontal)
    third_row  = :wxBoxSizer.new(:wx_const.wx_horizontal)
    fourth_row = :wxBoxSizer.new(:wx_const.wx_horizontal)
    rows       = :wxBoxSizer.new(:wx_const.wx_vertical)
    display    = :wxTextCtrl.new(panel, @display, value: '0')

    :wxSizer.add(rows, display, flag: (:wx_const.wx_expand ||| :wx_const.wx_all))
    :wxSizer.add(rows, first_row)
    :wxSizer.add(rows, second_row)
    :wxSizer.add(rows, third_row)
    :wxSizer.add(rows, fourth_row)

    one   = :wxButton.new(panel, @one, label: '1')
    two   = :wxButton.new(panel, @two, label: '2')
    three = :wxButton.new(panel, @three, label: '3')
    add   = :wxButton.new(panel, @add, label: '+')

    :wxSizer.add(first_row, one)
    :wxSizer.add(first_row, two)
    :wxSizer.add(first_row, three)
    :wxSizer.add(first_row, add)

    four     = :wxButton.new(panel, @four, label: '4')
    five     = :wxButton.new(panel, @five, label: '5')
    six      = :wxButton.new(panel, @six, label: '6')
    subtract = :wxButton.new(panel, @subtract, label: '-')

    :wxSizer.add(second_row, four)
    :wxSizer.add(second_row, five)
    :wxSizer.add(second_row, six)
    :wxSizer.add(second_row, subtract)

    seven = :wxButton.new(panel, @seven, label: '7')
    eight = :wxButton.new(panel, @eight, label: '8')
    nine  = :wxButton.new(panel, @nine, label: '9')
    mult  = :wxButton.new(panel, @mult, label: 'x')

    :wxSizer.add(third_row, seven)
    :wxSizer.add(third_row, eight)
    :wxSizer.add(third_row, nine)
    :wxSizer.add(third_row, mult)

    dot   = :wxButton.new(panel, @dot, label: '.')
    zero  = :wxButton.new(panel, @zero, label: '0')
    clear = :wxButton.new(panel, @clear, label: 'C')
    div   = :wxButton.new(panel, @div, label: '%')

    :wxSizer.add(fourth_row, dot)
    :wxSizer.add(fourth_row, zero)
    :wxSizer.add(fourth_row, clear)
    :wxSizer.add(fourth_row, div)

    equal = :wxButton.new(panel, @equal, label: '=')
    :wxSizer.add(rows, equal, flag: (:wx_const.wx_expand ||| :wx_const.wx_all))

    :wxPanel.setSizer(panel, rows)
    display
  end
end
