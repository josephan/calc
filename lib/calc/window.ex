defmodule Calc.Window do
  def start do
    wx = :wx.new
    panel = :wxFrame.new(wx, -1, 'Hello World')
    :wxFrame.show(panel)
  end
end
