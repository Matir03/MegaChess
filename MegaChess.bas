'$DYNAMIC
CONST P0 = 1, PN = 2, PB = 3, PR = 4, R0 = 5, NR = 6, N0 = 7, BN = 8, B0 = 9, QN = 10, Q0 = 11, K0 = 12
CONST LL = 15, DD = 2

DIM SHARED Board(1 TO 14, 1 TO 14) AS _BYTE
DIM SHARED Mx, My, Mb1, Mb2
DIM SHARED Img&(0 TO 24)
DIM SHARED WCS, WCL, BCS, BCL
DIM SHARED MainMove
DIM X(-1), Y(-1)

RESTORE BoardData
FOR i = 1 TO 14
 FOR j = 1 TO 14
  READ Board(j, i)
NEXT j, i
WCS = -1
WCL = -1
BCS = -1
BCL = -1

SCREEN _NEWIMAGE(631, 631, 32)
_FULLSCREEN _SQUAREPIXELS

CLS , _RGB32(230, 230, 230)

LINE (150, 100)-STEP(330, 100), _RGB32(30, 120, 250), BF
LINE (150, 300)-STEP(330, 100), _RGB32(30, 120, 250), BF
LINE (150, 500)-STEP(330, 100), _RGB32(30, 120, 250), BF

COLOR _RGB32(80, 180, 80), _RGBA32(190, 190, 190, 10)

_PRINTSTRING (240, 140), "Human vs Human"
_PRINTSTRING (240, 340), "Human vs Computer"
_PRINTSTRING (240, 540), "Computer vs Human"

CHDIR "MegaChess"
FOR i = -12 TO -1
 Img&(i + 12) = _LOADIMAGE("B" + Convert(i) + ".png")
NEXT i
Img&(12) = _NEWIMAGE(35, 35, 32)
FOR i = 1 TO 12
 Img&(i + 12) = _LOADIMAGE("W" + Convert(i) + ".png")
NEXT i

DO: _LIMIT 30
 Mouse
 IF Mb1 THEN
  IF Mx > 150 THEN
   IF Mx < 480 THEN
    IF My > 100 AND My < 200 THEN MMMM = 0: EXIT DO
    IF My > 300 AND My < 400 THEN MMMM = -1: EXIT DO
    IF My > 500 AND My < 600 THEN MMMM = 1: EXIT DO
   END IF
  END IF
 END IF
LOOP

DrawBoard

Move = 1

