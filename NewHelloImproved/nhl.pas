program henlo;
uses crt;
const
	Message =
		'Hello fullscreen world!';
	MessageLength = length(Message);

procedure WriteChar(x,y:integer; ch: char);
begin
	GotoXY(x,y);
	write(ch);
	GotoXY(1,1)
end;

procedure EraseChar(x,y:integer);
begin
	GotoXY(x,y);
	write(' ');
	GotoXY(1,1)
end;

function CalcX(x, dx: integer): integer;
begin
	x := x + dx;
	if x > ScreenWidth then
		x := x - ScreenWidth;
	if x < 1  then
		x := ScreenWidth;
	CalcX := x;
end;

function CalcY(y, dy: integer): integer;
begin
	y := y + dy;
	if y > ScreenHeight then
		y := y - ScreenHeight;
	if y < 1 then
		y := ScreenHeight;
	CalcY := y;
end;

procedure MoveMessage(var x,y: integer; msg: string; dx,dy: integer);
var
	i: integer;
begin
	x := CalcX(x, dx);
	y := CalcY(y, dy);
	if dx > 0 then begin
		for i := 1 to MessageLength do 
			EraseChar(CalcX(x, i - dx), CalcY(y, -dy));	
		for i := 1 to MessageLength do 
			WriteChar(CalcX(x, i), y, msg[i]);
		exit
	end; 
	for i := MessageLength downto 1 do
		EraseChar(CalcX(x, i - dx), CalcY(y, -dy));	
	for i := MessageLength downto 1 do 
		WriteChar(CalcX(x, i), y, msg[i])
end;

var
	CurrentX, CurrentY, i:integer;
	ch: char;
begin
	clrscr;
	CurrentX := (ScreenWidth - length(Message)) div 2;
	CurrentY := ScreenHeight div 2;
	for i := 1 to MessageLength do 
		WriteChar(CurrentX + i, CurrentY, Message[i]);
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


