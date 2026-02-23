@REM Compiles the app without showing warnings

cobc ^
  -I ../src ^
  -free ^
  -x ../src/*.cob ^
  -o ../bin/CobReport ^
  -w -q