DO

 IF Move = MMMM THEN
  MainMove = 0
  GetMove LL, DD, Move, A, B, X, Y, P
  MainMove = -1
  MakeMove Move, A, B, X, Y, P
  DrawBoard
  Move = -Move
  GOTO NextLoop
 END IF

 Mouse

 IF Mb1 THEN

  Px = (Mx + 45) \ 45
  Py = (My + 45) \ 45

  IF Px < 1 GOTO NextLoop
  IF Py < 1 GOTO NextLoop
  IF Px > 14 GOTO NextLoop
  IF Py > 14 GOTO NextLoop

  IF Ox THEN

   IF SGN(Board(Ox, Oy)) = SGN(Board(Px, Py)) GOTO NextLoop

   FOR z = 0 TO UBOUND(X)
    IF X(z) = Px THEN IF Y(z) = Py THEN GOTO LegalMove
   NEXT z

   Ox = 0
   Oy = 0
   DrawBoard
   GOTO NextLoop

   LegalMove:
   IF Board(Px, Py) * -Move = K0 THEN
    CLS
    IF Move = 1 THEN C$ = "White" ELSE C$ = "Black"
    FOR i = 1 TO 300
     RANDOMIZE TIMER
     COLOR _RGB32(RND * 255, 255 - (RND * 255), RND ^ 2 * 255), _RGBA32(RND ^ 2 * 255, RND * 255, 255 - (RND * 255), RND ^ RND * 255)
     PRINT C$; " wins! ";
    NEXT i
    SLEEP
    SYSTEM
   END IF

   Board(Px, Py) = Board(Ox, Oy)
   Board(Ox, Oy) = 0

   SELECT CASE ABS(Board(Px, Py))
    CASE P0

     IF Move = 1 THEN

      IF Py = 1 THEN
       LINE (0, 0)-(140, 45), _RGB32(240, 240, 240), BF
       _PUTIMAGE (5, 5), Img&(17)
       _PUTIMAGE (50, 5), Img&(19)
       _PUTIMAGE (95, 5), Img&(21)
       _PUTIMAGE (140, 5), Img&(23)
       DO
        Mouse
        IF Mb1 THEN
         Px2 = (Mx + 45) \ 45
         Py2 = (My + 45) \ 45
         IF Px2 < 5 THEN IF Py2 = 1 THEN EXIT DO
        END IF
       LOOP
       SELECT CASE Px2
        CASE 1: P = R0
        CASE 2: P = N0
        CASE 3: P = B0
        CASE 4: P = Q0
       END SELECT
       Board(Px, Py) = P
      END IF

     ELSE

      IF Py = 14 THEN
       LINE (0, 0)-(140, 45), _RGB32(240, 240, 240), BF
       _PUTIMAGE (5, 5), Img&(7)
       _PUTIMAGE (50, 5), Img&(5)
       _PUTIMAGE (95, 5), Img&(3)
       _PUTIMAGE (140, 5), Img&(1)
       DO
        Mouse
        IF Mb1 THEN
         Px2 = (Mx + 45) \ 45
         Py2 = (My + 45) \ 45
         IF Px2 < 5 THEN IF Py2 = 1 THEN EXIT DO
        END IF
       LOOP
       SELECT CASE Px2
        CASE 1: P = R0
        CASE 2: P = N0
        CASE 3: P = B0
        CASE 4: P = Q0
       END SELECT
       Board(Px, Py) = -P
      END IF

     END IF

    CASE PN, PB, PR
     IF Move = 1 THEN

      IF Py = 1 THEN
       LINE (0, 0)-(140, 45), _RGB32(240, 240, 240), BF
       _PUTIMAGE (5, 5), Img&(18)
       _PUTIMAGE (50, 5), Img&(20)
       _PUTIMAGE (95, 5), Img&(22)
       _PUTIMAGE (140, 5), Img&(23)
       DO
        Mouse
        IF Mb1 THEN
         Px2 = (Mx + 45) \ 45
         Py2 = (My + 45) \ 45
         IF Px2 < 5 THEN IF Py2 = 1 THEN EXIT DO
        END IF
       LOOP
       SELECT CASE Px2
        CASE 1: P = NR
        CASE 2: P = BN
        CASE 3: P = QN
        CASE 4: P = Q0
       END SELECT
       Board(Px, Py) = P
      END IF

     ELSE

      IF Py = 14 THEN
       LINE (0, 0)-(140, 45), _RGB32(240, 240, 240), BF
       _PUTIMAGE (5, 5), Img&(6)
       _PUTIMAGE (50, 5), Img&(4)
       _PUTIMAGE (95, 5), Img&(2)
       _PUTIMAGE (140, 5), Img&(1)
       DO
        Mouse
        IF Mb1 THEN
         Px2 = (Mx + 45) \ 45
         Py2 = (My + 45) \ 45
         IF Px2 < 5 THEN IF Py2 = 1 THEN EXIT DO
        END IF
       LOOP
       SELECT CASE Px2
        CASE 1: P = NR
        CASE 2: P = BN
        CASE 3: P = QN
        CASE 4: P = Q0
       END SELECT
       Board(Px, Py) = -P
      END IF

     END IF

    CASE K0

     IF Move = 1 THEN

      IF Py = 14 THEN

       IF Px = 13 THEN

        IF WCS THEN
         Board(14, 14) = 0
         Board(12, 14) = R0
        END IF

       ELSEIF Px = 3 THEN

        IF WCL THEN
         Board(1, 14) = 0
         Board(4, 14) = R0
        END IF

       END IF

      END IF

      WCS = 0
      WCL = 0

     ELSE

      IF Py = 1 THEN

       IF Px = 13 THEN

        IF BCS THEN
         Board(14, 1) = 0
         Board(12, 1) = -R0
        END IF

       ELSEIF Px = 3 THEN

        IF BCL THEN
         Board(1, 1) = 0
         Board(4, 1) = -R0
        END IF

       END IF

      END IF

      BCS = 0
      BCL = 0

     END IF

    CASE R0

     IF Move = 1 THEN
      IF Oy = 14 THEN
       IF Ox = 1 THEN WCL = 0 ELSE IF Ox = 14 THEN WCS = 0
      END IF
     ELSE
      IF Oy = 1 THEN
       IF Ox = 1 THEN BCL = 0 ELSE IF Ox = 14 THEN BCS = 0
      END IF
     END IF

   END SELECT

   DrawBoard

   Ox = 0
   Oy = 0
   Move = -Move

   DO: Mouse
   LOOP UNTIL Mb1 = 0

  ELSE
   IF SGN(Board(Px, Py)) = Move THEN
    GetLegalSquares Px, Py, X(), Y()
    IF UBOUND(X) = -1 GOTO NextLoop
    Ox = Px
    Oy = Py
    DrawSquare Px, Py, _RGB32(180, 180, 15)
    FOR z = 0 TO UBOUND(X)
     DrawSquare X(z), Y(z), _RGB32(15, 15, 180)
    NEXT z
   END IF
  END IF

 ELSEIF Mb2 THEN

  IF Ox THEN
   DrawBoard
   Ox = 0
   Oy = 0
  END IF

 END IF

