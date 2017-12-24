program SortVisualizer;
uses SwinGame, SysUtils, sgTypes;

type
	DataArray = array [0..20] of integer;

var
	i : Integer;

procedure ShowNumbersInList(var data : DataArray);
var
	i : integer;

begin
	ListClearItems('NumbersList');

	For i := Low(data) to High(data) do 
	begin
		ListAddItem('NumbersList', IntToStr(data[i]));
	end;
end;


procedure PopulateArray(var data : DataArray);
var
	i : integer;

begin
	for i:= Low(data) to High(data) do
	begin
		data[i] := Rnd(ScreenHeight());
	end;
end;

procedure PlotBars(var data : DataArray);
var
	i, x, y, graphWidth : integer;

begin
	ClearScreen(ColorWhite);
	graphWidth := Round((ScreenWidth() - PanelWidth('NumberPanel')) / Length(data));

	for i:= Low(data) to High(data) do
	begin
		x := i * graphWidth;
		y := ScreenHeight - data[i];
		FillRectangle(ColorRed, x, y, graphWidth, data[i]);
		x += graphWidth;
	end;

	DrawInterface();
	RefreshScreen(60);
end;


procedure Swap(var v1 : integer; var v2 : integer);
var
	store : integer;

begin
	store := v1;
	v1 := v2;
	v2 := store;
end; 





procedure BubbleSort(var data : DataArray);
var
	i, j : integer;

begin
	For i := Low(data) to High(data) do
	begin
		For j := Low(data) to High(data) do
		begin
			if data[i] < data[(j)] then
			begin
					Swap(data[i], data[(j)]);
					PlotBars(data);
					Delay(30);
			end;
		end;
	end;
end;


procedure GnomeSort(var data: DataArray);
var
  I, J: Integer;
 
begin
  	I:= Low(data) + 1;
  	J:= Low(data) + 2;
  	while I <= High(data) do 
  		begin
    		if data[I - 1] <= data[I] then begin
	      		I:= J;
	      		J:= J + 1;
	    		end
		    else 
			    begin
				      Swap(data[I - 1], data[I]);
					  PlotBars(data);
					  Delay(30);
				      I:= I - 1;
				      if I = Low(data) then 
				      begin
				        I:= J;
				        J:= J + 1;
				      end;
			    end;

 		 end;
end;


procedure DoSort(i : Integer);
var
data : DataArray;
begin
	PopulateArray(data);
	ShowNumbersInList(data);
	PlotBars(data);

if (i mod 2 = 0) then
     BubbleSort(data)
else
     GnomeSort(data);
end;








begin
  OpenGraphicsWindow('Sort Visualiser', 800, 600);
  
  LoadResourceBundle( 'NumberBundle.txt' );
  
  GUISetForegroundColor( ColorBlack );
  GUISetBackgroundColor( ColorWhite );
  ShowPanel( 'NumberPanel' );
  ClearScreen(ColorWhite);
  i := 0;
  Repeat
  	ProcessEvents();
  	UpdateInterface();
  	DrawInterface();
  	RefreshScreen(60);
  		if ButtonClicked('SortButton') then
  		begin
  			DoSort(i);
  			i := i + 1;
  		end;

  Until WindowCloseRequested();

  
  Delay(1000);
end.
