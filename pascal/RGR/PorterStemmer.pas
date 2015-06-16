UNIT PorterStemmer;

INTERFACE

  FUNCTION Stem(Word: STRING): STRING;

IMPLEMENTATION

  CONST
    SIZE = 36;

  TYPE
    StringArray = ARRAY[1..SIZE] OF STRING;
  
  CONST
    VOWELS : StringArray = ('À', 'Å', 'È', 'Î', 'Ó', 'Û', 'Ý', 'Þ', 'ß');
    PERFECTIVE_GERUND_1 : StringArray = ('Â', 'ÂØÈ', 'ÂØÈÑÜ');
    PERFECTIVE_GERUND_2 : StringArray = ('ÈÂ', 'ÈÂØÈ', 'ÈÂØÈÑÜ', 'ÛÂ', 
                                         'ÛÂØÈ', 'ÛÂØÈÑÜ');
              
              ADJECTIVE : StringArray = ('ÅÅ', 'ÈÅ', 'ÛÅ', 'ÎÅ', 'ÈÌÈ', 'ÛÌÈ', 
                                         'ÅÉ', 'ÈÉ', 'ÛÉ', 'ÎÉ', 'ÅÌ', 'ÈÌ', 
                                         'ÛÌ', 'ÎÌ', 'ÅÃÎ', 'ÎÃÎ', 'ÅÌÓ', 'ÎÌÓ', 
                                         'ÈÕ', 'ÛÕ', 'ÓÞ', 'ÞÞ', 'Àß', 'ßß', 
                                         'ÎÞ', 'ÅÞ');
    
           PARTICIPLE_1 : StringArray = ('ÅÌ', 'ÍÍ', 'ÂØ', 'ÞÙ', 'Ù');
           PARTICIPLE_2 : StringArray = ('ÈÂØ', 'ÛÂØ', 'ÓÞÙ');
              REFLEXIVE : StringArray = ('Ñß', 'ÑÜ');
                 
                 VERB_1 : StringArray = ('ËÀ', 'ÍÀ', 'ÅÒÅ', 'ÉÒÅ', 'ËÈ', 'É', 'Ë', 
                                         'ÅÌ', 'Í', 'ËÎ', 'ÍÎ', 'ÅÒ', 'ÞÒ', 'ÍÛ', 
                                         'ÒÜ', 'ÅØÜ', 'ÍÍÎ');
                 VERB_2 : StringArray = ('ÈËÀ', 'ÛËÀ', 'ÅÍÀ', 'ÅÉÒÅ', 'ÓÉÒÅ', 
                                         'ÈÒÅ', 'ÈËÈ', 'ÛËÈ', 'ÅÉ', 'ÓÉ', 'ÈË', 
                                         'ÛË', 'ÈÌ', 'ÛÌ', 'ÅÍ', 'ÈËÎ', 'ÛËÎ', 
                                         'ÅÍÎ', 'ßÒ', 'ÓÅÒ', 'ÓÞÒ', 'ÈÒ', 'ÛÒ', 
                                         'ÅÍÛ', 'ÈÒÜ', 'ÛÒÜ', 'ÈØÜ', 'ÓÞ', 'Þ');
           
                   NOUN : StringArray = ('À', 'ÅÂ', 'ÎÂ', 'ÈÅ', 'ÜÅ', 'Å', 'ÈßÌÈ', 
                                         'ßÌÈ', 'ÀÌÈ', 'ÅÈ', 'ÈÈ', 'È', 'ÈÅÉ', 'ÅÉ', 
                                         'ÎÉ', 'ÈÉ', 'É', 'ÈßÌ', 'ßÌ', 'ÈÅÌ', 'ÅÌ', 
                                         'ÀÌ', 'ÎÌ', 'Î', 'Ó', 'ÀÕ', 'ÈßÕ', 'ßÕ', 
                                         'Û', 'Ü', 'ÈÞ', 'ÜÞ', 'Þ', 'Èß', 'Üß', 'ß');          
                   
            SUPERLATIVE : StringArray = ('ÅÉØ', 'ÅÉØÅ');  
           DERIVATIONAL : StringArray = ('ÎÑÒ', 'ÎÑÒÜ');
                   A_YA : StringArray = ('À', 'ß');
                      I : StringArray = ('È');
              SOFT_SIGN : StringArray = ('Ü');
                     NN : StringArray = ('ÍÍ');
    
  VAR
    RvStart, R2Start, Pos: INTEGER;  
  
  FUNCTION InArray(Str: STRING; VAR Arr: StringArray): BOOLEAN;
  VAR                    
    i: INTEGER;
    Res: BOOLEAN;
  BEGIN 
    Res := FALSE;
    FOR i:= 1 to SIZE
    DO
      IF Arr[i] = Str
      THEN
        Res := TRUE;
    InArray := Res
  END;
  
  FUNCTION IsVowel(Pos: INTEGER; Word: STRING): BOOLEAN;
  VAR
    Ch: STRING;
  BEGIN
    Ch := Word[Pos];
    IsVowel := InArray(Ch, VOWELS)
  END;
  
  FUNCTION IsVowelConsonant(Pos: INTEGER; Word: STRING): BOOLEAN;
  VAR
    Ch1, Ch2: STRING;
  BEGIN
    Ch1 := Word[Pos - 2];
    Ch2 := Word[Pos - 1];
    IsVowelConsonant := (InArray(Ch1, VOWELS)) AND NOT (InArray(Ch2, VOWELS))
  END;
  
  FUNCTION GetRvStart(Word: STRING): INTEGER;
  VAR
    i, WordLength: INTEGER;
  BEGIN
    GetRvStart := 0;
    WordLength := Length(Word);
    FOR i := 2 to WordLength
    DO
      IF IsVowel(i - 1, Word) 
      THEN 
        BEGIN 
          GetRvStart := i;
          EXIT
        END
  END;
  
  FUNCTION GetRStart(Word: STRING): INTEGER;
  VAR
    i, WordLength: INTEGER;
  BEGIN
    GetRStart := 0;
    WordLength := Length(Word);
    FOR i := 3 to WordLength
    DO
      IF IsVowelConsonant(i, Word) 
      THEN 
        BEGIN 
          GetRStart := i;
          EXIT
        END
  END;
  
  FUNCTION GetWordPart(StartPos: INTEGER; Word: STRING): STRING;
  BEGIN 
    GetWordPart := COPY(Word, StartPos)
  END;
  
  FUNCTION GetRv(Word: STRING): STRING;
  BEGIN
    GetRv := GetWordPart(GetRvStart(Word), Word)
  END;
  
  FUNCTION GetR(Word: STRING): STRING;
  BEGIN
    GetR := GetWordPart(GetRStart(Word), Word)
  END;
  
  PROCEDURE RemoveWordEnding(VAR Word: STRING);
  BEGIN
    IF Pos > 0 THEN Delete(Word, Pos)
  END;
  
  FUNCTION IsPerfectiveGerund(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str, PrevCh: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsPerfectiveGerund := FALSE;
    IF InArray(Str, PERFECTIVE_GERUND_2)
    THEN
      IsPerfectiveGerund := TRUE
    ELSE IF (Pos > RvStart)
    THEN
      BEGIN
        PrevCh := Word[Pos - 1];
        IsPerfectiveGerund := InArray(Str, PERFECTIVE_GERUND_1) AND InArray(PrevCh, A_YA);
      END
  END;
    
  FUNCTION IsReflexive(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsReflexive := InArray(Str, REFLEXIVE)
  END;
  
  FUNCTION IsParticiple(Pos: INTEGER; Length: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str, PrevCh: STRING;
  BEGIN
    Str := COPY(Word, Pos, Length);
    IsParticiple := FALSE;
    IF InArray(Str, PARTICIPLE_2)
    THEN
      IsParticiple := TRUE
    ELSE IF (Pos > RvStart)
    THEN
      BEGIN
        PrevCh := Word[Pos - 1];
        IsParticiple := InArray(Str, PARTICIPLE_1) AND InArray(PrevCh, A_YA);
      END
  END;
  
  FUNCTION IsAdjectival(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsAdjectival := InArray(Str, ADJECTIVE)
  END;
  
  FUNCTION IsVerb(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str, PrevCh: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsVerb := FALSE;
    IF InArray(Str, VERB_2)
    THEN
      IsVerb := TRUE
    ELSE IF (Pos > RvStart)
    THEN
      BEGIN
        PrevCh := Word[Pos - 1];
        IsVerb := InArray(Str, VERB_1) AND InArray(PrevCh, A_YA);
      END
  END;
  
  FUNCTION IsNoun(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsNoun := InArray(Str, NOUN)
  END;
  
  FUNCTION IsI(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsI := InArray(Str, I)
  END;
  
  FUNCTION IsNN(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsNN := InArray(Str, NN)
  END;
  
  FUNCTION IsSoftSign(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsSoftSign := InArray(Str, SOFT_SIGN)
  END;
  
  FUNCTION IsDerivational(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsDerivational := InArray(Str, DERIVATIONAL)
  END;
  
  FUNCTION IsSuperlative(Pos: INTEGER; VAR Word: STRING): BOOLEAN;
  VAR
    Str: STRING;
  BEGIN
    Str := GetWordPart(Pos, Word);
    IsSuperlative := InArray(Str, SUPERLATIVE)
  END;
  
  PROCEDURE RemovePerfectiveGerund(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN { RemovePerfectiveGerund }
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO RvStart
    DO
      IF IsPerfectiveGerund(i, Word) 
      THEN 
        Pos := i;
    RemoveWordEnding(Word)    
  END; { RemovePerfectiveGerund }
  
  PROCEDURE RemoveReflexive(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO RvStart
    DO
      IF IsReflexive(i, Word) 
      THEN 
        Pos := i;
    RemoveWordEnding(Word)    
  END;
  
  FUNCTION FindParticiple(Pos: INTEGER; VAR Word: STRING): INTEGER;
  VAR
    i: INTEGER;
  BEGIN
    FindParticiple := Pos;
    FOR i := Pos DOWNTO RvStart
    DO
      IF IsParticiple(i, Pos - i, Word) 
      THEN 
        FindParticiple := i
  END;  
  
  PROCEDURE RemoveAdjectival(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN 
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO RvStart
    DO
      IF IsAdjectival(i, Word) 
      THEN
        Pos := FindParticiple(i, Word);    
    RemoveWordEnding(Word)  
  END;
  
  PROCEDURE RemoveVerb(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO RvStart
    DO
      IF IsVerb(i, Word) 
      THEN 
        Pos := i;
    RemoveWordEnding(Word)
  END;
  
  PROCEDURE RemoveNoun(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO RvStart
    DO
      IF IsNoun(i, Word) 
      THEN 
        Pos := i;
    RemoveWordEnding(Word)
  END;
  
  PROCEDURE RemoveDerivational(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO R2Start
    DO
      IF IsDerivational(i, Word) 
      THEN 
        Pos := i;
    RemoveWordEnding(Word)
  END;
  
  PROCEDURE RemoveI(VAR Word: STRING);
  VAR
    WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    IF IsI(WordLength, Word) 
    THEN 
      Pos := WordLength;
    RemoveWordEnding(Word)
  END;
  
  PROCEDURE RemoveN(VAR Word: STRING);
  VAR
    WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    IF WordLength < 2 THEN EXIT;
    IF IsNN(WordLength - 1, Word) 
    THEN 
      Pos := WordLength;
    RemoveWordEnding(Word)
  END;
  
  PROCEDURE RemoveSuperlative(VAR Word: STRING);
  VAR
    i, WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    FOR i := WordLength DOWNTO RvStart
    DO
      IF IsSuperlative(i, Word) 
      THEN 
        Pos := i;
    RemoveWordEnding(Word)
  END;
  
  PROCEDURE RemoveSoftSign(VAR Word: STRING);
  VAR
    WordLength: INTEGER;
  BEGIN
    Pos := 0;
    WordLength := Length(Word);
    IF IsSoftSign(WordLength, Word) 
    THEN 
      Pos := WordLength;
    RemoveWordEnding(Word)
  END;
  
  FUNCTION IsRemoved(): BOOLEAN;
  BEGIN
    IsRemoved := (Pos > 0);
  END;
  
  FUNCTION Stem(Word: STRING): STRING;
  BEGIN { Stem }
    RvStart := GetRvStart(Word);
    R2Start := GetRStart(GetR(Word));
    Pos := 0;

    // Step 1
    RemovePerfectiveGerund(Word);
    IF NOT IsRemoved()
    THEN
      BEGIN
        RemoveReflexive(Word);
        RemoveAdjectival(Word);
        IF NOT IsRemoved() THEN RemoveVerb(Word);
        IF NOT IsRemoved() THEN RemoveNoun(Word)  
      END;
      
    // Step 2
    RemoveI(Word);
    
    // Step 3
    RemoveDerivational(Word);    
    
    // Step 4
    RemoveN(Word);
    IF NOT IsRemoved()
    THEN
      BEGIN
        RemoveSuperlative(Word);    
        IF IsRemoved() THEN RemoveN(Word)
        ELSE RemoveSoftSign(Word)
      END;
    
    Stem := Word
  END; { Stem }

BEGIN 
END.
