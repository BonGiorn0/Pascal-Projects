program SnakeTheGame;

uses crt;

const
	MaxSquare = 80 * 25;

type
	SnakeSegmentPtr: ^SnakeSegment;
	SnakeSegment = record
		x, y, dx, dy: integer;
		{BodyColor: BGColor;
		pattern: char;
		PatternColor: AllColors;
		next: SnakeSegmentPtr}
	end;

	QueueOfSnakeSegments = record 
		head, last: SnakeSegmentPtr;
	end;

type
	MapItem = record
		IsObstackle: boolean;
		IsApple: boolean;
		IsPortal: boolean;
		x, y: integer;
	end;

	ArrayOfMapItem = array[0..MaxSquare] of MapItem;

procedure QOSSInit(var snake: QueueOfSnakeSegments);
begin
	snake.head := nil;
	snake.tail := head;
end;

procedure QOSSPut(var snake: QueueOfSnakeSegments; x, y, dx, dy: integer);
begin
	if snake.head = nil then begin
		new(snake.head);
		snake.tail := snake.head
	end else begin
		new(snake.tail^.next);
		snake.tail := snake.tail^.next
	end;
	snake.tail^.x := x;
	snake.tail^.y := y;
	snake.tail^.dx := dx;
	snake.tail^.dy := dy

end;

procedure ShowSnake(var snake: QueueOfSnakeSegments);
var
	tmp: SnakeSegmentPtr;
begin
	tmp := snake.head;
	while tmp <> nil do begin
		GotoXY(snake.tmp^.x, snake.tmp^.y);
		write('0');
		tmp := tmp.next
	end;
end;

procedure HideSnake(var snake: QueueOfSnakeSegments);
var
	tmp: SnakeSegmentPtr;
begin
	tmp := snake.head;
	while tmp <> nil do begin
		GotoXY(snake.tmp^.x, snake.tmp^.y);
		write(' ');
		tmp := tmp.next
	end;
end;

procedure MoveSnake(var snake: QueueOfSnakeSegments);
var
	tmp: SnakeSegmentPtr;
begin
	HideSnake(s);
	tmp := snake.head;
	while tmp <> nil do begin
		snake.tmp^.x := snake.tmp^.x + snake.tmp^.dx;
		snake.tmp^.y := snake.tmp^.y + snake.tmp^.dy;
		tmp := tmp.next
	end;
	ShowSnake(s);
end;

procedure SetSnakeDirection(var snake: QueueOfSnakeSegments, code: integer);
begin
	if code = -80 then begin
		snake.head^.dx := 0;
		snake.head^.dy := -1;
		exit
	end;
	if code = -72 then begin
		snake.head^.dx := 0;
		snake.head^.dy := 1;
		exit
	end;
	if code = -77 then begin
		snake.head^.dx := 1;
		snake.head^.dy := 0;
		exit
	end;
	if code = -75 then begin
		snake.head^.dx := -1;
		snake.head^.dy := 0;
		exit
	end;
	
end;

function SnakeCollidesObstackle(var snake: QueueOfSnakeSegments;
	var item: ArrayOfMapItem): boolean;
begin
	for i := 1 to MaxSqure do begin
		if item[i].IsObstackle and 
		snake.head^.x = item[i].x and
		snake.head^.y = item[i].y then begin
			SnakeCollidesObstackle := true;
			exit
		end;
	end;
	SnakeCollidesObstackle := false
end;

procedure MainGame(var snake: QueueOfSnakeSegments; var item: MapItem);
begin
	while true do begin
		if not KeyPressed then begin
			MoveSnake(snake);
			if SnakeCollidesObstackle(snake, item) then begin
				GameOverScreen;
				exit;
			end;
		end;
		GetKey(code);
		SetSnakeDirection(code);
	end;
end;

procedure 

var
	snake: QueueOfSnakeSegments;
	item: ArrayOfMapItem;

begin
	clrscr;
	for i := 0 to 80 do
		for j := 0 to 25 do begin
			item[j + i * 80].IsObject := false;	
			item[j + i * 80].x := i + 1;	
			item[j + i * 80].y := j + 1;	
		end;
	for i := 0 to 80 do
		item[i].IsObject := true;

	for i := 80 * 24 to 80 * 25 do
		item[i].IsObject := true;
	DrawObjects(item);
			

	while true do begin
		QOSSInit(s);
		for i := 0 to 4 do
			QOSSPut(snake, ScreenWidth div 2 - i, Screenheight, 0, 0);
		end;
		MainGame(snake);
		GetKey(code);
		if code = ord('r') then
			continue
		else
			break
	end;
	clrscr;
end.
