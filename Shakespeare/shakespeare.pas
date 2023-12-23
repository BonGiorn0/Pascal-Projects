program shkspr;

var
	x: char;	

begin
	writeln('opopo');
	readln();
	while not eof do begin
		read(x);
		if x <> '\n' then
			write(x)
		else begin
			write(x);
			read(x);
			readln
			end
	end
end.
