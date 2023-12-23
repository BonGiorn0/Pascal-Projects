program quad;

function ReadNumber(var result : real): boolean;
var
	c: char;
	res: real;
	pos: integer;
begin
	res := 0;
	pos := 0;
	repeat
		read(c);
		pos := pos + 1;
	until (c <> ' ') and (c <> #10);
	while (c <> ' ') and (c <> #10) do begin
		if (c < '0') or (c > '9') then begin
			writeln('Unexpected "', c,'" in pos: ', pos);
			readln;
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

function quadratic(a,b,c: real; var x1,x2: real): boolean;
var
	d:real;
begin
	if a = 0 then begin
		quadratic := false;
		exit;
	end;
	d := b*b - 4*a*c;
	if d < 0 then begin 
		quadratic := true;
		exit;
	end;
	d := sqrt(d);
	x1 := (-b - d) / (2 * a);
	x2 := (-b + d) / (2 * a);
	quadratic := true;
end;

var
	a,b,c,x1,x2: real;
	ok: boolean;
begin 
	writeln('This progrgram solves quadratic equasions: ax^2 + bx + c');
	repeat
		write('Enter an "a" coefficient: ');
		ok := ReadNumber(a);
	until ok;
	repeat
		write('Enter an "b" coefficient: ');
		ok := ReadNumber(b);
	until ok;
	repeat
		write('Enter an "c" coefficient: ');
		ok := ReadNumber(c);
	until ok;
	if not  quadratic(a,b,c,x1,x2) then begin
		writeln('Equasion is not quadratic!');
		exit;
	end;
	if x1 = 0  then begin
		writeln('The equasion doesn', #39, 't have rational solutions.');
		exit;
	end;
	writeln('The roots are ', x1:5:3, ' and ', x2:5:3);

end.
