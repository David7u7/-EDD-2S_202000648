program project1;

{$mode objfpc}{$H+}

uses

  Classes, SysUtils, fpjson, jsonparser;


type
  PUsuario = ^TUsuario;
  TUsuario = record
    Id: Integer;
    Nombre: String;
    Usuario: String;
    Password: String;
    Email: String;
    Telefono: String;
    Next: PUsuario;
  end;

              function ReadFileToString(const FileName: string): string;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.LoadFromFile(FileName);
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;


var
  ListaUsuarios: PUsuario = nil;

{ ----------- Manejo de lista ----------- }

procedure AgregarUsuario(Id: Integer; Nombre, Usuario, Password, Email, Telefono: String);
var
  Nuevo, Temp: PUsuario;
begin
  New(Nuevo);
  Nuevo^.Id := Id;
  Nuevo^.Nombre := Nombre;
  Nuevo^.Usuario := Usuario;
  Nuevo^.Password := Password;
  Nuevo^.Email := Email;
  Nuevo^.Telefono := Telefono;
  Nuevo^.Next := nil;

  if ListaUsuarios = nil then
    ListaUsuarios := Nuevo
  else
  begin
    Temp := ListaUsuarios;
    while Temp^.Next <> nil do
      Temp := Temp^.Next;
    Temp^.Next := Nuevo;
  end;
end;

procedure MostrarUsuarios;
var
  Temp: PUsuario;
begin
  if ListaUsuarios = nil then
    Writeln('No hay usuarios cargados.')
  else
  begin
    Temp := ListaUsuarios;
    while Temp <> nil do
    begin
      Writeln('-------------------------');
      Writeln('Id: ', Temp^.Id);
      Writeln('Nombre: ', Temp^.Nombre);
      Writeln('Usuario: ', Temp^.Usuario);
      Writeln('Password: ', Temp^.Password);
      Writeln('Email: ', Temp^.Email);
      Writeln('Telefono: ', Temp^.Telefono);
      Temp := Temp^.Next;
    end;
  end;
end;

{ ----------- Carga desde JSON ----------- }
   procedure CargarDesdeJSON(const Archivo: String);
var
  JSONData: TJSONData;
  JSONObject: TJSONObject;
  UsuariosArray: TJSONArray;
  i: Integer;
begin
  if not FileExists(Archivo) then
  begin
    Writeln('No se encontró el archivo: ', Archivo);
    Exit;
  end;

  JSONData := GetJSON(ReadFileToString(Archivo));
  try
    JSONObject := TJSONObject(JSONData);           // Primero convertimos a objeto
    UsuariosArray := JSONObject.Arrays['usuarios']; // Luego tomamos el array interno

    for i := 0 to UsuariosArray.Count - 1 do
    begin
      AgregarUsuario(
        UsuariosArray.Objects[i].Integers['id'],
        UsuariosArray.Objects[i].Strings['nombre'],
        UsuariosArray.Objects[i].Strings['usuario'],
        UsuariosArray.Objects[i].Strings['password'],
        UsuariosArray.Objects[i].Strings['email'],
        UsuariosArray.Objects[i].Strings['telefono']
      );
    end;

    Writeln('Usuarios cargados correctamente desde "', Archivo, '".');

  finally
    JSONData.Free;
  end;
end;


{ ----------- Menú principal ----------- }

procedure Menu;
var
  opcion: Integer;
  archivo: String;
begin
  repeat
    Writeln('====== MENU ======');
    Writeln('1. Cargar usuarios desde JSON');
    Writeln('2. Mostrar usuarios');
    Writeln('3. Salir');
    Write('Seleccione una opcion: ');
    ReadLn(opcion);

    case opcion of
      1: begin
           Write('Ingrese el nombre del archivo JSON: ');
           ReadLn(archivo);
           CargarDesdeJSON(archivo);
         end;
      2: MostrarUsuarios;
      3: Writeln('Saliendo...');
    else
      Writeln('Opcion invalida.');
    end;

  until opcion = 3;
end;

{ ----------- Programa principal ----------- }

begin
  Menu;
end.