NextLoop: LOOP UNTIL _KEYHIT = 27

SYSTEM

BoardData:
DATA -5,-6,-7,-8,-9,-11,-10,-12,-11,-9,-8,-7,-6,-5
DATA -2,-3,-2,-4,-2,-03,-04,-04,-03,-2,-4,-2,-3,-2
DATA -1,-1,-1,-1,-1,-01,-01,-01,-01,-1,-1,-1,-1,-1
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 00,00,00,00,00,000,000,000,000,00,00,00,00,00
DATA 01,01,01,01,01,001,001,001,001,01,01,01,01,01
DATA 02,03,02,04,02,003,004,004,003,02,04,02,03,02
DATA 05,06,07,08,09,011,010,012,011,09,08,07,06,05
RETURN

Errs:
BEEP
RESUME NEXT

FUNCTION Convert$ (Piece)
SELECT CASE ABS(Piece)
 CASE P0: Convert$ = "P"
 CASE PN: Convert$ = "PN"
 CASE PB: Convert$ = "PB"
 CASE PR: Convert$ = "PR"
 CASE R0: Convert$ = "R"
 CASE NR: Convert$ = "NR"
 CASE N0: Convert$ = "N"
 CASE BN: Convert$ = "BN"
 CASE B0: Convert$ = "B"
 CASE QN: Convert$ = "QN"
 CASE Q0: Convert$ = "Q"
 CASE K0: Convert$ = "K"
END SELECT
END FUNCTION

SUB Mouse
WHILE _MOUSEINPUT: WEND
Mx = _MOUSEX
My = _MOUSEY
Mb1 = _MOUSEBUTTON(1)
Mb2 = _MOUSEBUTTON(2)
END SUB

SUB DrawBoard
FOR i = 1 TO 14
 FOR j = 1 TO 14
  IF (i + j) MOD 2 THEN
   DrawSquare i, j, _RGB32(180, 15, 15)
  ELSE
   DrawSquare i, j, _RGB32(15, 180, 15)
  END IF
NEXT j, i
END SUB

SUB DrawSquare (i, j, Clr1~&)
LINE (45 * i - 45, 45 * j - 45)-STEP(45, 45), Clr1~&, BF
_PUTIMAGE (45 * i - 40, 45 * j - 40), Img&(Board(i, j) + 12)
END SUB

