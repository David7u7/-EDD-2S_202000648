unit CrearCuenta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    EditNombre: TEdit;
    EditUsuario: TEdit;
    EditPassword: TEdit;
    EditEmail: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }


procedure TForm3.AgregarUsuario;
var
  IdNuevo: Integer;
begin
  // Calculamos el ID de forma simple (tomando el máximo actual + 1)
  IdNuevo := 1;
  if ListaUsuarios <> nil then
  begin
    var Temp := ListaUsuarios;
    while Temp^.Next <> nil do
      Temp := Temp^.Next;
    IdNuevo := Temp^.Id + 1;
  end;

  // Insertamos el usuario con los datos de los Edit
  InsertarUsuario(
    IdNuevo,
    EditNombre.Text,
    EditUsuario.Text,
    EditPassword.Text,
    EditEmail.Text,
    Edit5.Text  // aquí asumo que Edit5 es el Teléfono
  );

  ShowMessage('Usuario agregado con éxito.');

  // Opcional: limpiar los campos después de registrar
  EditNombre.Clear;
  EditUsuario.Clear;
  EditPassword.Clear;
  EditEmail.Clear;
  Edit5.Clear;
end;


procedure TForm3.FormCreate(Sender: TObject);
begin

end;

end.

