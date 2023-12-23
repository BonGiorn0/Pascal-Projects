program prg;

type
	itemptr = ^item;
	item = record
		data: integer;
		next: itemptr;
	end;	

var
	n: integer;
	first, tmp: itemptr;

begin
	first := nil;
	while not SeekEof do begin
		read(n);
		new(tmp);
		tmp^.data := n;
		tmp^.next := first;
		first := tmp
	end;
	writeln('---');
	tmp := first;
	while tmp <> nil do begin
		writeln(tmp^.data);
		tmp := tmp^.next
	end;
	dispose(first);
	dispose(tmp);
end.
