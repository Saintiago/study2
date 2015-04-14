PROGRAM XPrint(INPUT, OUTPUT);
CONST
  Rows = 5;
  Columns = 5;   
  TemplateSize = Rows * Columns;
TYPE
  Matrix = SET OF 1..TemplateSize;
VAR
  CurrMatrix: Matrix;
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

FUNCTION GetMatrix(Ch: CHAR): Matrix;
VAR
  CurrMatrix: Matrix;
  TemplateFile: TEXT;
  TemplateCh: CHAR;
  Cell: INTEGER; 
BEGIN { GetMatrix }
  ASSIGN(TemplateFile, 'templates.txt');
  RESET(TemplateFile);
  CurrMatrix := [];
  WHILE NOT EOF(TemplateFile)
  DO
    BEGIN
      READ(TemplateFile, TemplateCh);
      IF (TemplateCh = Ch)
      THEN
        BEGIN
          WHILE NOT EOLN(TemplateFile)
          DO
            BEGIN
              READ(TemplateFile, Cell);
              include(CurrMatrix, Cell)
            END
        END
      ELSE
        READLN(TemplateFile)
    END;
  GetMatrix := CurrMatrix  
END; { GetMatrix }

BEGIN { XPrint }
  
  WRITE("Enter symbol: ");
  READLN(Ch);

  CurrMatrix := GetMatrix(Ch);

  IF CurrMatrix <> []
  THEN
    WritePseudo(CurrMatrix)
  ELSE
    WRITELN('Unknown symbol')  

END. { XPrint }