SUB GetLegalSquares (A, B, X(), Y())
C = SGN(Board(A, B))
REDIM X(-1), Y(-1): N = -1
SELECT CASE ABS(Board(A, B))
 CASE P0
  IF C = 1 THEN
   SELECT EVERYCASE B
    CASE IS = 12
     IF Board(A, 11) <> 0 GOTO break1
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 11
    CASE IS >= 11
     IF Board(A, 10) <> 0 GOTO break1
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 10
    CASE IS >= 10
     IF Board(A, 9) <> 0 GOTO break1
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 9
    CASE IS >= 9
     IF Board(A, 8) <> 0 GOTO break1
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 8
    CASE 8, 7, 6, 5, 4, 3, 2
     IF Board(A, B - 1) <> 0 GOTO break1
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = B - 1
   END SELECT
   break1:

   IF A - 1 > 0 THEN
    IF Board(A - 1, B - 1) < 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A - 1
     Y(N) = B - 1
   END IF: END IF

   IF A + 1 < 15 THEN
    IF Board(A + 1, B - 1) < 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A + 1
     Y(N) = B - 1
   END IF: END IF

  ELSE

   SELECT EVERYCASE B
    CASE IS = 3
     IF Board(A, 4) <> 0 GOTO break2
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 4
    CASE IS <= 4
     IF Board(A, 5) <> 0 GOTO break2
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 5
    CASE IS <= 5
     IF Board(A, 6) <> 0 GOTO break2
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 6
    CASE IS <= 6
     IF Board(A, 7) <> 0 GOTO break2
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = 7
    CASE 7, 8, 9, 10, 11, 12, 13, 14
     IF Board(A, B + 1) <> 0 GOTO break2
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A
     Y(N) = B + 1
   END SELECT
   break2:

   IF A - 1 > 0 THEN
    IF Board(A - 1, B + 1) > 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A - 1
     Y(N) = B + 1
   END IF: END IF

   IF A + 1 < 15 THEN
    IF Board(A + 1, B + 1) > 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A + 1
     Y(N) = B + 1
   END IF: END IF

  END IF

 CASE PN
  IF C = 1 THEN

   IF A >= 3 THEN
    IF B >= 2 THEN
     IF Board(A - 2, B - 1) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 2
      Y(N) = B - 1
   END IF: END IF: END IF

   IF A >= 2 THEN
    IF B >= 3 THEN
     IF Board(A - 1, B - 2) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 1
      Y(N) = B - 2
   END IF: END IF: END IF

   IF A <= 12 THEN
    IF B >= 2 THEN
     IF Board(A + 2, B - 1) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 2
      Y(N) = B - 1
   END IF: END IF: END IF

   IF A <= 13 THEN
    IF B >= 3 THEN
     IF Board(A + 1, B - 2) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 1
      Y(N) = B - 2
   END IF: END IF: END IF

   i = A: j = B
   DO UNTIL i = 1 OR j = 1
    i = i - 1: j = j - 1
    IF Board(i, j) < 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   i = A: j = B
   DO UNTIL i = 14 OR j = 1
    i = i + 1: j = j - 1
    IF Board(i, j) < 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   IF A > 1 THEN
    FOR i = A - 1 TO 1 STEP -1
     IF Board(i, B) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A < 14 THEN
    FOR i = A + 1 TO 14
     IF Board(i, B) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF B > 1 THEN
    FOR i = B - 1 TO 1 STEP -1
     IF Board(A, i) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A
      Y(N) = i
     END IF
     IF Board(A, i) <> 0 THEN EXIT FOR
    NEXT i
   END IF

  ELSE

   IF A >= 3 THEN
    IF B <= 13 THEN
     IF Board(A - 2, B + 1) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 2
      Y(N) = B + 1
   END IF: END IF: END IF

   IF A >= 2 THEN
    IF B <= 12 THEN
     IF Board(A - 1, B + 2) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 1
      Y(N) = B + 2
   END IF: END IF: END IF

   IF A <= 12 THEN
    IF B <= 13 THEN
     IF Board(A + 2, B + 1) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 2
      Y(N) = B + 1
   END IF: END IF: END IF

   IF A <= 13 THEN
    IF B <= 12 THEN
     IF Board(A + 1, B + 2) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 1
      Y(N) = B + 2
   END IF: END IF: END IF

   i = A: j = B
   DO UNTIL i = 1 OR j = 14
    i = i - 1: j = j + 1
    IF Board(i, j) > 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   i = A: j = B
   DO UNTIL i = 14 OR j = 14
    i = i + 1: j = j + 1
    IF Board(i, j) > 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   IF A > 1 THEN
    FOR i = A - 1 TO 1 STEP -1
     IF Board(i, B) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A < 14 THEN
    FOR i = A + 1 TO 14
     IF Board(i, B) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF B < 14 THEN
    FOR i = B + 1 TO 14
     IF Board(A, i) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A
      Y(N) = i
     END IF
     IF Board(A, i) <> 0 THEN EXIT FOR
    NEXT i
   END IF

  END IF

 CASE PB

  IF C = 1 THEN

   i = A: j = B
   DO UNTIL i = 1 OR j = 1
    i = i - 1: j = j - 1
    IF Board(i, j) = 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    ELSE
     EXIT DO
    END IF
   LOOP

   i = A: j = B
   DO UNTIL i = 14 OR j = 1
    i = i + 1: j = j - 1
    IF Board(i, j) = 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    ELSE
     EXIT DO
    END IF
   LOOP

   IF A > 1 THEN
    FOR i = A - 1 TO 1 STEP -1
     IF Board(i, B) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A < 14 THEN
    FOR i = A + 1 TO 14
     IF Board(i, B) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF B > 1 THEN
    FOR i = B - 1 TO 1 STEP -1
     IF Board(A, i) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A
      Y(N) = i
     END IF
     IF Board(A, i) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A >= 3 THEN
    IF B >= 2 THEN
     IF Board(A - 2, B - 1) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 2
      Y(N) = B - 1
   END IF: END IF: END IF

   IF A >= 2 THEN
    IF B >= 3 THEN
     IF Board(A - 1, B - 2) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 1
      Y(N) = B - 2
   END IF: END IF: END IF

   IF A <= 12 THEN
    IF B >= 2 THEN
     IF Board(A + 2, B - 1) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 2
      Y(N) = B - 1
   END IF: END IF: END IF

   IF A <= 13 THEN
    IF B >= 3 THEN
     IF Board(A + 1, B - 2) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 1
      Y(N) = B - 2
   END IF: END IF: END IF

  ELSE

   i = A: j = B
   DO UNTIL i = 1 OR j = 14
    i = i - 1: j = j + 1
    IF Board(i, j) = 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    ELSE
     EXIT DO
    END IF
   LOOP

   i = A: j = B
   DO UNTIL i = 14 OR j = 14
    i = i + 1: j = j + 1
    IF Board(i, j) = 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    ELSE
     EXIT DO
    END IF
   LOOP

   IF A > 1 THEN
    FOR i = A - 1 TO 1 STEP -1
     IF Board(i, B) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A < 14 THEN
    FOR i = A + 1 TO 14
     IF Board(i, B) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF B < 14 THEN
    FOR i = B + 1 TO 14
     IF Board(A, i) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A
      Y(N) = i
     END IF
     IF Board(A, i) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A >= 3 THEN
    IF B <= 13 THEN
     IF Board(A - 2, B + 1) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 2
      Y(N) = B + 1
   END IF: END IF: END IF

   IF A >= 2 THEN
    IF B <= 12 THEN
     IF Board(A - 1, B + 2) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 1
      Y(N) = B + 2
   END IF: END IF: END IF

   IF A <= 12 THEN
    IF B <= 13 THEN
     IF Board(A + 2, B + 1) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 2
      Y(N) = B + 1
   END IF: END IF: END IF

   IF A <= 13 THEN
    IF B <= 12 THEN
     IF Board(A + 1, B + 2) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 1
      Y(N) = B + 2
   END IF: END IF: END IF

  END IF

 CASE PR
  IF C = 1 THEN
   IF A > 1 THEN
    FOR i = A - 1 TO 1 STEP -1
     IF Board(i, B) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A < 14 THEN
    FOR i = A + 1 TO 14
     IF Board(i, B) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF B > 1 THEN
    FOR i = B - 1 TO 1 STEP -1
     IF Board(A, i) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A
      Y(N) = i
     END IF
     IF Board(A, i) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   i = A: j = B
   DO UNTIL i = 1 OR j = 1
    i = i - 1: j = j - 1
    IF Board(i, j) < 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   i = A: j = B
   DO UNTIL i = 14 OR j = 1
    i = i + 1: j = j - 1
    IF Board(i, j) < 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   IF A >= 3 THEN
    IF B >= 2 THEN
     IF Board(A - 2, B - 1) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 2
      Y(N) = B - 1
   END IF: END IF: END IF

   IF A >= 2 THEN
    IF B >= 3 THEN
     IF Board(A - 1, B - 2) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 1
      Y(N) = B - 2
   END IF: END IF: END IF

   IF A <= 12 THEN
    IF B >= 2 THEN
     IF Board(A + 2, B - 1) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 2
      Y(N) = B - 1
   END IF: END IF: END IF

   IF A <= 13 THEN
    IF B >= 3 THEN
     IF Board(A + 1, B - 2) < 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 1
      Y(N) = B - 2
   END IF: END IF: END IF

  ELSE

   IF A > 1 THEN
    FOR i = A - 1 TO 1 STEP -1
     IF Board(i, B) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF A < 14 THEN
    FOR i = A + 1 TO 14
     IF Board(i, B) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = i
      Y(N) = B
     END IF
     IF Board(i, B) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   IF B < 14 THEN
    FOR i = B + 1 TO 14
     IF Board(A, i) = 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A
      Y(N) = i
     END IF
     IF Board(A, i) <> 0 THEN EXIT FOR
    NEXT i
   END IF

   i = A: j = B
   DO UNTIL i = 1 OR j = 14
    i = i - 1: j = j + 1
    IF Board(i, j) > 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   i = A: j = B
   DO UNTIL i = 14 OR j = 14
    i = i + 1: j = j + 1
    IF Board(i, j) > 0 THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = i
     Y(N) = j
    END IF
    IF Board(i, j) <> 0 THEN EXIT DO
   LOOP

   IF A >= 3 THEN
    IF B <= 13 THEN
     IF Board(A - 2, B + 1) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 2
      Y(N) = B + 1
   END IF: END IF: END IF

   IF A >= 2 THEN
    IF B <= 12 THEN
     IF Board(A - 1, B + 2) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A - 1
      Y(N) = B + 2
   END IF: END IF: END IF

   IF A <= 12 THEN
    IF B <= 13 THEN
     IF Board(A + 2, B + 1) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 2
      Y(N) = B + 1
   END IF: END IF: END IF

   IF A <= 13 THEN
    IF B <= 12 THEN
     IF Board(A + 1, B + 2) > 0 THEN
      N = N + 1
      REDIM _PRESERVE X(N), Y(N)
      X(N) = A + 1
      Y(N) = B + 2
   END IF: END IF: END IF

  END IF

 CASE K0
  IF C = 1 THEN

   IF WCS THEN
    FOR i = 9 TO 13
     IF Board(i, 14) GOTO NoWCS
    NEXT i
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = 13
    Y(N) = 14
   END IF
   NoWCS:

   IF WCL THEN
    FOR i = 7 TO 2 STEP -1
     IF Board(i, 14) GOTO NoWCL
    NEXT i
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = 3
    Y(N) = 14
   END IF
   NoWCL:

  ELSE

   IF BCS THEN
    FOR i = 9 TO 13
     IF Board(i, 1) GOTO NoBCS
    NEXT i
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = 13
    Y(N) = 1
   END IF
   NoBCS:

   IF BCL THEN
    FOR i = 7 TO 2 STEP -1
     IF Board(i, 1) GOTO NoBCL
    NEXT i
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = 3
    Y(N) = 1
   END IF
   NoBCL:

  END IF

  IF A > 1 THEN
   IF SGN(Board(A - 1, B)) <> C THEN
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = A - 1
    Y(N) = B
   END IF
   IF B < 14 THEN
    IF SGN(Board(A - 1, B + 1)) <> C THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A - 1
     Y(N) = B + 1
    END IF
   END IF
   IF B > 1 THEN
    IF SGN(Board(A - 1, B - 1)) <> C THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A - 1
     Y(N) = B - 1
    END IF
   END IF
  END IF

  IF A < 14 THEN
   IF SGN(Board(A + 1, B)) <> C THEN
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = A + 1
    Y(N) = B
   END IF
   IF B < 14 THEN
    IF SGN(Board(A + 1, B + 1)) <> C THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A + 1
     Y(N) = B + 1
    END IF
   END IF
   IF B > 1 THEN
    IF SGN(Board(A + 1, B - 1)) <> C THEN
     N = N + 1
     REDIM _PRESERVE X(N), Y(N)
     X(N) = A + 1
     Y(N) = B - 1
    END IF
   END IF
  END IF

  IF B < 14 THEN
   IF SGN(Board(A, B + 1)) <> C THEN
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = A
    Y(N) = B + 1
   END IF
  END IF

  IF B > 1 THEN
   IF SGN(Board(A, B - 1)) <> C THEN
    N = N + 1
    REDIM _PRESERVE X(N), Y(N)
    X(N) = A
    Y(N) = B - 1
   END IF
  END IF

 CASE R0
  GetRookMoves A, B, X(), Y()

 CASE NR
  GetRookMoves A, B, X(), Y()
  GetKnightMoves A, B, X(), Y()

 CASE N0
  GetKnightMoves A, B, X(), Y()

 CASE BN
  GetBishopMoves A, B, X(), Y()
  GetKnightMoves A, B, X(), Y()

 CASE B0
  GetBishopMoves A, B, X(), Y()

 CASE QN
  GetRookMoves A, B, X(), Y()
  GetKnightMoves A, B, X(), Y()
  GetBishopMoves A, B, X(), Y()

 CASE Q0
  GetRookMoves A, B, X(), Y()
  GetBishopMoves A, B, X(), Y()

