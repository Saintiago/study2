UNIT WordGatherer;

INTERFACE

  FUNCTION InitializeIoFiles(): BOOLEAN;
  PROCEDURE GatherWords();

IMPLEMENTATION

  USES
    PorterStemmer,
    WordCounter;
    
  VAR  
    SourceFile, ResultFile: TEXT;
  
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
    
  PROCEDURE GatherWords();
  VAR
    WordCurr, WordNext: Node;
    StemCurr, StemNext: STRING;
  BEGIN
    RESET(SourceFile);
    REWRITE(ResultFile);
    ReadFromFile(WordCurr, SourceFile);
    StemCurr := Stem(WordCurr.Word);
    WHILE NOT EOF(SourceFile)
    DO
      BEGIN
        ReadFromFile(WordNext, SourceFile);
        StemNext := Stem(WordNext.Word);
        IF StemCurr = StemNext
        THEN
          WordCurr.Qty := WordCurr.Qty + WordNext.Qty    
        ELSE
          BEGIN
            WriteToFile(WordCurr, ResultFile);
            WordCurr := WordNext;
            StemCurr := StemNext
          END  
      END
  END;  

BEGIN
END.
