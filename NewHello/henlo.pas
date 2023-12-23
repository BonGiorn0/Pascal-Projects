program henlo;
uses crt;
const
	Message =
		'Hello fullscreen world!';
	DelayDuration = 5000;

procedure WriteMessage(x,y:integer; msg: string);
begin
	GotoXY(x,y);
	write(msg);
	GotoXY(1,1)
end;

procedure EraseMessage(x,y:integer; msg: string);
var
	l, i: integer;
begin
	GotoXY(x,y);
	l := length(msg);
	for i := 1 to l do
		write(' ');
	GotoXY(1,1)
end;

procedure MoveMessage(var x,y: integer; msg: string; dx,dy: integer);
begin
	EraseMessage(x ,y, msg);
	x := x + dx;
	if x > ScreenWidth then
		x := 1;
	if x < 1  then
		x := ScreenWidth;
	y := y + dy;
	if y > ScreenHeight then
		y := 1;
	if y < 1 then
		y := ScreenHeight;
	WriteMessage(x, y, msg)
end;

var 
	CurrentX,CurrentY:integer;
	ch: char;
begin
	clrscr;
	CurrentX := (ScreenWidth - length(Message)) div 2;
	CurrentY := ScreenHeight div 2;
	WriteMessage(CurrentX, CurrentY, Message);
	while true do begin
		ch := ReadKey;
		if ch <> #0 then
			break;
		ch := ReadKey;
		case ch of
			#75:
				MoveMessage(CurrentX, CurrentY, Message, -1, 0);
			#77:
				MoveMessage(CurrentX, CurrentY, Message, 1, 0);
			#72:
				MoveMessage(CurrentX, CurrentY, Message, 0, -1);
			#80:
				MoveMessage(CurrentX, CurrentY, Message, 0, 1);
		end;
	end;
	clrscr;
end.


