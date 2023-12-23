program SnakeTheGame;

uses crt;

type
	item = record
		x, y, amount: integer;
		color: BGColor;
		symbol: char;
	end;

	SnakeSegmentPtr: ^SnakeSegment;
	SnakeSegment = record
		x, y, dx, dy: integer;
		BodyColor: BGColor;
		pattern: char;
		PatternColor: AllColors;
		next: SnakeSegmentPtr
	end;

	QueueOfSnakeSegments = record 
		first, last: SnakeSegmentPtr;
	end;

procedure QOSSInit();
begin
end;

procedure QOSSPut();
begin
end;

function SnakeCollidesObstackle(var snake: QueueOfSnakeSegments;
   								var obstackle: item): boolean;
begin
	for i := 1 to obstackle.amount do begin
		if snake.x = obstackle[i].x and
		snake.y = obstackle[i].y then begin
			SnakeCollidesObstackle := true;
			exit
		end;
	end;
	SnakeCollidesObstackle := false
end;

var
	snake: QueueOfSnakeSegments;
	ChosenMap: text;
	obstackle, apple, portal: array[1..80 * 25] of item;


begin
	while true do begin
		repeat
			GetKey(code);
		until (code < 1) and (code > 9);
		assign(ChosenMap, Map[code]);
		DrawMap(ChosenMap);
		DefineItems(obstackle, apple, portal);
		ShowSnake(snake);
		while true do begin
			if not KeyPressed then begin
				MoveSnake(snake);
				if SnakeCollidesObstackle(snake, obstackle) then begin
					GameOverScreen;
					break;
				end;
			end;
			GetKey(code);
			case code of
				-72 or -75 or -77 or -80: SetSnakeDirection(code);
				ord('p') or ord('P'): Pause;
			end
		end;
	end;
end.
