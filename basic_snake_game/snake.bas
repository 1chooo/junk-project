10 HOME : LET MAXS = 1000  : REM MAY SNAKE LENGTH
20 LET L = 1               : REM CURRENT SNAKE LENGTH
30 LET W = 40 : LET H = 24 : REM WIDTH AND HEIGHT
40 GOSUB 1000
50 DIM X(MAXS) : DIM Y(MAXS) : LET O = 0 : REM SNAKE POSITIONS IN A RING BUFFER
60 X(1) = 20 : Y(1) = 12 : X(MAXS) = X(1) : Y(MAXS) = Y(1) : REM SETUP INITIAL POSITIAN AND PREVIOUS POSITION
65 LET DX = 0 : LET DY = 0 : REM SNAKE DIRECTION

70 GOSUB 2000 : REM DISPLAY SNAKE
80 FOR N = 1 TO 800 : NEXT N : REM DELAY BETWEEN FRAMES
90 GOTO 70    : REM INFINITE LOOP

999  REM CREATE FOOD
1000 LET FX = INT(RND(1) * W) + 1 : LET FY = INT(RND(1) * H) + 1 : REM PICK RANDOM POSITION
1010 HTAB FX : VTAB FY
1020 PRINT "*"
1030 RETURN

1999 REM DISPLAY SNAKE
2000 LET LO = (O-L+MAXS) - (int((O-L)/MAXS + 1))*MAXS : REM CALCULATE INDEX OF TAIL OF SNAKE
2010 HTAB X(LO+1) : VTAB Y(LO+1) : REM DELETE PREVIOUS TAIL
2020 PRINT " "
2030 HTAB X(O+1) : VTAB Y(O+1)   : REM ADD NEW SNAKE HEAD
2040 PRINT "H"
2050 GOSUB 3000
2060 RETURN

2999 REM READ KEYBOARD
3000 LET K = PEEK(49152)
3010 IF K = 211 AND DY >= 0 THEN DX =  0 : DY =  1  : REM W
3020 IF K = 193 AND DX <= 0 THEN DX = -1 : DY =  0  : REM A
3030 IF K = 215 AND DY <= 0 THEN DX =  0 : DY = -1  : REM S
3040 IF K = 196 AND DX >= 0 THEN DX =  1 : DY =  0  : REM D
3050 IF NOT K = 0 THEN GOSUB 4000 : REM MOVE SNAKE
3060 IF X(O+1) < 1 OR X(O+1) > W THEN GOTO 7000     : REM CHECK BOUNDS
3070 IF Y(O+1) < 1 OR Y(O+1) > H THEN GOTO 7000
3080 IF L > 1 THEN GOSUB 6000     : REM CHECK IF SNAKE HIT ITSELF
3090 IF X(O+1) = FX AND Y(O+1) = FY THEN GOSUB 5000 : REM EAT FOOD AND GROW
3100 RETURN

3999 REM MOVE SNAKE
4000 PO = O : REM PREVIOUS OFFSET = OFFSET
4010 O = (O + 1) - int((O + 1)/MAXS)*MAXS : REM OFFSET = (OFFSET + 1) % MAX_SIZE
4020 X(O+1) = X(PO+1) + DX : Y(O+1) = Y(PO+1) + DY : REM UPDATE POSITION
4030 RETURN

4999 REM GROW
5000 L = L + 1  : REM SNAKE LENGTH ++
5010 GOSUB 1000 : REM ADD NEW FOOD
5020 RETURN

5999 REM CHECK IF SNAKE HIT ITSELF
6000 FOR I = 0 TO L-1 : REM ITERATE THROUGH SNAKE LENGTH
6010 LET CO = (O-L+MAXS+I) - (int((O-L+I)/MAXS + 1))*MAXS : REM CURRENT INDEX OF SNAKE PART
6020 IF X(O+1) = X(CO+1) AND Y(O+1) = Y(CO+1) THEN GOTO 7000 : REM GAME OVER
6030 NEXT I
6040 RETURN

6999 REM GAME OVER
7000 HTAB 18 : VTAB 12
7010 PRINT "GAME"
7020 HTAB 18 : VTAB 13
7030 PRINT "OVER"
7040 END