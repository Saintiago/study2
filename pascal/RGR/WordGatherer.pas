UNIT WordGatherer;

INTERFACE

  PROCEDURE GatherWords(Source: STRING; Result: STRING);

IMPLEMENTATION

  USES
    PorterStemmer,
    WordCounter;
    
  VAR  
    SourceFile, ResultFile: TEXT;
  
  PROCEDURE InitializeIoFiles(VAR Source: STRING; VAR Result: STRING);
  BEGIN
    CheckExistance(Source);
    CheckExistance(Result);
    ASSIGN(SourceFile, Source);  
    ASSIGN(ResultFile, Result)
  END;
    
  PROCEDURE GatherWords(Source: STRING; Result: STRING);
  VAR
    WordCurr, WordNext: Node;
    StemCurr, StemNext: STRING;
  BEGIN
    InitializeIoFiles(Source, Result);
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
