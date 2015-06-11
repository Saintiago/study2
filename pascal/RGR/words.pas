PROGRAM Words(INPUT, OUTPUT);

USES WordCounter;

VAR
  SourceFile, ResultFile: TEXT;

BEGIN { CountWords }

  ASSIGN(SourceFile, 'source.txt');
  ASSIGN(ResultFile, 'result.txt');

  CountWords(SourceFile, ResultFile);

  CLOSE(SourceFile);
  CLOSE(ResultFile)
  
END. { CountWords }

