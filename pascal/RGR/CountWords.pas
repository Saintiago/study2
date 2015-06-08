PROGRAM CountWords(INPUT, OUTPUT);
CONST
  MAX_WORDS = 100;
  SPACE = ' ';
TYPE
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Word: STRING;
           Qty: INTEGER
         END;
VAR
  SourceFile, ResultFile: TEXT;

PROCEDURE ReadWord(VAR Word: STRING; VAR SourceFile: TEXT);
VAR
  Ch: CHAR;
  AllowedChars: SET OF CHAR;
BEGIN { ReadWord }
  AllowedChars := ['à', 'á', 'â', 'ã', 'ä', 'å', '¸', 'æ', 'ç', 'è', 'é'];
  AllowedChars := AllowedChars + ['ê', 'ë', 'ì', 'í', 'î', 'ï', 'ð', 'ñ', 'ò', 'ó', 'ô'];
  AllowedChars := AllowedChars + ['õ', 'ö', '÷', 'ø', 'ù', 'ü', 'ú', 'û', 'ý', 'þ', 'ÿ'];
  AllowedChars := AllowedChars + ['À', 'Á', 'Â', 'Ã', 'Ä', 'Å', '¨', 'Æ', 'Ç', 'È', 'É'];
  AllowedChars := AllowedChars + ['Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô'];
  AllowedChars := AllowedChars + ['Õ', 'Ö', '×', 'Ø', 'Ù', 'Ü', 'Ú', 'Û', 'Ý', 'Þ', 'ß'];
  Word := '';
  READ(SourceFile, Ch);
  WHILE NOT (Ch IN AllowedChars)
  DO  
    READ(SourceFile, Ch);
  WHILE (Ch IN AllowedChars) AND (NOT (EOLN(SourceFile) OR EOF(SourceFile)))
  DO
    BEGIN
      Word := Word + Ch;
      READ(SourceFile, Ch);
    END;
  IF (Ch IN AllowedChars) AND (EOLN(SourceFile) OR EOF(SourceFile))
  THEN
    Word := Word + Ch  
END; { ReadWord }

PROCEDURE CopyFile(VAR ToFile: TEXT; VAR FromFile: TEXT);
VAR
  Ch: CHAR;
  WordOld: STRING;
BEGIN { CopyFile }
  RESET(FromFile);
  REWRITE(ToFile);    
  WHILE NOT EOF(FromFile)
  DO
    BEGIN
      WHILE NOT EOLN(FromFile)
      DO
        BEGIN
          READ(FromFile, Ch);
          WRITE(ToFile, Ch)
        END;
        READLN(FromFile);
        WRITELN(ToFile)
    END;
END; { CopyFile }

PROCEDURE ReadResultRow(VAR Word: NodePtr; VAR ResultFile: TEXT);
VAR
  Ch: CHAR;
  Found: BOOLEAN;
BEGIN { ReadResultRow }
  IF EOF(ResultFile)
  THEN
    EXIT;    
  ReadWord(Word^.Word, ResultFile);
  READ(ResultFile, Word^.Qty);
  READLN(ResultFile)
END; { ReadResultRow }

PROCEDURE WriteResultRow(VAR Word: NodePtr; VAR ResultFile: TEXT);
BEGIN { WriteResultRow }
  WRITELN(ResultFile, Word^.Word, SPACE, Word^.Qty);
END; { WriteResultRow }

PROCEDURE ClearMem(VAR FirstPtr: NodePtr);
VAR
  Temp, List: NodePtr;
BEGIN { ClearMem }
  IF FirstPtr = NIL
  THEN
    EXIT;

  List := FirstPtr;
  
  WHILE List <> NIL
  DO
    BEGIN
      Temp := List;
      List := List^.Next;
      DISPOSE(Temp)
    END;
  FirstPtr := NIL
END; { ClearMem }

PROCEDURE StoreResult(VAR FirstPtr: NodePtr; VAR ResultFile: TEXT);
VAR
  CurrMem, CurrTemp: NodePtr;
  TempFile: TEXT;
