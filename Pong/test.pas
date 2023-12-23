program test;
uses crt;
var
	i, j: integer;
begin
	clrscr;
	write('+');
	for i := 1 to 45 do
		write('#');
	writeln('+');
	for i := 1 to 15 - 2 do begin
		write('#');
		for j := 1 to 45  do 
			write(' ');
		writeln('#')
	end;
	write('+');
	for i := 1 to 45 do
		write('#');
	writeln('+');
	readln;
	clrscr;
end.
