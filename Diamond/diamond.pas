program diamond;

procedure PrintSpaces(x:integer; ch:char);
begin
	if x >= 0 then begin
		PrintSpaces(x - 1, ch);
		write(ch);
		
	end;
end;

procedure PrintLineOfDiamond(k, n:integer; och, ich:char);
begin
	PrintSpaces(n - k, ' ' );
	write(och);
	if k > 0 then begin
		PrintSpaces(2*k - 2, ich);
		write(och);
	end;
	writeln;
end;

var
	halfHeight, height, k: integer;
	outerCh, innerCh: char;

begin
	repeat
		write('Enter the height of a diamond(positive odd): ');
		readln(height);
	until (height > 0) and (height mod 2 = 1);
	write('Enter a char of the frame of the diamond: ');
	readln(outerCh);
	write('Enter a inner char of the diamond: ');
	readln(innerCh);
	halfHeight := height div 2;
	writeln;
	for k:= 0 to halfHeight do 
		PrintLineOfDiamond(k,halfHeight, outerCh, innerCh);
	for k:= halfHeight - 1 downto 0 do 
		PrintLineOfDiamond(k,halfHeight, outerCh, innerCh);

end.
