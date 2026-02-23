@REM Checks the source code's syntax with extra errors

cobc ^
  -I ../src ^
  -free ^
  -fsyntax-only ../src/*.cob ^
  -Wall -Wextra -Wno-terminator
