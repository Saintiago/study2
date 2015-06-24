UNIT WordCounter;

INTERFACE

  TYPE
    NodePtr = ^Node;
    Node = RECORD
             Next: NodePtr;
             Word: STRING;
             Qty: INTEGER
           END; 
  
  PROCEDURE CheckExistance(Path: STRING); 
  PROCEDURE CountWords(Source: STRING; Result: STRING);
  PROCEDURE ReadFromFile(VAR Row: Node; VAR Source: TEXT);
  PROCEDURE WriteToFile(VAR Row: Node; VAR Result: TEXT);
  PROCEDURE ReadWord(VAR Word: STRING; VAR SourceFile: TEXT);
  PROCEDURE SortByFreq(Path: STRING);

IMPLEMENTATION

  USES
    GPC;

  CONST
    MAX_LIST_LENGTH = 500;
    ALLOWED_CHARS = ['à' .. 'ÿ', 'a' .. 'z'];
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
        Ch := LoCase(Ch);
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

  PROCEDURE InsertWordByAlpha(VAR Word: STRING);
  CONST
    EQUAL = 'e';
    FOUND = 'f';
    SEARCHING = 's';
  VAR
    NewWord, Curr, Prev: NodePtr;
    SearchState: CHAR;
  BEGIN  { InsertWordByAlpha }
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
  END;  { InsertWordByAlpha }
  
  PROCEDURE InsertWordByFreq(VAR NewWord: Node);
  CONST
    FOUND = 'f';
    SEARCHING = 's';
  VAR
    NewWordPtr, Curr, Prev: NodePtr;
    SearchState: CHAR;
  BEGIN  { InsertWordByFreq }
    IF NewWord.Word = ''
    THEN
      EXIT;
    Curr := FirstPtr;
    Prev := NIL;
    NEW(NewWordPtr);
    NewWordPtr^.Word := NewWord.Word;
    NewWordPtr^.Qty := NewWord.Qty;
    NewWordPtr^.Next := NIL;
    SearchState := SEARCHING;
    WHILE (Curr <> NIL) AND (SearchState = SEARCHING)
    DO
      BEGIN
        IF NewWordPtr^.Qty > Curr^.Qty
        THEN
          SearchState := FOUND
        ELSE IF NewWordPtr^.Qty <= Curr^.Qty
        THEN
          BEGIN
            Prev := Curr;
            Curr := Curr^.Next
          END
      END;
      IF Prev = NIL
      THEN
        BEGIN
          NewWordPtr^.Next := FirstPtr;
          FirstPtr := NewWordPtr
        END
      ELSE IF SearchState = SEARCHING
      THEN
        Prev^.Next := NewWordPtr
      ELSE IF SearchState = FOUND
      THEN
        BEGIN
          Prev^.Next := NewWordPtr;
          NewWordPtr^.Next := Curr
        END
  END;  { InsertWordByFreq }

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
  
  PROCEDURE InitializeIoFiles(VAR Source: STRING; VAR Result: STRING);
  BEGIN
    CheckExistance(Source);
    CheckExistance(Result);
    ASSIGN(SourceFile, Source);  
    ASSIGN(ResultFile, Result)
  END;

  PROCEDURE CountWords(VAR Source: STRING; VAR Result: STRING);
  VAR
    Word: STRING;
  BEGIN { CountWords }
    InitializeIoFiles(Source, Result);
    FirstPtr := NIL;
    ListLength := 0;
    RESET(SourceFile);
    WHILE NOT EOF(SourceFile)
    DO
      BEGIN
        WHILE NOT EOLN(SourceFile)
        DO
          BEGIN
            ReadWord(Word, SourceFile);
            InsertWordByAlpha(Word);
            IF ListLength >= MAX_LIST_LENGTH
            THEN
              StoreResult(ResultFile)
          END;
        READLN(SourceFile)
      END;
    StoreResult(ResultFile)
  END; { CountWords }
  
  PROCEDURE SortByFreq(Path: STRING);
  VAR
    SourceFile, Temp: TEXT;
    CurrWord: Node;
  BEGIN { CountWords }
    CheckExistance(Path);
    ASSIGN(SourceFile, Path);
    CopyFile(SourceFile, Temp);
    RESET(Temp);
    FirstPtr := NIL;
    WHILE NOT EOF(Temp)
    DO
      BEGIN
        ReadFromFile(CurrWord, Temp);
        IF (CurrWord.Qty > 1)
        THEN
          InsertWordByFreq(CurrWord);
      END;
    REWRITE(SourceFile);  
    StoreResult(SourceFile)
  END; { CountWords }
  
  PROCEDURE CheckExistance(Path: STRING); 
  BEGIN
    IF NOT PathExists(Path)
    THEN
      BEGIN
        WRITELN('Error. Path ', Path, ' not found.');
        HALT
      END  
  END;
  
BEGIN
END.
