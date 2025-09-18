program BST_JSON;

{$mode objfpc}{$H+}

uses
  SysUtils, Classes, fpjson, jsonparser;

type
  // Registro con los datos del JSON
  TUser = record
    id: Integer;
    first_name: String;
    last_name: String;
    email: String;
  end;

  // Nodo del árbol
  PNode = ^TNode;
  TNode = record
    data: TUser;
    left, right: PNode;
  end;

var
  Root: PNode;

procedure InsertNode(var Root: PNode; user: TUser);
begin
  if Root = nil then
  begin
    New(Root);
    Root^.data := user;
    Root^.left := nil;
    Root^.right := nil;
  end
  else if user.id < Root^.data.id then
    InsertNode(Root^.left, user)
  else
    InsertNode(Root^.right, user);
end;

procedure ExportDOT(Node: PNode; var F: Text);
begin
  if Node = nil then Exit;

  WriteLn(F, '  "', Node^.data.id, '" [label="', Node^.data.id, '\n',
          Node^.data.first_name, ' ', Node^.data.last_name, '"];');

  if Node^.left <> nil then
  begin
    WriteLn(F, '  "', Node^.data.id, '" -> "', Node^.left^.data.id, '";');
    ExportDOT(Node^.left, F);
  end;

  if Node^.right <> nil then
  begin
    WriteLn(F, '  "', Node^.data.id, '" -> "', Node^.right^.data.id, '";');
    ExportDOT(Node^.right, F);
  end;
end;

procedure GenerateDOT(Root: PNode; FileName: String);
var
  F: Text;
begin
  AssignFile(F, FileName);
  Rewrite(F);
  WriteLn(F, 'digraph BST {');
  WriteLn(F, '  node [shape=record];');
  ExportDOT(Root, F);
  WriteLn(F, '}');
  CloseFile(F);
end;

procedure LoadJSONFromFile(const FileName: String);
var
  JSONText: TStringList;
  jData: TJSONData;
  jArray: TJSONArray;
  i: Integer;
  user: TUser;
begin
  JSONText := TStringList.Create;
  try
    JSONText.LoadFromFile(FileName);        // Lee archivo JSON
    jData := GetJSON(JSONText.Text);        // Convierte string → JSON
    jArray := TJSONArray(jData);

    for i := 0 to jArray.Count - 1 do
    begin
      user.id := jArray.Objects[i].Integers['id'];
      user.first_name := jArray.Objects[i].Strings['first_name'];
      user.last_name := jArray.Objects[i].Strings['last_name'];
      user.email := jArray.Objects[i].Strings['email'];
      InsertNode(Root, user);
    end;

    jData.Free;
  finally
    JSONText.Free;
  end;
end;

begin
  if ParamCount < 1 then
  begin
    WriteLn('Uso: ', ParamStr(0), ' archivo.json');
    Halt(1);
  end;

  Root := nil;
  LoadJSONFromFile(ParamStr(1));  // Leer el archivo JSON pasado como argumento
  GenerateDOT(Root, 'bst.dot');   // Generar archivo DOT
  WriteLn('Árbol cargado y archivo bst.dot generado con éxito.');
  WriteLn('Usa: dot -Tpng bst.dot -o bst.png  para generar la imagen.');
end.