END SELECT
END SUB

SUB GetRookMoves (A, B, X(), Y())
N = UBOUND(X)
C = SGN(Board(A, B))

IF A < 14 THEN
 FOR i = A + 1 TO 14
  P = Board(i, B)
  IF SGN(P) <> C THEN
   N = N + 1
   REDIM _PRESERVE X(N), Y(N)
   X(N) = i
   Y(N) = B
  END IF
  IF P <> 0 THEN EXIT FOR
 NEXT i
END IF

IF B < 14 THEN
 FOR i = B + 1 TO 14
  P = Board(A, i)
  IF SGN(P) <> C THEN
   N = N + 1
   REDIM _PRESERVE X(N), Y(N)
   X(N) = A
   Y(N) = i
  END IF
  IF P <> 0 THEN EXIT FOR
 NEXT i
END IF

IF A > 1 THEN
 FOR i = A - 1 TO 1 STEP -1
  P = Board(i, B)
  IF SGN(P) <> C THEN
   N = N + 1
   REDIM _PRESERVE X(N), Y(N)
   X(N) = i
   Y(N) = B
  END IF
  IF P <> 0 THEN EXIT FOR
 NEXT i
END IF

IF B > 1 THEN
 FOR i = B - 1 TO 1 STEP -1
  P = Board(A, i)
  IF SGN(P) <> C THEN
   N = N + 1
   REDIM _PRESERVE X(N), Y(N)
   X(N) = A
   Y(N) = i
  END IF
  IF P <> 0 THEN EXIT FOR
 NEXT i
