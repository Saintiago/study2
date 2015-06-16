UNIT WordCounter;

INTERFACE

  TYPE
    NodePtr = ^Node;
    Node = RECORD
             Next: NodePtr;
             Word: STRING;
             Qty: INTEGER
           END; 
  
  FUNCTION InitializeIoFiles(): BOOLEAN;
  PROCEDURE CountWords();
  PROCEDURE ReadFromFile(VAR Row: Node; VAR Source: TEXT);
  PROCEDURE WriteToFile(VAR Row: Node; VAR Result: TEXT);

IMPLEMENTATION

  CONST
    MAX_LIST_LENGTH = 10;
    ALLOWED_CHARS = ['À' .. 'ÿ'];
    MIN_WORD_LENGTH = 3;

  VAR
    SourceFile, ResultFile, GatheredFile: TEXT;
    ListLength: INTEGER;
    FirstPtr: NodePtr;

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

  PROCEDURE InsertWord(VAR Word: STRING);
  CONST
    EQUAL = 'e';
    FOUND = 'f';
    SEARCHING = 's';
  VAR
    NewWord, Curr, Prev: NodePtr;
    SearchState: CHAR;
  BEGIN  { InsertWord }
    IF Word = ''
    THEN
      EXIT;
    Curr := FirstPtr;
    Prev := NIL;
    SearchState := SEARCHING;
    WHILE (Curr <> NIL) AND (SearchState = SEARCHING)
    DO
      BEGIN
        IF Word < Curr^.Word
        THEN
          SearchState := FOUND
        ELSE IF Word > Curr^.Word
        THEN
          BEGIN
            Prev := Curr;
            Curr := Curr^.Next
          END
        ELSE IF Word = Curr^.Word
        THEN
          SearchState := EQUAL;
      END;
    IF SearchState = EQUAL
    THEN
      Curr^.Qty := Curr^.Qty + 1
    ELSE
      BEGIN
        NEW(NewWord);
        NewWord^.Word := Word;
        NewWord^.Qty := 1;
        NewWord^.Next := NIL;
        ListLength := ListLength + 1;
        IF Prev = NIL
        THEN
          BEGIN
            NewWord^.Next := FirstPtr;
            FirstPtr := NewWord
          END
        ELSE IF SearchState = SEARCHING
        THEN
          Prev^.Next := NewWord
        ELSE IF SearchState = FOUND
        THEN
          BEGIN
            Prev^.Next := NewWord;
            NewWord^.Next := Curr
          END
      END
  END;  { InsertWord }

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
    Row.Next := NIL;
    IF NOT EOF(Source)
    THEN
      BEGIN
        ReadWord(Row.Word, Source);
        READ(Source, Row.Qty);
        READLN(Source)
      END  
  END; { ReadFromFile }

  PROCEDURE WriteToFile(VAR Row: Node; VAR Result: TEXT);
  BEGIN { WriteToFile }
    WRITELN(Result, Row.Word, ' ', Row.Qty)
  END; { WriteToFile }

  PROCEDURE ClearMem();
  VAR
    Temp, Curr: NodePtr;
  BEGIN { ClearMem }
    IF FirstPtr = NIL
    THEN
      EXIT;
    Curr := FirstPtr;
    WHILE Curr <> NIL
    DO
      BEGIN
        Temp := Curr;
        Curr := Curr^.Next;
        DISPOSE(Temp)
      END;
    ListLength := 0;  
    FirstPtr := NIL
  END; { ClearMem }

  PROCEDURE StoreResult(VAR ResultFile: TEXT);
  CONST
    FROM_FILE = 'f';
    FROM_LIST = 'l';
    FROM_BOTH = 'b';
    FROM_NONE = 'n';
  VAR
    Temp: TEXT;
    Curr: NodePtr;
    FileCurr: Node;
    ToWrite: CHAR;
  BEGIN { StoreResult }
    ToWrite := FROM_LIST; // Initialization. Meaningful value later    
    CopyFile(ResultFile, Temp);
    RESET(Temp);
    REWRITE(ResultFile);
    Curr := FirstPtr;
    ReadFromFile(FileCurr, Temp);

    WHILE (Curr <> NIL) OR (FileCurr.Word <> '') 
    DO
      BEGIN
        
        ToWrite := FROM_NONE;
        IF (FileCurr.Word = '') AND (Curr <> NIL) THEN ToWrite := FROM_LIST 
        ELSE IF (FileCurr.Word <> '') AND (Curr = NIL) THEN ToWrite := FROM_FILE           
        ELSE IF FileCurr.Word < Curr^.Word THEN ToWrite := FROM_FILE
        ELSE IF FileCurr.Word > Curr^.Word THEN ToWrite := FROM_LIST
        ELSE IF FileCurr.Word = Curr^.Word THEN ToWrite := FROM_BOTH;
        
        IF ToWrite = FROM_FILE
        THEN
          BEGIN
            WriteToFile(FileCurr, ResultFile);
            ReadFromFile(FileCurr, Temp)
          END;
        IF ToWrite = FROM_LIST
        THEN
          BEGIN
            WriteToFile(Curr^, ResultFile);
            Curr := Curr^.Next
          END;
        IF ToWrite = FROM_BOTH
        THEN
          BEGIN
            FileCurr.Qty := FileCurr.Qty + Curr^.Qty;   
            WriteToFile(FileCurr, ResultFile);
            ReadFromFile(FileCurr, Temp);
            Curr := Curr^.Next
          END;      
          
      END;
    ClearMem()  
  END; { StoreResult }
  
  FUNCTION InitializeIoFiles(): BOOLEAN;
  BEGIN
    IF (ParamCount >= 2)
    THEN
      BEGIN
        ASSIGN(SourceFile, ParamStr(1));  
        ASSIGN(ResultFile, ParamStr(2));
        InitializeIoFiles := TRUE
      END
    ELSE
      InitializeIoFiles := FALSE    
  END;

  PROCEDURE CountWords();
  VAR
    Word: STRING;
  BEGIN { CountWords }
    FirstPtr := NIL;
    ListLength := 0;
    RESET(SourceFile);
    REWRITE(ResultFile);
    WHILE NOT EOF(SourceFile)
    DO
      BEGIN
        WHILE NOT EOLN(SourceFile)
        DO
          BEGIN
            ReadWord(Word, SourceFile);
            InsertWord(Word);
            IF ListLength >= MAX_LIST_LENGTH
            THEN
              StoreResult(ResultFile)
          END;
        READLN(SourceFile)
      END;
    StoreResult(ResultFile)
  END; { CountWords }
  
BEGIN
END.
