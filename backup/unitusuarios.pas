unit unitUsuarios;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, fpjson, jsonparser, Classes;

type
  PUsuario = ^TUsuario;
  TUsuario = record
    Id: Integer;
    Nombre, Usuario, Password, Email, Telefono: string;
    Next: PUsuario;
  end;

var
  ListaUsuarios: PUsuario = nil;  // lista global

// ==== Funciones y procedimientos disponibles ====
procedure InsertarUsuario(Id: Integer; Nombre, Usuario, Password, Email, Telefono: string);
procedure CargarUsuariosDesdeJSON(const NombreArchivo: string);
function BuscarUsuario(const Usuario, Password: string): PUsuario;

implementation

// ==== Insertar en la lista ====
procedure InsertarUsuario(Id: Integer; Nombre, Usuario, Password, Email, Telefono: string);
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

// ==== Buscar usuario por usuario+password ====
function BuscarUsuario(const Email, Password: string): PUsuario;
var
  Temp: PUsuario;
begin
  Temp := ListaUsuarios;
  while Temp <> nil do
  begin
    if (Temp^.Email = Email) and (Temp^.Password = Password) then
    begin
      Result := Temp;
      Exit;
    end;
    Temp := Temp^.Next;
  end;
  Result := nil; // No encontrado
end;



procedure CargarUsuariosDesdeJSON(const NombreArchivo: string);
var
  JSONData: TJSONData;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  UsuarioObj: TJSONObject;
  Parser: TJSONParser;
  Archivo: TStringStream;
  i: Integer;
begin
  if not FileExists(NombreArchivo) then
  begin
    WriteLn('Archivo no encontrado: ' + NombreArchivo);
    Exit;
  end;

  Archivo := TStringStream.Create('');
  try
    Archivo.LoadFromFile(NombreArchivo);
    Parser := TJSONParser.Create(Archivo.DataString);
    try
      JSONData := Parser.Parse;
      JSONObject := TJSONObject(JSONData);
      JSONArray := JSONObject.Arrays['usuarios'];

      for i := 0 to JSONArray.Count - 1 do
      begin
        UsuarioObj := JSONArray.Objects[i];
        InsertarUsuario(
          UsuarioObj.Integers['id'],
          UsuarioObj.Strings['nombre'],
          UsuarioObj.Strings['usuario'],
          UsuarioObj.Strings['password'],
          UsuarioObj.Strings['email'],
          UsuarioObj.Strings['telefono']
        );
      end;

      WriteLn('Carga masiva completada: ' + IntToStr(JSONArray.Count) + ' usuarios cargados.');
    finally
      Parser.Free;
    end;
  finally
    Archivo.Free;
  end;
end;


end.

