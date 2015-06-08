PROGRAM CountWords(INPUT, OUTPUT);
CONST
  MAX_WORDS = 10;
  SPACE = ' ';
TYPE
  NodePtr = ^Node;
  Node = RECORD
           Next: NodePtr;
           Word: STRING;
           Qty: INTEGER
         END;
VAR
  Pointer: NodePtr;

PROCEDURE ClearMem(VAR Pointer: NodePtr);
BEGIN { ClearMem }
  IF Pointer <> NIL
  THEN
    BEGIN
      IF Pointer^.Next <> NIL
      THEN
        BEGIN
          ClearMem(Pointer^.Next)
        END;
      freemem(Pointer)
    END
END; { ClearMem }

BEGIN { CountWords }

  NEW(Pointer);
  ClearMem(Pointer);

END. { CountWords }

