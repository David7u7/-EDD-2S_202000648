unit Login;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,AdminPnl,unitUsuarios,usuarioestandar,CrearCuenta;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnLogin: TButton;
    Button2: TButton;
    EditEmail: TEdit;
    EditePassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
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
    if (Editemail.Text = 'root@edd.com') and (Editepassword.Text = 'root123') then
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
      Hide;
      Form4.ShowModal;   // Abre panel admin
      Show;
      Exit;

    end
    else
    begin
      ShowMessage('Usuario o contraseña incorrectos.');
    end;
  end;


procedure TForm1.Button2Click(Sender: TObject);
     begin

       Hide;
       Form3.ShowModal;
       Show;
       Exit;
     end;


end.

