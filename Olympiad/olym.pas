program olymp;

const 
	MaxSchool = 62;
	MaxGroup = 100;
type
	CountersArray = array[-2..MaxSchool] of integer;
var
	n,i,c: integer;
	counter: CountersArray;
begin
	for i := 0 to MaxSchool do
		counter[i] := 0;
	{$I-}
	while not eof do begin 
		readln(c); 	
		if IOResult <> 0 then begin
			writeln('Incorrect data');
			halt(1);
		end;
		n := c div MaxGroup;
		if (n < 1) or (n > MaxSchool) then begin
			writeln('Illegal school id: ', n, '[', c, ']');
			halt(1);
		end;
		counter[n] := counter[n] + 1;
	end;
	n := 1;
	for i := 1 to MaxSchool do 
		if counter[i] > counter[n] then 
			n := i;
	for i := 1 to MaxSchool do
		if counter[i] = counter[n] then
			write(i, ' ');
	writeln;
	writeln(counter[-2]); 
end.