END IF

END SUB

SUB GetKnightMoves (A, B, X(), Y())
N = UBOUND(X)
C = SGN(Board(A, B))

IF A < 14 THEN
 IF B < 13 THEN
  i = 1: j = 2
  GOSUB Add
 END IF
 IF B > 2 THEN
  i = 1: j = -2
  GOSUB Add
 END IF
END IF

IF A < 13 THEN
 IF B < 14 THEN
  i = 2: j = 1
  GOSUB Add
 END IF
 IF B > 1 THEN
  i = 2: j = -1
  GOSUB Add
 END IF
END IF

IF A > 2 THEN
 IF B < 14 THEN
  i = -2: j = 1
  GOSUB Add
 END IF
 IF B > 1 THEN
  i = -2: j = -1
  GOSUB Add
 END IF
END IF

IF A > 1 THEN
 IF B < 13 THEN
  i = -1: j = 2
  GOSUB Add
 END IF
 IF B > 2 THEN
  i = -1: j = -2
  GOSUB Add
 END IF
END IF

EXIT SUB

Add:
IF SGN(Board(A + i, B + j)) <> C THEN
 N = N + 1
 REDIM _PRESERVE X(N), Y(N)
 X(N) = A + i
 Y(N) = B + j
END IF
RETURN

END SUB

