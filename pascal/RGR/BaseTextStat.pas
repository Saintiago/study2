UNIT BaseTextStat;

INTERFACE
  
  CONST
    STAT_FILENAME = 'topic.stat';
    TOPIC_MAX = 10;
  
  VAR
    BaseTopic: ARRAY[0..TOPIC_MAX] OF STRING; 
    TopicCount: INTEGER; 

  PROCEDURE GenerateTopicStat();
  PROCEDURE ReadTopicList();
  PROCEDURE CreateFile(Path: STRING);

IMPLEMENTATION

  USES
    GPC,
    WordCounter,
    WordGatherer;
    
  CONST
    COUNTED_FILENAME = 'topic.raw';
    FILENAME_MAX = 16;  
  
  PROCEDURE ProcessDir(DirName: STRING); FORWARD;
  PROCEDURE SkipUnrelated(VAR Dir: DirPtr); FORWARD;

  PROCEDURE GenerateTopicStat();
  VAR
    i: INTEGER;
  BEGIN
    ReadTopicList();
    i := 0;
    WHILE i < TopicCount
    DO
      BEGIN
        ProcessDir(BaseTopic[i]);
        i := i + 1
      END;
  END;

  PROCEDURE ReadTopicList();
  VAR
    CurDir: DirPtr;
    DirName: STRING;
  BEGIN
    CurDir := OpenDir(GetCurrentDirectory());
    SkipUnrelated(CurDir);
    DirName := ReadDir(CurDir);
    TopicCount := 0;
    WRITELN('Available topics: ');
    WHILE (DirName <> '') AND (TopicCount < TOPIC_MAX)
    DO
      BEGIN
        IF (DirectoryExists(DirName))
        THEN
          BEGIN
            BaseTopic[TopicCount] := DirName;
            WRITELN(' - ', DirName);
            TopicCount := TopicCount + 1
          END;
        DirName := ReadDir(CurDir);  
      END
  END;
  
  PROCEDURE ProcessDir(VAR DirName: STRING);
  VAR
    Dir: DirPtr;
    FileName, StatName, GatheredName: STRING;
  BEGIN
    CheckExistance(DirName);
    WRITELN('Processing dir ', DirName, '...');
    Dir := OpenDir(DirName);
    SkipUnrelated(Dir);
    StatName := DirName + '\' + COUNTED_FILENAME;
    CreateFile(StatName);
    GatheredName := DirName + '\' + STAT_FILENAME; 
    CreateFile(GatheredName);
    FileName := ReadDir(Dir);
    WHILE (FileName <> '')
    DO
      BEGIN
        IF (FileName <> COUNTED_FILENAME) AND (FileName <> STAT_FILENAME)
        THEN
          BEGIN
            WRITELN('  - ', FileName, '...');
            FileName := DirName + '\' + FileName;
            CountWords(FileName, StatName)
          END;
            
        FileName := ReadDir(Dir)
      END;
    GatherWords(StatName, GatheredName);
    SortByFreq(GatheredName);
    CloseDir(Dir)
  END;
  
  PROCEDURE SkipUnrelated(VAR Dir: DirPtr);
  BEGIN
    ReadDir(Dir);
    ReadDir(Dir)
  END;
  
  PROCEDURE CreateFile(Path: STRING);
  VAR 
    FileHandler: TEXT;
  BEGIN
    ASSIGN(FileHandler, Path);
    REWRITE(FileHandler);
    CLOSE(FileHandler)
  END;
  
BEGIN

END.
