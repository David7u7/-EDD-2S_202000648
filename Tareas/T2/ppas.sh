#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Linking /home/david/Escritorio/[EDD]1S_202000648/Tareas/T2/bst_json
OFS=$IFS
IFS="
"
/usr/bin/ld.bfd -b elf64-x86-64 -m elf_x86_64       -L. -o /home/david/Escritorio/[EDD]1S_202000648/Tareas/T2/bst_json -T /home/david/Escritorio/[EDD]1S_202000648/Tareas/T2/link3873.res -e _start
if [ $? != 0 ]; then DoExitLink /home/david/Escritorio/[EDD]1S_202000648/Tareas/T2/bst_json; fi
IFS=$OFS
