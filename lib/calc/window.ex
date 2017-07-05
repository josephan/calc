defmodule Calc.Window do
  import Bitwise

  def start do
    wx = :wx.new
    panel = :wxFrame.new(wx, -1, 'Hello World')
    
    first_row  = :wxBoxSizer.new(:wx_const.wx_horizontal)
    second_row = :wxBoxSizer.new(:wx_const.wx_horizontal)
    third_row  = :wxBoxSizer.new(:wx_const.wx_horizontal)
    fourth_row = :wxBoxSizer.new(:wx_const.wx_horizontal)
    rows       = :wxBoxSizer.new(:wx_const.wx_vertical)
    display    = :wxTextCtrl.new(panel, 30, value: '0')

    :wxSizer.add(rows, display, flag: (:wx_const.wx_expand ||| :wx_const.wx_all))
    :wxSizer.add(rows, first_row)
    :wxSizer.add(rows, second_row)
    :wxSizer.add(rows, third_row)
    :wxSizer.add(rows, fourth_row)

    one   = :wxButton.new(panel, 11, label: '1')
    two   = :wxButton.new(panel, 12, label: '2')
    three = :wxButton.new(panel, 13, label: '3')
    add   = :wxButton.new(panel, 41, label: '+')

    :wxSizer.add(first_row, one)
    :wxSizer.add(first_row, two)
    :wxSizer.add(first_row, three)
    :wxSizer.add(first_row, add)

    four     = :wxButton.new(panel, 14, label: '4')
    five     = :wxButton.new(panel, 15, label: '5')
    six      = :wxButton.new(panel, 16, label: '6')
    subtract = :wxButton.new(panel, 42, label: '-')

    :wxSizer.add(second_row, four)
    :wxSizer.add(second_row, five)
    :wxSizer.add(second_row, six)
    :wxSizer.add(second_row, subtract)

    seven = :wxButton.new(panel, 17, label: '7')
    eight = :wxButton.new(panel, 18, label: '8')
    nine  = :wxButton.new(panel, 19, label: '9')
    mult  = :wxButton.new(panel, 43, label: 'x')

    :wxSizer.add(third_row, seven)
    :wxSizer.add(third_row, eight)
    :wxSizer.add(third_row, nine)
    :wxSizer.add(third_row, mult)

    dot   = :wxButton.new(panel, 21, label: '.')
    zero  = :wxButton.new(panel, 20, label: '0')
    clear = :wxButton.new(panel, 22, label: 'C')
    div   = :wxButton.new(panel, 44, label: '%')

    :wxSizer.add(fourth_row, dot)
    :wxSizer.add(fourth_row, zero)
    :wxSizer.add(fourth_row, clear)
    :wxSizer.add(fourth_row, div)

    equal = :wxButton.new(panel, 45, label: '=')
    :wxSizer.add(rows, equal, flag: (:wx_const.wx_expand ||| :wx_const.wx_all))

    :wxPanel.setSizer(panel, rows)

    :wxFrame.show(panel)
  end
end
