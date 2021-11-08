{*****************************************************************************}
{       Attributes Inheritance                                                }
{       Small app to investigate the attributes inheritance                   }
{       Copyright (C) 2021 Paolo Morandotti                                   }
{       Unit uClasses                                                         }
{*****************************************************************************}
{                                                                             }
{Permission is hereby granted, free of charge, to any person obtaining        }
{a copy of this software and associated documentation files (the "Software"), }
{to deal in the Software without restriction, including without limitation    }
{the rights to use, copy, modify, merge, publish, distribute, sublicense,     }
{and/or sell copies of the Software, and to permit persons to whom the        }
{Software is furnished to do so, subject to the following conditions:         }
{                                                                             }
{The above copyright notice and this permission notice shall be included in   }
{all copies or substantial portions of the Software.                          }
{                                                                             }
{THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS      }
{OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  }
{FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  }
{AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       }
{LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING      }
{FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS }
{IN THE SOFTWARE.                                                             }
{*****************************************************************************}

unit uClasses;

interface

type

{$REGION 'Attributes'}
  TDefaultStringAttribute = class(TCustomAttribute)
    procedure SetValue(aValue: String);
  private
    FValue: String;
  public
    property Value: String read FValue write SetValue;
    constructor Create(const aValue: String);
  end;
{$ENDREGION}

{$REGION 'Interfaces'}
  [TDefaultString('IAncestorInterface class attribute found.')]
  IAncestorInterface = interface
    ['{F2A5626F-223C-4EB7-BA0E-CDAA468EE729}']
    [TDefaultString('IAncestorInterface Test method attribute found.')]
    procedure Test(const AString: string);
  end;
{$ENDREGION}

{$REGION 'Classes'}
  [TDefaultStringAttribute('TTestAncestor class attribute found.')]
  TTestAncestor = class(TObject)
  private
    FText: string;
    FEnabled: boolean;
  public
    [TDefaultStringAttribute('TTestAncestor FClassField field attribute found.')]
    FClassField: string;
    [TDefaultStringAttribute('TTestAncestor Text property attribute found.')]
    property Text: string read FText write FText;
    [TDefaultStringAttribute('TTestAncestor Enabled property attribute found.')]
    property Enabled: boolean read FEnabled write FEnabled;
    [TDefaultStringAttribute('TTestAncestor Test method attribute found.')]
    procedure Test(const AString: string); virtual; abstract;
  end;

  TTestChild = class(TTestAncestor)
  public
    [TDefaultStringAttribute('TTestChild Text property attribute found.')]
    property Text;
    [TDefaultStringAttribute('TTestChild Test method attribute found.')]
    procedure Test(const AString: string); override;
  end;
{$ENDREGION}

implementation

{ TDefaultStringAttribute }

constructor TDefaultStringAttribute.Create(const aValue: String);
begin
  FValue := aValue;
end;

procedure TDefaultStringAttribute.SetValue(aValue: String);
begin
  FValue := aValue;
end;

{ TTestChild }

procedure TTestChild.Test(const AString: string);
begin
  {nothing to do}
end;

end.
