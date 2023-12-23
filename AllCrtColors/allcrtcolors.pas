program AllCrtColors;
uses crt;
const
	ColorCount = 16;
	BGColorCount = 8;
var
	AllColors: array[0..15] of word =
	(
		Black, Blue, Green, Cyan,
		Red, Magenta, Brown, LightGray,
		DarkGray, LightBlue, LightGreen, LightCyan,
		LightRed, LightMagenta, Yellow, White
	);

procedure MakeLine(row: integer; fgcolor: word);
var
	RowIsOdd, i, w, cw: integer;
begin
	w := ScreenWidth;
	cw := w div BGColorCount;
	if cw = 0 then
		cw := 1;
	if row = ScreenHeight then
		w := w - 1;
	for i := 1 to w do begin
		GotoXY(i, row);
		TextBackground(AllColors[(i - 1) div cw] );
		RowIsOdd := row mod 2 ;
		if i mod 2 = 0 then
			TextColor(fgcolor + Blink * (RowIsOdd - 1))
		else
			TextColor(fgcolor + Blink * RowIsOdd);
		write('*');
	end
end;

procedure MakeScreen;
var
	i: integer;
begin
	for i := 1 to ScreenHeight do
		Makeline(i, AllColors[(i - 1) mod ColorCount]);
end;

begin
	clrscr;
	MakeScreen;
	readln;
	write(#27'[0m');
	clrscr;
end.
