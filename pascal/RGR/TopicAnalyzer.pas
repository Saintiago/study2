UNIT TopicAnalyzer;

INTERFACE

  PROCEDURE InitializeSource();
  PROCEDURE GuessTopic();

IMPLEMENTATION

  USES
    GPC,
    WordCounter,
    WordGatherer,
    BaseTextStat,
    PorterStemmer;
  
  CONST
    SOURCE_COUNTED_FILENAME = 'input_counted.txt';
    SOURCE_STAT_FILENAME = 'input_stat.txt';
    
  VAR
    TextToAnalyze: STRING;
    SourceFile: TEXT;
    
  PROCEDURE PrepareInputFile(); FORWARD;
  FUNCTION CompareTo(VAR TopicDir: STRING): INTEGER; FORWARD;  
  FUNCTION GetScore(VAR SourceWord: Node; StatFileName: STRING; SourceIndex: INTEGER): INTEGER; FORWARD;
  
  PROCEDURE InitializeSource();
  BEGIN
    IF (ParamCount < 1) THEN HALT;
    CheckExistance(ParamStr(1));
    TextToAnalyze := ParamStr(1)  
  END;
    
  PROCEDURE GuessTopic();
  VAR
    Score, MaxScore, i: INTEGER;
    AssumedTopic: STRING;
  BEGIN
    PrepareInputFile();
    ReadTopicList();
    MaxScore := 0;
    i := 0;
    WRITELN('Comparing to base texts.');
    WHILE i < TopicCount
    DO
      BEGIN
        Score := CompareTo(BaseTopic[i]);
        WRITELN(TextToAnalyze, ' similar to ', BaseTopic[i], ' by ', Score, ' points');
        IF Score > MaxScore
        THEN
          BEGIN
            MaxScore := Score;
            AssumedTopic := BaseTopic[i]
          END;
        i := i + 1
      END;
      WRITELN('Looks like ', TextToAnalyze, ' is about ', AssumedTopic, '.');
  END;
  
  PROCEDURE PrepareInputFile();
  BEGIN
    InitializeSource();
    CreateFile(SOURCE_COUNTED_FILENAME);
    CreateFile(SOURCE_STAT_FILENAME);
    CountWords(TextToAnalyze, SOURCE_COUNTED_FILENAME);
    GatherWords(SOURCE_COUNTED_FILENAME, SOURCE_STAT_FILENAME);
    SortByFreq(SOURCE_STAT_FILENAME);
    ASSIGN(SourceFile, SOURCE_STAT_FILENAME)
  END;
  
  FUNCTION CompareTo(VAR TopicDir: STRING): INTEGER;
  VAR
    StatFile: STRING;
    SourceWord: Node;
    SourceIndex, Score: INTEGER;
  BEGIN
    StatFile := TopicDir + '/' + STAT_FILENAME;
    CheckExistance(StatFile);
    SourceIndex := 0;
    Score := 0;
    RESET(SourceFile);
    WHILE NOT EOF(SourceFile)
    DO
      BEGIN
        SourceIndex := SourceIndex + 1;
        ReadFromFile(SourceWord, SourceFile);
        Score := Score + GetScore(SourceWord, StatFile, SourceIndex);
      END;
    CompareTo := Score  
  END;
  
  FUNCTION GetScore(VAR SourceWord: Node; StatFileName: STRING; SourceIndex: INTEGER): INTEGER;
  VAR
    StatFile: TEXT;
    StatIndex, Range, Score: INTEGER;
    StatWord: Node;
    SourceStem: STRING;
  BEGIN
    ASSIGN(StatFile, StatFileName);
    StatIndex := 0;
    Score := 0;
    SourceStem := Stem(SourceWord.Word);
    RESET(StatFile);
    WHILE (NOT EOF(StatFile)) AND (StatIndex < (SourceIndex * 2))
    DO
      BEGIN
        StatIndex := StatIndex + 1;
        ReadFromFile(StatWord, StatFile);
        IF (SourceStem = Stem(StatWord.Word))
        THEN
          BEGIN
            Range := ABS(SourceIndex - StatIndex);
            IF SourceIndex > Range
            THEN
              Score := SourceIndex - Range;
            BREAK  
          END
      END;
      GetScore := Score
  END;
  
BEGIN
END.
