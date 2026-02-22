@REM Compiles the app without showing warnings

cobc ^
  -I ../src ^
  -free ^
  -x ../src/*.cbl ^
  -o ../bin/CobReport ^
  -w -q