SUB GetBishopMoves (A, B, X(), Y())
N = UBOUND(X)
C = SGN(Board(A, B))

i = A: j = B
DO UNTIL i = 14 OR j = 14
 i = i + 1: j = j + 1
 IF SGN(Board(i, j)) <> C THEN
  N = N + 1
  REDIM _PRESERVE X(N), Y(N)
  X(N) = i
  Y(N) = j
 END IF
 IF Board(i, j) THEN EXIT DO
LOOP

i = A: j = B
DO UNTIL i = 14 OR j = 1
 i = i + 1: j = j - 1
 IF SGN(Board(i, j)) <> C THEN
  N = N + 1
  REDIM _PRESERVE X(N), Y(N)
  X(N) = i
  Y(N) = j
 END IF
 IF Board(i, j) THEN EXIT DO
LOOP

i = A: j = B
DO UNTIL i = 1 OR j = 14
 i = i - 1: j = j + 1
 IF SGN(Board(i, j)) <> C THEN
  N = N + 1
  REDIM _PRESERVE X(N), Y(N)
  X(N) = i
  Y(N) = j
 END IF
 IF Board(i, j) THEN EXIT DO
LOOP

i = A: j = B
DO UNTIL i = 1 OR j = 1
 i = i - 1: j = j - 1
 IF SGN(Board(i, j)) <> C THEN
  N = N + 1
  REDIM _PRESERVE X(N), Y(N)
  X(N) = i
  Y(N) = j
 END IF
 IF Board(i, j) THEN EXIT DO
LOOP

END SUB

SUB MakeMoveList (M, ListA(), ListB(), ListX(), ListY(), P())
N = -1
REDIM ListA(N), ListB(N), ListX(N), ListY(N), P(N)
REDIM X(-1), Y(-1)
FOR A = 1 TO 14
 FOR B = 1 TO 14
  IF SGN(Board(A, B)) = M THEN
   GetLegalSquares A, B, X(), Y()
   IF UBOUND(X) > -1 THEN
    FOR i = 0 TO UBOUND(X)
     N = N + 1
     REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
     ListA(N) = A
     ListB(N) = B
     ListX(N) = X(i)
     ListY(N) = Y(i)
     IF Board(A, B) = P0 THEN
      IF B = 14 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = -P0 THEN
      IF B = 1 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = PR THEN
      IF B = 14 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = PN THEN
      IF B = 14 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = PB THEN
      IF B = 14 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = PR THEN
      IF B = 1 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = PN THEN
      IF B = 1 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
     IF Board(A, B) = PB THEN
      IF B = 1 THEN
       N = N + 3
       REDIM _PRESERVE ListA(N), ListB(N), ListX(N), ListY(N), P(N)
       FOR j = N - 2 TO N
        ListA(j) = A
        ListB(j) = B
        ListX(j) = X(i)
        ListY(j) = Y(i)
       NEXT j
       P(N - 3) = Q0
       P(N - 2) = BN
       P(N - 1) = NR
       P(N) = QN
     END IF: END IF
    NEXT i
   END IF
  END IF
NEXT B, A
END SUB

SUB GetMove (L, D, M, A, B, X, Y, P)
DIM A(-1), B(-1), X(-1), Y(-1), P(-1)
REDIM Oldboard(1 TO 14, 1 TO 14) AS _BYTE
MakeMoveList M, A(), B(), X(), Y(), P()
REDIM Eval(UBOUND(A))
FOR i = 0 TO UBOUND(A)
 Copy Board(), Oldboard()
 owcs = WCS
 owcl = WCL
 obcs = BCS
 obcl = BCL
 MakeMove M, A(i), B(i), X(i), Y(i), P(i)
 Eval(i) = Evaluate(M)
 Copy Oldboard(), Board()
 WCS = owcs
 WCL = owcl
 BCS = obcs
 BCL = obcl
