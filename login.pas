unit Login;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,AdminPnl,unitUsuarios;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnLogin: TButton;
    Button2: TButton;
    EditEmail: TEdit;
    EditePassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure BtnLoginClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}


{ TForm1 }

procedure TForm1.BtnLoginClick(Sender: TObject);

  var
    UsuarioEncontrado: PUsuario;
  begin
    // Caso root/admin hardcodeado
    if (Editemail.Text = 'admin') and (Editepassword.Text = '1234') then
    begin
      Hide;
      Form2.ShowModal;   // Abre panel admin
      Show;
      Exit;
    end;

    UsuarioEncontrado := BuscarUsuario(Editemail.Text, Editepassword.Text);

    if UsuarioEncontrado <> nil then
    begin
      ShowMessage('Bienvenido ' + UsuarioEncontrado^.Nombre);

    end
    else
    begin
      ShowMessage('Usuario o contraseña incorrectos.');
    end;
  end;

end.

