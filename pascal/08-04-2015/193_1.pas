PROGRAM XPrint(INPUT, OUTPUT);
CONST
  Rows = 5;
  Columns = 5;
  ColumnsString = 50;   
  TemplateSize = Rows * Columns - 1;
  OutputSize = Rows * ColumnsString - 1;

TYPE
  Matrix = SET OF 0..OutputSize;

VAR
  CurrMatrix, ResultMatrix: Matrix;
  Ch: CHAR;
  CharPos: INTEGER;
  TemplateFile: TEXT;

PROCEDURE WritePseudoString(Template: Matrix);
VAR
  IndexColumns, IndexRows, CurPos: INTEGER;
  Ch: CHAR;
BEGIN { WritePseudoString }
  FOR IndexRows := 0 TO (Rows - 1)
  DO
    BEGIN
      FOR IndexColumns := 0 TO (ColumnsString - 1)
      DO
        BEGIN
          CurPos := IndexRows * ColumnsString + IndexColumns;
          Ch := ' ';
          // Inserting spaces between letters
          IF ((CurPos > 0) AND ((CurPos MOD ColumnsString) <> 0) AND ((CurPos MOD Columns) = 0))
          THEN
            WRITE(' ');
          IF CurPos IN Template
          THEN
            Ch := '#';
          WRITE(Ch);  
        END;
      WRITELN;
    END
END; { WritePsudoString }

FUNCTION GetMatrix(Ch: CHAR; CharPos: INTEGER; VAR TemplateFile: TEXT): Matrix;
VAR
  CurrMatrix: Matrix;
  TemplateCh: CHAR;
  Cell, Indent: INTEGER; 
BEGIN { GetMatrix }
  RESET(TemplateFile);
  CurrMatrix := [];
  Indent := Columns * CharPos;
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
              // Calculating char matrix cell position in string matrix
              Cell := Indent + (Cell MOD Columns) + ((Cell DIV Columns) * ColumnsString);
              CurrMatrix := CurrMatrix + [Cell]
            END
        END
      ELSE
        READLN(TemplateFile)
    END;
  GetMatrix := CurrMatrix  
END; { GetMatrix }

BEGIN { XPrint }
  // Init
  ASSIGN(TemplateFile, 'templates.txt');    
  WRITE("Enter symbols (10 max): ");
  CharPos := 0;
  ResultMatrix := [];
  // Main cycle
  WHILE ((NOT EOLN) AND (CharPos < 10))
  DO
    BEGIN
      READ(Ch);   
      CurrMatrix := GetMatrix(Ch, CharPos, TemplateFile);
      ResultMatrix := ResultMatrix + CurrMatrix;
      CharPos := CharPos + 1
    END;
  // Result output
  IF ResultMatrix <> []
  THEN
    WritePseudoString(ResultMatrix)
  ELSE
    WRITELN('No known chars given.')  

END. { XPrint }