NEXT i
REDIM MList(1 TO L)
Max = 1000000
FOR i = 1 TO L
 ThisMax = 0
 FOR j = 0 TO UBOUND(A)
  IF Eval(j) >= Eval(ThisMax) THEN IF Eval(j) < Max THEN ThisMax = j
 NEXT j
 Max = Eval(ThisMax)
 MList(i) = ThisMax
NEXT i
IF D = 0 THEN
 A = A(MList(1))
 B = B(MList(1))
 X = X(MList(1))
 Y = Y(MList(1))
 P = P(MList(1))
ELSE
 MaxE = -1000000
 FOR i = 1 TO L
  Copy Board(), Oldboard()
  owcs = WCS
  owcl = WCL
  obcs = BCS
  obcl = BCL
  MakeMove M, A(MList(i)), B(MList(i)), X(MList(i)), Y(MList(i)), P(MList(i))
  GetMove L, D - 1, -M, a1, b1, x1, y1, p1
  MakeMove -M, a1, b1, x1, y1, p1
  E = Evaluate(M)
  IF E >= MaxE THEN
   MaxE = E
   A = A(MList(i))
   B = B(MList(i))
   X = X(MList(i))
   Y = Y(MList(i))
   P = P(MList(i))
  END IF
  Copy Oldboard(), Board()
  WCS = owcs
  WCL = owcl
  BCS = obcs
  BCL = obcl
 NEXT i
END IF
END SUB

SUB Copy (Board1() AS _BYTE, NewBoard() AS _BYTE)
FOR i = 1 TO 14
 FOR j = 1 TO 14
  NewBoard(i, j) = Board1(i, j)
NEXT j, i
END SUB

FUNCTION Evaluate (M)
FOR i = 1 TO 14
 FOR j = 1 TO 14
  T = T + Value(Board(i, j))
NEXT j, i
T = 200 * M * T
'DIM A(-1), B(-1), X(-1), Y(-1), P(-1)
'MakeMoveList M, A(), B(), X(), Y(), P()
'Mp = UBOUND(A)
'MakeMoveList -M, A(), B(), X(), Y(), P()
'Mn = UBOUND(A)
RANDOMIZE TIMER
Evaluate = (T + Mp - Mn + RND * 5)
END FUNCTION

SUB MakeMove (Move, Ox, Oy, Px, Py, P)

IF MainMove THEN
 IF Board(Px, Py) = K0 * -Move THEN
  _PUTIMAGE , Img&(12 + K0 * Move)
  SLEEP
  SYSTEM
 END IF
END IF

Board(Px, Py) = Board(Ox, Oy)
Board(Ox, Oy) = 0

IF P THEN Board(Px, Py) = Move * P

SELECT CASE ABS(Board(Px, Py))

 CASE K0

  IF Move = 1 THEN

   IF Py = 14 THEN

    IF Px = 13 THEN

     IF WCS THEN
      Board(14, 14) = 0
      Board(12, 14) = R0
     END IF

    ELSEIF Px = 3 THEN

     IF WCL THEN
      Board(1, 14) = 0
      Board(4, 14) = R0
     END IF

    END IF

   END IF

   WCS = 0
   WCL = 0

  ELSE

   IF Py = 1 THEN

    IF Px = 13 THEN

     IF BCS THEN
      Board(14, 1) = 0
      Board(12, 1) = -R0
     END IF

    ELSEIF Px = 3 THEN

     IF BCL THEN
      Board(1, 1) = 0
      Board(4, 1) = -R0
     END IF

    END IF

   END IF

   BCS = 0
   BCL = 0

  END IF

 CASE R0

  IF Move = 1 THEN
   IF Oy = 14 THEN
    IF Ox = 1 THEN WCL = 0 ELSE IF Ox = 14 THEN WCS = 0
   END IF
  ELSE
   IF Oy = 1 THEN
    IF Ox = 1 THEN BCL = 0 ELSE IF Ox = 14 THEN BCS = 0
   END IF
  END IF

END SELECT

END SUB

FUNCTION Value (Piece)
S = SGN(Piece)
SELECT CASE S * Piece
 CASE P0: Value = 1
 CASE PN: Value = 4
 CASE PB: Value = 4
 CASE PR: Value = 4
 CASE R0: Value = 6
 CASE NR: Value = 9
 CASE B0: Value = 3
 CASE BN: Value = 7
 CASE N0: Value = 3
 CASE Q0: Value = 9
 CASE QN: Value = 14
 CASE K0: Value = 10000
END SELECT
Value = Value * S
END FUNCTION


