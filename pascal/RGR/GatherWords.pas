PROGRAM GatherWords(INPUT, OUTPUT);

USES
  PorterStemmer;
  WordGatherer;

VAR
  Word: STRING;
  i: INTEGER;

BEGIN { GatherWords }
 
  WRITELN('Program: ', ParamStr(0));
  FOR i := 1 to ParamCount do
    WRITELN('Param ', i, ': ', ParamStr(i));

  Word := ' –Œ¬¿“‹ﬁ';
  WRITELN(Word);
  WRITELN(Stem(Word))

END. { GatherWords }

