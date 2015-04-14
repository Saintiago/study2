PROGRAM XPrint(INPUT, OUTPUT);
CONST
  Rows = 5;
  Columns = 5;   
  TemplateSize = Rows * Columns;
TYPE
  Matrix = SET OF 1..TemplateSize;
VAR
  A, B, C: Matrix;
  Ch: CHAR;

PROCEDURE WritePseudo(Template: Matrix);
VAR
  IndexColumns, IndexRows, CurPos: INTEGER;
  Ch: CHAR;
BEGIN { WritePseudo }
  FOR IndexRows := 1 TO Rows
  DO
    BEGIN
      FOR IndexColumns := 1 TO Columns
      DO
        BEGIN
          CurPos := (IndexRows - 1) * Columns + IndexColumns;
          Ch := ' ';
          IF CurPos IN Template
          THEN
            Ch := '#';
          WRITE(Ch);  
        END;
      WRITELN;
    END
END; { WritePsudo }

BEGIN { XPrint }
  
  A := [3, 7, 9, 12, 14, 16..21, 25];
  B := [1, 2, 6, 8, 11, 12, 16, 18, 21, 22];
  C := [2, 3, 6, 9, 11, 16, 19, 22, 23];

  WRITE("Enter symbol: ");
  READLN(Ch);

  CASE Ch OF
    'A': WritePseudo(A);
    'B': WritePseudo(B);
    'C': WritePseudo(C);
  ELSE
    WRITELN('Unknown symbol')  
  END

END. { XPrint }
