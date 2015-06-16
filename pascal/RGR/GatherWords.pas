PROGRAM Words(INPUT, OUTPUT);

USES WordGatherer;

BEGIN { CountWords }

  IF NOT InitializeIoFiles()
  THEN
    WRITELN('Specify input and output files');
  
  GatherWords();

END. { CountWords }

