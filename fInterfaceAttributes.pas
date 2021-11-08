{*****************************************************************************}
{       Attributes Inheritance                                                }
{       Small app to investigate the attributes inheritance                   }
{       Copyright (C) 2021 Paolo Morandotti                                   }
{       Unit fInterfaceAttributes                                             }
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

unit fInterfaceAttributes;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.RTTI, System.SysUtils, System.Variants, System.Classes, System.TypInfo,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uClasses, Vcl.Menus;

type
  TfrmTest = class(TForm, IAncestorInterface)
    btnInterfaceTest: TButton;
    memOutput: TMemo;
    btnTestClass: TButton;
    btnTestForm: TButton;
    mmMain: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;

    procedure btnInterfaceTestClick(Sender: TObject);
    procedure btnTestClassClick(Sender: TObject);
    procedure btnTestFormClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ScanClass(const AClass: TClass);
    procedure ScanInterfaces(const AClass: TClass);
  public
    procedure Test(const AString: string);
    { Public declarations }
  end;

var
  frmTest: TfrmTest;

implementation

{$R *.dfm}

{ frmTest }

procedure TfrmTest.About1Click(Sender: TObject);
begin
  ShowMessage('Please, find more info at https://www.morandotti.it');
end;

procedure TfrmTest.btnInterfaceTestClick(Sender: TObject);
begin
  ScanInterfaces(Self.ClassType);
end;

procedure TfrmTest.btnTestClassClick(Sender: TObject);
begin
  ScanClass(TTestChild);
end;

procedure TfrmTest.btnTestFormClick(Sender: TObject);
begin
  ScanClass(Self.ClassType);
end;

procedure TfrmTest.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmTest.ScanClass(const AClass: TClass);
var
  lAttr: TCustomAttribute;
  lContext: TRttiContext;
  lClass: TClass;
  lField: TRttiField;
  lMethod: TRttiMethod;
  lProp: TRttiProperty;
  lType: TRttiType;
begin
  memOutput.Lines.Clear;
  lClass := AClass;
  lContext := TRttiContext.Create;
  try
    while lClass <> nil do
      begin
        memOutput.Lines.Add('Class: ' + lClass.ClassName);
        lType := lContext.GetType(lClass);
        for lAttr in lType.GetAttributes() do
            if lAttr is TDefaultStringAttribute then
              memOutput.Lines.Add('Class Attribute ' + lAttr.ClassName + ' = '
                + TDefaultStringAttribute(lAttr).Value);
        for lField in lType.GetFields do
          for lAttr in lField.GetAttributes do
            if lAttr is TDefaultStringAttribute then
              memOutput.Lines.Add('Field Attribute ' + lAttr.ClassName + ' = '
                + TDefaultStringAttribute(lAttr).Value);
        for lProp in lType.GetProperties do
          for lAttr in lProp.GetAttributes do
            if lAttr is TDefaultStringAttribute then
              memOutput.Lines.Add('Property Attribute ' + lAttr.ClassName + ' = '
                + TDefaultStringAttribute(lAttr).Value);
        for lMethod in lType.GetMethods do
          for lAttr in lMethod.GetAttributes do
            if lAttr is TDefaultStringAttribute then
              memOutput.Lines.Add('Method Attribute ' + lAttr.ClassName + ' = '
                + TDefaultStringAttribute(lAttr).Value);
        memOutput.Lines.Add('------------------------------');
        lClass := lClass.ClassParent;
      end;
  finally
    lContext.Free;
  end;
end;

procedure TfrmTest.ScanInterfaces(const AClass: TClass);
var
  i: integer;
  interfaceTable: PInterfaceTable;
  interfaceEntry: PInterfaceEntry;
  lAttr: TCustomAttribute;
  lClass: TClass;
  lContext: TRttiContext;
  lMethod: TRttiMethod;
  lType: TRttiType;
  pinfo: PTypeInfo;
begin
  memOutput.Lines.Clear;
  lClass := AClass;
  lContext := TRttiContext.Create;
  try
  while Assigned(lClass) do
  begin
    interfaceTable := lClass.GetInterfaceTable;
    if Assigned(interfaceTable) then
    begin
      memOutput.Lines.Add('Implemented interfaces in ' + lClass.ClassName);
      for i := 0 to interfaceTable.EntryCount - 1 do
      begin
        interfaceEntry := @interfaceTable.Entries[i];
        begin
{$REGION 'InterfaceTypeInfoOfGUID(const AGUID: TGUID)'}
          for lType in lContext.GetTypes do
          begin
            if lType is TRTTIInterfaceType then
            begin
              if TRTTIInterfaceType(lType).GUID = interfaceEntry.IID then
              begin
                pinfo := TRTTIInterfaceType(lType).Handle;
                memOutput.Lines.Add(Format('%d. %s, GUID = %s',
                  [i, pinfo.Name, GUIDToString(interfaceEntry.IID)]));
                for lAttr in lType.GetAttributes() do
                begin
                  memOutput.Lines.Add('Attributo: ' + lAttr.ClassName);
                  if lAttr is TDefaultStringAttribute then
                    memOutput.Lines.Add(TDefaultStringAttribute(lAttr).Value);
                end;
                for lMethod in lType.GetMethods do
                begin
                  for lAttr in lMethod.GetAttributes do
                  begin
                    memOutput.Lines.Add('Attribute ' + lAttr.ClassName);
                    if lAttr.ClassType = TDefaultStringAttribute then
                      memOutput.Lines.Add
                        ('  value ' + TDefaultStringAttribute(lAttr).Value);
                  end;
                end;
                break;
              end;
            end
          end;
{$ENDREGION}
        end;
      end;
      memOutput.Lines.Add('------------------------------');
    end;
    lClass := lClass.ClassParent;
  end;
  finally
    lContext.Free
  end;
end;

procedure TfrmTest.Test(const AString: string);
begin
  ShowMessage(AString);
end;

end.
