program pong;
uses crt;

const
	PitchHeight = 16;
	PitchWidth = 76;
	RacketWidth = 14;
	DelayDecrease = 5;

var
	TopBorder, BottomBorder, RightBorder, LeftBorder: integer;

type
	racket = record
		x, y: integer;
	end;
	ball = record
		x, y, dx, dy: integer;
	end;

procedure GetKey(var n: integer);
var
	c: char;
begin
	c := ReadKey;
	if c = #0 then begin
		c := ReadKey;
		n := -ord(c);
	end	else begin
		n := ord(c)
	end
end;
procedure DrawLine(ch: char; n: integer);
var
	i: integer;
begin
	for i := 1 to n do
		write(ch);
end;
procedure DrawPitch;
var
	i: integer;
begin
	TextBackground(LightGray);
	GotoXY(LeftBorder - 1, TopBorder);
	DrawLine(' ', PitchWidth + 2);
	for i := 1 to PitchHeight - 2 do begin
		GotoXY(LeftBorder - 1, TopBorder + i);
		DrawLine(' ', 2);
		GotoXY(RightBorder, TopBorder + i);
		DrawLine(' ', 2);
	end;
	GotoXY(LeftBorder - 1, BottomBorder);
	DrawLine(' ', PitchWidth + 2);
	GotoXY(1, 1);
	TextBackground(Black)
end;

procedure ShowRacket(var r: racket);
var 
	i: integer;
begin
	GotoXY(r.x, r.y);
	TextBackground(Brown);
	for i := 1 to RacketWidth  do
		write(' ');
	GotoXY(1, 1);
	TextBackground(Black);
end;

procedure HideRacket(var r: racket);
var 
	i: integer;
begin
	GotoXY(r.x, r.y);
	for i := 1 to RacketWidth  do
		write(' ');
	GotoXY(1, 1);
end;

procedure MoveRacket(var r: racket; code: integer);
begin
	HideRacket(r);
	if (code = -75) and (r.x > LeftBorder + 1) then
		r.x := r.x - 2;
	if (code = -77) and (r.x + RacketWidth < RightBorder - 1) then
		r.x := r.x + 2;
	ShowRacket(r);
end;

procedure ShowBall(var b: ball);
begin
	GotoXY(b.x, b.y);
	write('O');
	GotoXY(1, 1)
end;

procedure Hideball(var b: ball);
begin
	GotoXY(b.x, b.y);
	write(' ');
	GotoXY(1, 1)
end;

procedure MoveBall(var b: ball);
begin
	HideBall(b);
	b.x := b.x + b.dx;
	b.y := b.y + b.dy;
	ShowBall(b);
end;

procedure SolveBallDirection(var b: ball; var r: racket );
var
	i: integer;
begin
	if b.x = LeftBorder + 1 then
		b.dx := -b.dx;
	if b.x = RightBorder - 1 then
		b.dx := -b.dx;
	if b.y = TopBorder + 1 then begin
		b.dy := -b.dy;
	end;
	if b.y = r.y - 1 then 
		for i := 0 to RacketWidth do
			if b.x = r.x + i then begin 
				if i < RacketWidth div 3 then 
					b.dx := -1
				else if i >= RacketWidth - RacketWidth div 3 then 
					b.dx := 1;
				b.dy := -b.dy;
				break
				end
end;

procedure AddScore(var s: integer; i: integer);
begin
	s := s + i;
	GotoXY(ScreenWidth div 2 - 5, 2);
	write('Score: ', s);
	GotoXY(1, 1)
end;


procedure GameOver(var b: ball);
var
	i, x, y: integer;
	s: array[1..10] of string;
begin
	b.dx := 0;
	b.dy := 0;
	x := RightBorder div 2;
	y := BottomBorder div 2;
	s[1] := 'GAME OVER';
	s[2] := 'Press ''R'' to restart';
	s[3] := 'Press ''Esc'' to exit';
	for i := 1 to 3 do begin
		GotoXY(x - length(s[i]) div 3, y + i);
		write(s[i])
	end;
	TextColor(White + Blink);
	TextBackground(Red);
	ShowBall(b);
	write(#27'[0m');
end;

procedure BlinkingTopBorder;
var
	i: integer;
begin
	for i := 0 to 2 do begin
		GotoXY(LeftBorder + 1, TopBorder);
		TextBackground(Green);
		DrawLine(' ', PitchWidth - 2);
		delay(50);
		GotoXY(LeftBorder + 1, TopBorder);
		TextBackground(LightGray);
		DrawLine(' ', PitchWidth - 2);
		delay(50);
	end;
	TextBackground(Black);
end;

procedure Pause(var b: ball);
var
	code,
	pdx, pdy: integer;
begin
	pdx := b.dx;
	b.dx := 0;
	pdy := b.dy;
	b.dy := 0;
	GotoXY(RightBorder div 2, BottomBorder div 2);
	write('Pause');
	GotoXY(RightBorder div 2 - 6, BottomBorder div 2 + 1);
	write('Press ''P'' to continue');
	ShowBall(b);
	repeat
		GetKey(code);
	until code = ord('p');
	GotoXY(RightBorder div 2, BottomBorder div 2);
	DrawLine(' ', 5);
	GotoXY(RightBorder div 2 - 6, BottomBorder div 2 + 1);
	DrawLine(' ', 21);
	ShowBall(b);
	b.dx := pdx;
	b.dy := pdy;
end;

label
	restart;

var
	b: ball;
	r: racket;
	code, 
	DelayDuration,
	score: integer;

begin
restart:
	clrscr;
	DelayDuration := 140;
	RightBorder := (ScreenWidth + PitchWidth) div 2 ;
	LeftBorder := (ScreenWidth - PitchWidth ) div 2 + 1;
	TopBorder := (ScreenHeight - PitchHeight) div 2 + 1;
	BottomBorder := (ScreenHeight + PitchHeight) div 2;
	r.x := RightBorder div 2 - 1;
	r.y := BottomBorder - 1;
	b.x := RightBorder - RacketWidth;
	b.y := TopBorder + 3;
	b.dx := -1;
	b.dy := 1;
	score := 0;
	AddScore(score, 0);
	DrawPitch;
	ShowBall(b);
	ShowRacket(r);
	while true do begin
		if not KeyPressed then begin
			SolveBallDirection(b, r);
			if b.y = TopBorder + 1  then begin
				if DelayDuration > 40 then
					DelayDuration := DelayDuration - DelayDecrease;
				AddScore(score, 1);
				BlinkingTopBorder
			end;
			if b.y = BottomBorder  then begin
				GameOver(b);
				break; 
			end;
			MoveBall(b);
			delay(DelayDuration);
			continue
		end;
		GetKey(code);
		if code = ord('p') then
			Pause(b);
		MoveRacket(r, code);
	end;
	repeat
		GetKey(code);
		case code of
			27: clrscr;
			ord('r') or ord('R'): goto restart;
		end;
	until (code = 27) or (code = ord('r'));
end.
