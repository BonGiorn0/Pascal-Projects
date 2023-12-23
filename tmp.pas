program prg;

type
	itemptr = ^item;
	item = record
		data: integer;
		next: itemptr;
	end;	

var
	n: integer;
	first, tmp, last: itemptr;

begin
	first := nil;
	last := first;
	while not SeekEof do begin
		read(n);
		if first = nil then begin
			new(first);
			last := first;
			last^.data := n;
			last^.next := nil;
			continue
		end;
		new(last^.next);
		last := last^.next;
		last^.data := n;
		last^.next := nil;
	end;
	writeln('---');
	tmp := first;
	while tmp <> nil do begin
		writeln(tmp^.data);
		writeln(tmp^.data);
		tmp := tmp^.next
	end;
end.
