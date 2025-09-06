unit CrearCuenta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,unitUsuarios;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    ID: TEdit;
    EditNombre: TEdit;
    EditNumero: TEdit;
    EditUsuario: TEdit;
    EditPassword: TEdit;
    EditEmail: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure EditUsuarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
var
  NuevoId: Integer;
begin




  // Verificar que no falte un campo
  if (EditNombre.Text = '') or (EditUsuario.Text = '') or (EditPassword.Text = '') then
  begin
    ShowMessage('Por favor complete todos los campos requeridos');
    Exit;
  end;

  try
    NuevoId := StrToInt(EditId.Text);
  except
    on E: Exception do
    begin
      ShowMessage('El ID debe ser un número válido.');
      Exit;
    end;
  end;

  // Insertar en la lista
  InsertarUsuario(
    NuevoId,
    EditNombre.Text,
    EditUsuario.Text,
    EditPassword.Text,
    EditEmail.Text,
    EditNumero.Text
  );

  ShowMessage('Usuario creado exitosamente: ' + EditUsuario.Text);

  // Opcional: cerrar el form de creación y volver al login
  Close;
end;

procedure TForm3.EditUsuarioChange(Sender: TObject);
begin

end;

end.

