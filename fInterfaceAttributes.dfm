object frmTest: TfrmTest
  Left = 0
  Top = 0
  Caption = 'Attributes inheritance test'
  ClientHeight = 349
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  DesignSize = (
    673
    349)
  PixelsPerInch = 96
  TextHeight = 13
  object btnInterfaceTest: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Test &Intf'
    Default = True
    TabOrder = 0
    OnClick = btnInterfaceTestClick
  end
  object memOutput: TMemo
    Left = 152
    Top = 8
    Width = 513
    Height = 335
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'No Results')
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitWidth = 345
    ExplicitHeight = 217
  end
  object btnTestClass: TButton
    Left = 32
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Test &Class'
    TabOrder = 2
    OnClick = btnTestClassClick
  end
  object btnTestForm: TButton
    Left = 32
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Test &Form'
    TabOrder = 3
    OnClick = btnTestFormClick
  end
  object mmMain: TMainMenu
    Left = 48
    Top = 168
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About...'
        OnClick = About1Click
      end
    end
  end
end
