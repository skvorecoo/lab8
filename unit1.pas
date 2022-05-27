unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  PrintersDlgs, Printers, ExtCtrls,Printer4Lazarus;

type

  { TForm1 }

  TForm1 = class(TForm)
    FontDialog: TFontDialog;
    Label3: TLabel;
    MainMenu: TMainMenu;
    FileActions: TMenuItem;
    Editing: TMenuItem;
    CopyText: TMenuItem;
    Memo: TMemo;
    FontStyle: TMenuItem;
    PageSetupDialog1: TPageSetupDialog;
    Panel1: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Style: TMenuItem;
    PrintFile: TMenuItem;
    OpenDialog: TOpenDialog;
    PasteText: TMenuItem;
    CutText: TMenuItem;
    OpenFile: TMenuItem;
    PrintDialog: TPrintDialog;
    SaveDialog: TSaveDialog;
    SaveFile: TMenuItem;
    SaveFileAs: TMenuItem;
    TerminateTextEditor: TMenuItem;
    procedure CopyTextClick(Sender: TObject);
    procedure CutTextClick(Sender: TObject);
    procedure FontStyleClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);
    procedure PasteTextClick(Sender: TObject);
    procedure PrintFileClick(Sender: TObject);
    procedure SaveFileAsClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure TerminateTextEditorClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  FileName: string;
  memo_text : array of string;

implementation
{$R *.lfm}

{ TForm1 }

procedure TForm1.TerminateTextEditorClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.CopyTextClick(Sender: TObject);
begin
  Memo.CopyToClipboard;
end;

procedure TForm1.CutTextClick(Sender: TObject);
begin
  Memo.CutToClipboard;
end;

procedure TForm1.FontStyleClick(Sender: TObject);
begin
  if FontDialog.Execute then Memo.Font:=FontDialog.Font;
end;

procedure TForm1.Label3Click(Sender: TObject);
begin

end;

procedure TForm1.MemoChange(Sender: TObject);
begin
  Form1.Label3.Caption:='Строк: ' + IntToStr(Form1.Memo.Lines.Count)
  + ' Символов: ' + IntToStr(length(Memo.Text));
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  PageSetupDialog1.Execute;
end;

procedure TForm1.OpenFileClick(Sender: TObject);
begin
  if Form1.OpenDialog.Execute then
  begin
    Memo.Lines.LoadFromFile(OpenDialog.FileName);
  end;
end;

procedure TForm1.PasteTextClick(Sender: TObject);
begin
  Memo.PasteFromClipboard;
end;

procedure TForm1.PrintFileClick(Sender: TObject);

var
  i,X,Y,CH: Integer;

begin
  if PrinterSetupDialog1.Execute then
  with Printer do
  begin
    BeginDoc;
    with Canvas do
    begin
      Font:=Memo.Font;
      CH:=TextHeight('I'); //Высота (CH = CharHeight)
      Y:=CH;
      X:=PageWidth div 20;
      for i:=0 to Memo.Lines.Count-1 do
      begin
        TextOut(X, Y, Memo.Lines[i]);
        inc(Y, CH);
        if PageHeight < Y+CH then
        begin
          NewPage;
          Y:=CH;
        end;
      end;
    end;
    EndDoc;
  end;
end;

procedure PSaveFileAs;
begin
  if Form1.SaveDialog.Execute then
  begin
    Form1.Memo.Lines.SaveToFile(Form1.SaveDialog.FileName);
  end;
end;

procedure TForm1.SaveFileAsClick(Sender: TObject);
begin
  PSaveFileAs;
end;

procedure TForm1.SaveFileClick(Sender: TObject);
begin
  if FileName='' then PSaveFileAs else Memo.Lines.SaveToFile(FileName);
end;

end.