BEGIN { StoreResult }
  CurrTemp := NIL;
  CurrMem := NIL;
  NEW(CurrTemp);    
  CopyFile(TempFile, ResultFile);
  RESET(TempFile);
  REWRITE(ResultFile);
  CurrMem := FirstPtr;
  IF NOT EOF(TempFile)
  THEN
    ReadResultRow(CurrTemp, TempFile);
  WHILE NOT (EOF(TempFile) OR (CurrMem^.Next = NIL))
  DO
    BEGIN
      IF (CurrMem^.Word < CurrTemp^.Word)
      THEN
        BEGIN
          WriteResultRow(CurrMem, ResultFile);
          CurrMem := CurrMem^.Next;
        END 
      ELSE IF (CurrMem^.Word > CurrTemp^.Word)
      THEN
        BEGIN
          WriteResultRow(CurrTemp, ResultFile);
          ReadResultRow(CurrTemp, TempFile)
        END 
      ELSE IF (CurrMem^.Word = CurrTemp^.Word)
      THEN
        BEGIN
          CurrMem^.Qty := CurrMem^.Qty + CurrTemp^.Qty;
          WriteResultRow(CurrMem, ResultFile);
          CurrMem := CurrMem^.Next;
          ReadResultRow(CurrTemp, TempFile)
        END
    END;
  // Write remains of Mem and Temp to Result
  IF CurrMem <> NIL
  THEN
    WHILE CurrMem^.Next <> NIL
    DO
      BEGIN
        WriteResultRow(CurrMem, ResultFile);
        CurrMem := CurrMem^.Next;
      END;
  WHILE NOT EOF(TempFile)
  DO
    BEGIN
      WriteResultRow(CurrTemp, ResultFile);
      ReadResultRow(CurrTemp, TempFile)
    END;
  ClearMem(FirstPtr);  
  writeln('Stored')
END; { StoreResult }

PROCEDURE GetTextStatistics(VAR SourceFile: TEXT; VAR ResultFile: TEXT);
VAR
  FirstPtr, NewPtr, Curr, Prev: NodePtr;
  Found, Equal: BOOLEAN;
  WordQty: INTEGER;
BEGIN { GetTextStatistics }
  RESET(SourceFile);    
  FirstPtr := NIL;
  WordQty := 0;
  WHILE NOT EOF(SourceFile)
  DO
    BEGIN
      WHILE NOT EOLN(SourceFile)
      DO
        BEGIN
          NEW(NewPtr);
          ReadWord(NewPtr^.Word, SourceFile);
          NewPtr^.Qty := 1;
          NewPtr^.Next := NIL;
          Prev := NIL;
          Curr := FirstPtr;
          Found := FALSE;
          Equal := FALSE;
          WHILE (Curr <> NIL) AND NOT Found
          DO
            BEGIN
              IF NewPtr^.Word > Curr^.Word
              THEN
                BEGIN
                  Prev := Curr;
                  Curr := Curr^.Next;
                END
              ELSE IF NewPtr^.Word = Curr^.Word
              THEN
                BEGIN
                  Found := TRUE;
                  Equal := TRUE;
                  Curr^.Qty := Curr^.Qty + NewPtr^.Qty
                END
              ELSE IF NewPtr^.Word < Curr^.Word
              THEN
                BEGIN
                  Found := TRUE;
                  NewPtr^.Next := Curr;
                END;
            END;
          IF NOT Equal
          THEN
            BEGIN
              WordQty := WordQty + 1;
              IF Prev = NIL 
              THEN
                BEGIN 
                  FirstPtr := NewPtr
                END
              ELSE
                Prev^.Next := NewPtr 
            END;
          IF WordQty >= MAX_WORDS
          THEN
            BEGIN
              StoreResult(FirstPtr, ResultFile);
              WordQty := 0;
            END
        END;
        READLN(SourceFile)
    END;
  StoreResult(FirstPtr, ResultFile)
END; { GetTextStatistics }

BEGIN { CountWords }

  ASSIGN(SourceFile, 'source.txt');
  ASSIGN(ResultFile, 'result.txt');

  // Get text statistics
  GetTextStatistics(SourceFile, ResultFile);
  
END. { CountWords }

