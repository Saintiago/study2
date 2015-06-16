PROGRAM Words(INPUT, OUTPUT);

USES WordCounter;

BEGIN { CountWords }

  IF NOT InitializeIoFiles()
  THEN
    WRITELN('Specify input and output files');
  
  CountWords();

END. { CountWords }

