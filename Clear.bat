@echo off

cd .\Source
del /s /a *.~*;*.dcu;*.stat;*.ddp

cd ..\Temp
del /s /a *.~*;*.dcu;*.ddp

cd ..\Dcu
del /s /a *.~*;*.dcu;*.ddp