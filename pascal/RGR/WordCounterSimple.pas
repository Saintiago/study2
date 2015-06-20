UNIT WordCounterSimple;

INTERFACE

  PROCEDURE CountWords(VAR SourceFile: TEXT; VAR ResultFile: TEXT);

IMPLEMENTATION

  TYPE
    Node = RECORD
             Word: STRING;
             Qty: INTEGER
           END; 
             
  CONST
    ALLOWED_CHARS = ['À' .. 'ÿ'];
    MIN_WORD_LENGTH = 3;

  VAR
    IoCount: INTEGER;

  PROCEDURE ReadWord(VAR Word: STRING; VAR SourceFile: TEXT);
  CONST
    WORD_END = 'e';
    WORD_IN = 'i';
    WORD_BEFORE = 'b';
  VAR
    Ch, WordState: CHAR;
    Allowed: BOOLEAN;
    WordLength: INTEGER;
  BEGIN { ReadWord }
    Word := '';
    WordState := WORD_BEFORE;
    WordLength := 0;
    WHILE (NOT EOF(SourceFile)) AND (WordState <> WORD_END)
    DO
      BEGIN
        IoCount := IoCount + 1;
        READ(SourceFile, Ch);
        Ch := UpCase(Ch);
        Allowed := (Ch IN ALLOWED_CHARS);
        IF Allowed AND (WordState = WORD_IN)
        THEN
          BEGIN
            Word := Word + Ch;
            WordLength := WordLength + 1
          END  
        ELSE IF Allowed AND (WordState <> WORD_IN)
        THEN
          BEGIN
            WordState := WORD_IN;
            Word := Word + Ch;
            WordLength := WordLength + 1
          END
        ELSE IF NOT Allowed AND (WordState = WORD_IN)
        THEN
          WordState := WORD_END
      END;
    IF (NOT EOF(SourceFile)) AND (WordLength < MIN_WORD_LENGTH)
    THEN
      ReadWord(Word, SourceFile)
  END; { ReadWord }

  PROCEDURE CopyFile(VAR FromFile: TEXT; VAR ToFile: TEXT);
  VAR
    Ch: CHAR;
  BEGIN { CopyFile }
    RESET(FromFile);
    REWRITE(ToFile);    
    WHILE NOT EOF(FromFile)
    DO
      BEGIN
        WHILE NOT EOLN(FromFile)
        DO
          BEGIN
            IoCount := IoCount + 2;
            READ(FromFile, Ch);
            WRITE(ToFile, Ch)
          END;
          READLN(FromFile);
          WRITELN(ToFile)
      END;
  END; { CopyFile }

  PROCEDURE ReadFromFile(VAR Row: Node; VAR Source: TEXT);
  BEGIN { ReadFromFile }
    Row.Word := '';
    Row.Qty := 0;
    IF NOT EOF(Source)
    THEN
      BEGIN
        ReadWord(Row.Word, Source);
        IoCount := IoCount + 2;
        READ(Source, Row.Qty);
        READLN(Source)
      END  
  END; { ReadFromFile }

  PROCEDURE WriteToFile(VAR Row: Node; VAR Result: TEXT);
  BEGIN { WriteToFile }
    IoCount := IoCount + 1;
    WRITELN(Result, Row.Word, ' ', Row.Qty)
  END; { WriteToFile }

  PROCEDURE StoreResult(VAR Word: STRING; VAR ResultFile: TEXT);
  CONST
    FROM_FILE = 'f';
    FROM_NEW  = 'n';
    FROM_BOTH = 'b';
    FROM_NONE = 'x';
  VAR
    Temp: TEXT;
    FileCurr, NewWord: Node;
    ToWrite: CHAR;
  BEGIN { StoreResult }
    ToWrite := FROM_NEW; // Initialization. Meaningful value later    
    CopyFile(ResultFile, Temp);
    RESET(Temp);
    REWRITE(ResultFile);
    ReadFromFile(FileCurr, Temp);
    NewWord.Word := Word;
    NewWord.Qty := 1;

    WHILE (ToWrite <> FROM_NONE) 
    DO
      BEGIN
        
        ToWrite := FROM_NONE;
        IF (FileCurr.Word = '') AND (NewWord.Word <> '') THEN ToWrite := FROM_NEW 
        ELSE IF (FileCurr.Word <> '') AND (NewWord.Word = '') THEN ToWrite := FROM_FILE           
        ELSE IF FileCurr.Word < NewWord.Word THEN ToWrite := FROM_FILE
        ELSE IF FileCurr.Word > NewWord.Word THEN ToWrite := FROM_NEW
        ELSE IF (FileCurr.Word = NewWord.Word) AND (NewWord.Word <> '') THEN ToWrite := FROM_BOTH;

        IF ToWrite = FROM_FILE
        THEN
          BEGIN
            WriteToFile(FileCurr, ResultFile);
            ReadFromFile(FileCurr, Temp)
          END;
        IF ToWrite = FROM_NEW
        THEN
          BEGIN
            WriteToFile(NewWord, ResultFile);
            NewWord.Word := '';
          END;
        IF ToWrite = FROM_BOTH
        THEN
          BEGIN
            FileCurr.Qty := FileCurr.Qty + NewWord.Qty;   
            WriteToFile(FileCurr, ResultFile);
            ReadFromFile(FileCurr, Temp);
            NewWord.Word := ''
          END      
      END
  END; { StoreResult }

  PROCEDURE CountWords(VAR SourceFile: TEXT; VAR ResultFile: TEXT);
  VAR
    Word: STRING;
  BEGIN { CountWords }
    RESET(SourceFile);
    REWRITE(ResultFile);
    WHILE NOT EOF(SourceFile)
    DO
      BEGIN
        WHILE NOT EOLN(SourceFile)
        DO
          BEGIN
            ReadWord(Word, SourceFile);
            StoreResult(Word, ResultFile)
          END;
        READLN(SourceFile)
      END;
    WRITELN('IO count: ', IoCount)  
  END; { CountWords }

BEGIN
  IoCount := 0;
END.
