UNIT TextAnalyzer;

INTERFACE
  TYPE
    NodePtr = ^Node;
    Node = RECORD
             Next: NodePtr;
             Word: STRING;
             Qty: INTEGER
           END;

  PROCEDURE CountWords(VAR SourceFile: TEXT; VAR ResultFile: TEXT);
  PROCEDURE PrintList();

IMPLEMENTATION

  

  CONST
    AllowedChars = ['À' .. 'ÿ'];

  VAR
    WordQty: INTEGER;
    FirstPtr: NodePtr;

  PROCEDURE ReadWord(VAR Word: STRING; VAR SourceFile: TEXT);
  CONST
    WORD_END = 'e';
    WORD_IN = 'i';
    WORD_BEFORE = 'b';
  VAR
    Ch, WordState: CHAR;
    Allowed: BOOLEAN;
  BEGIN { ReadWord }
    Word := '';
    WordState := 'b';
    REPEAT
      BEGIN
        READ(SourceFile, Ch);
        Ch := UpCase(Ch);
        Allowed := (Ch IN AllowedChars);
        IF Allowed AND (WordState = WORD_IN)
        THEN
          Word := Word + Ch
        ELSE IF Allowed AND (WordState <> WORD_IN)
        THEN
          BEGIN
            WordState := WORD_IN;
            Word := Word + Ch
          END
        ELSE IF NOT Allowed AND (WordState = WORD_IN)
        THEN
          WordState := WORD_END
      END
    UNTIL EOF(SourceFile) OR (WordState = WORD_END)
  END; { ReadWord }

  PROCEDURE PrintList();
  VAR
    Curr: NodePtr;
  BEGIN
    Curr := FirstPtr;
    WHILE (Curr <> NIL)
    DO
      BEGIN
        WRITELN(Curr^.Word, ' ', Curr^.Qty);
        Curr := Curr^.Next
      END
  END;

  PROCEDURE InsertWord(VAR Word: STRING);
  CONST
    EQUAL = 'e';
    FOUND = 'f';
    SEARCHING = 's';
  VAR
    NewWord, Curr, Prev: NodePtr;
    SearchState: CHAR;
  BEGIN  { InsertWord }

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

  PROCEDURE CountWords(VAR SourceFile: TEXT; VAR ResultFile: TEXT);
  VAR
    Word: STRING;
  BEGIN { CountWords }
    FirstPtr := NIL;
    WordQty := 0;
    RESET(SourceFile);
    WHILE NOT EOF(SourceFile)
    DO
      BEGIN
        WHILE NOT EOLN(SourceFile)
        DO
          BEGIN
            ReadWord(Word, SourceFile);
            InsertWord(Word)
          END;
        READLN(SourceFile)
      END
  END; { CountWords }

BEGIN
END.
