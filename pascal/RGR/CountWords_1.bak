PROGRAM CountWords(INPUT, OUTPUT);

USES TextAnalyzer;

CONST
  MAX_WORDS = 100;

VAR
  SourceFile, ResultFile: TEXT;

BEGIN { CountWords }

  ASSIGN(SourceFile, 'source_sm.txt');
  ASSIGN(ResultFile, 'result.txt');

  CountWords(SourceFile, ResultFile);
  PrintList();

  CLOSE(SourceFile);
  CLOSE(ResultFile)
  
END. { CountWords }

