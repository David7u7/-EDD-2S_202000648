unit AdminPnl;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpjson, jsonparser,unitUsuarios;



type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;


implementation

{$R *.lfm}

{ TForm2 }


{TForm2}
procedure TForm2.Button1Click(Sender: TObject);

var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Filter := 'Archivos JSON|*.json';
    if OpenDialog.Execute then
    begin
      CargarUsuariosDesdeJSON(OpenDialog.FileName); //llamada central
      ShowMessage('Usuarios cargados desde: ' + OpenDialog.FileName);
    end;
  finally
    OpenDialog.Free;
  end;
end;


end.




