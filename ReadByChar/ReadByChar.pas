program ReadByChar;
function ReadNumber(var result : longint): boolean;
var
	c: char;
	res:longint;
	pos: integer;
begin
	res := 0;
	pos := 0;
	repeat
		read(c);
		pos := pos + 1;
		{writeln(pos);}
	until (c <> ' ') and (c <> #10);
	while (c <> ' ') and (c <> #10) do begin
		if (c < '0') or (c > '9') then begin
			writeln('Unexpected "', c,'" in pos: ', pos);
			ReadNumber := false;
			exit;
		end;
		res := res*10 + ord(c) - ord('0');
		read(c);
		pos := pos + 1;
	end;
	result := res;
	ReadNumber := true;
end;

var
  	x: longint;
	ok: boolean;
begin
	repeat
		ok := ReadNumber(x)
	until ok;
	writeln(x);
end.
