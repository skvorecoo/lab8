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
    Label1: TLabel;
    Label2: TLabel;
    MainMenu: TMainMenu;
    FileActions: TMenuItem;
    Editing: TMenuItem;
    CopyText: TMenuItem;
    Memo: TMemo;
    MenuItem1: TMenuItem;
    FontStyle: TMenuItem;
    Panel1: TPanel;
    Style: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
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
    procedure MemoChange(Sender: TObject);

    procedure MenuItem1Click(Sender: TObject);
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



procedure TForm1.MemoChange(Sender: TObject);
const Alpha : set of char=['A'..'Z','a'..'z'];
Beta : set of char = ['0'..'9','!'..'-'];
var tmp,s : string;
  i,wc,dc,j :integer;
begin
  str(Form1.Memo.Lines.Count,tmp);
  Label1.caption := 'Количество строк: ' +  tmp;
  i:=1; wc:=0;dc := 0;
  for j := 0 to Form1.Memo.Lines.Count -1 do begin
          s := Form1.Memo.Lines[j];
          Repeat
        while NOT(s[i] in Alpha) and (i<=length(s)) do i:= i + 1;
        if (i<=length(s)) then wc := wc + 1;
        while ((s[i] in Alpha) or (s[i] in Beta)) and (i<=length(s)) do begin
        i := i + 1;
        if not(s[i] in Beta) then dc := dc + 1;
        end;
     Until (i>length(s));
     str(dc,tmp);
     Label2.caption := 'Количество букв: ' + tmp;
  end;
end;



procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  If not(Memo.WordWrap) then
  begin
    Memo.WordWrap:=True;
    Memo.ScrollBars:=ssVertical;
    MenuItem1.Checked:=True;
  end
  else
  begin
    Memo.WordWrap:=false;
    Memo.ScrollBars:=ssBoth;
    MenuItem1.Checked:=False;
  end;
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
const
  LEFTMARGIN = 100; // отступ слева

var
  YPos, LineHeight, VerticalMargin,i,y: Integer;
  SuccessString,s: String;


begin
  with Printer do
  try

    // украл с гугла
    BeginDoc;
    Canvas.Font.Name := 'Times new Roman';
    Canvas.Font.Size := 12;
    Canvas.Font.Color := clBlack;
    LineHeight := Round(1.2 * Abs(Canvas.TextHeight('I')));
    VerticalMargin := 1 * LineHeight;

    y := 1; // номер строчки в печати
    for i := 0 to Form1.Memo.Lines.Count -1 do begin
           YPos := VerticalMargin*y; // строка в пикселях
           SuccessString := Form1.Memo.Lines[i];
           Canvas.TextOut(LEFTMARGIN, YPos, SuccessString);
           y := y + 1;
           // переход на новую страницу
           if Ypos > 6500 then begin
             NewPage;
             y := 1;
             end;
    end;

  finally
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
