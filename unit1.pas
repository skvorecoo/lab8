unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu: TMainMenu;
    FileActions: TMenuItem;
    Editing: TMenuItem;
    CopyText: TMenuItem;
    Memo: TMemo;
    OpenDialog: TOpenDialog;
    PasteText: TMenuItem;
    CutText: TMenuItem;
    OpenFile: TMenuItem;
    SaveDialog: TSaveDialog;
    SaveFile: TMenuItem;
    SaveFileAs: TMenuItem;
    TerminateTextEditor: TMenuItem;
    procedure CopyTextClick(Sender: TObject);
    procedure CutTextClick(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);
    procedure PasteTextClick(Sender: TObject);
    procedure SaveFileAsClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure TerminateTextEditorClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  FileName: string;

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

