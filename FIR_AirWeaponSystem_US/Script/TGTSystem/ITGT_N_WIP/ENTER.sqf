private _plane = "";
private _planetype = "";

private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only

		_plane = _UAV;	
		_plane_pilot = player;		
};

_planetype = typeof _plane;

disableSerialization;
_mydisplay = findDisplay 5581;

_grid_edit = (findDisplay 5581) displayCtrl 1400;

_grid = ctrlText _grid_edit;

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat localize "str_FIR_ITGT_AIRCRAFT_WARN";};
if (ctrlShown ((findDisplay 5581) displayCtrl 1202)) exitWith {systemChat localize "str_FIR_ITGT_NOT_MAP"};

_gridarray = toArray(_grid);
_grid_1_last = "";
_grid_2_last = "";
_grid_1_last_10d = "";
_grid_2_last_10d = "";
_grid1 = "";
_grid2 = "";
_tgt_grid = [];

_check = "no";
systemChat format ["%1",count _gridarray];
_ary_c = count _gridarray;

if (_ary_c isEqualTo 8) then
{
	for [{_i=0}, {_i<3}, {_i=_i+1}] do
	{
		_grid1 = _grid1 + toString([_gridarray select _i]);
	};

	for [{_i=4}, {_i<7}, {_i=_i+1}] do
	{
		_grid2 = _grid2 + toString([_gridarray select _i]);
	};

	_grid1 = _grid1 call BIS_fnc_parseNumber;
	_grid2 = _grid2 call BIS_fnc_parseNumber;
	_grid1 = _grid1 * 100;
	_grid2 = _grid2 * 100;

	_grid_1_last = toString([_gridarray select 3]);
	_grid_2_last = toString([_gridarray select 7]);
	_grid_1_last = _grid_1_last call BIS_fnc_parseNumber;
	_grid_2_last = _grid_2_last call BIS_fnc_parseNumber;
	_grid_1_last = _grid_1_last * 10;
	_grid_2_last = _grid_2_last * 10;

	_grid1 = _grid1 + _grid_1_last;
	_grid2 = _grid2 + _grid_2_last;

	_tgt_grid = [_grid1,_grid2];
	_check = "yes";
}
else
{
	if (_ary_c isEqualTo 10) then
	{
		for [{_i=0}, {_i<3}, {_i=_i+1}] do
		{
			_grid1 = _grid1 + toString([_gridarray select _i]);
		};

		for [{_i=5}, {_i<8}, {_i=_i+1}] do
		{
			_grid2 = _grid2 + toString([_gridarray select _i]);
		};

		_grid1 = _grid1 call BIS_fnc_parseNumber;
		_grid2 = _grid2 call BIS_fnc_parseNumber;
		_grid1 = _grid1 * 100;
		_grid2 = _grid2 * 100;

		_grid_1_last = toString([_gridarray select 3]);
		_grid_2_last = toString([_gridarray select 8]);
		_grid_1_last = _grid_1_last call BIS_fnc_parseNumber;
		_grid_2_last = _grid_2_last call BIS_fnc_parseNumber;
		_grid_1_last = _grid_1_last * 10;
		_grid_2_last = _grid_2_last * 10;

		_grid1 = _grid1 + _grid_1_last;
		_grid2 = _grid2 + _grid_2_last;
		
		_grid_1_last_10d = toString([_gridarray select 4]);
		_grid_2_last_10d = toString([_gridarray select 9]);
		_grid_1_last_10d = _grid_1_last_10d call BIS_fnc_parseNumber;
		_grid_2_last_10d = _grid_2_last_10d call BIS_fnc_parseNumber;

		_grid1 = _grid1 + _grid_1_last_10d;
		_grid2 = _grid2 + _grid_2_last_10d;
		
		_tgt_grid = [_grid1,_grid2];
		_check = "yes";
	}
	else
	{
		systemChat localize "str_FIR_ITGT_ENTER_DIGITS_ERROR";
	};
};



if (_check == "no") exitWith {systemChat localize "str_FIR_ITGT_ENTER_DIGITS_ERROR"};

systemChat localize "str_FIR_ITGT_ENTER_CONVERT";

private _index = _plane getVariable ["AWS_ITGT_GPS_TGTLIST_INDEX",0];
private _tgt_list = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
// element structure [index,tgtID,tgtpos,markerID,haslock];

private _tgt_id = format ["TGT_%1_%2",_index,(name player)];
private _marker_id = format ["MKR_%1_%2",_index,(name player)];

private _default_marker = createMarkerLocal [_marker_id, [0,0]];
_default_marker setMarkerColorLocal "ColorBlue";
_default_marker setMarkerShapeLocal "ICON";
_default_marker setMarkerSizeLocal [0.8,0.8];
_default_marker setMarkerTypeLocal "mil_triangle";
_default_marker setMarkerTextLocal _marker_id;
_default_marker setMarkerAlphaLocal 1;
_default_marker setMarkerPosLocal _tgt_grid;	

private _element = [_index,_tgt_id,_tgt_grid,_marker_id,"local"];
_tgt_list pushBack _element;	
_index = _index + 1;

_plane setVariable ["AWS_ITGT_GPS_TGTLIST",_tgt_list,true];
_plane setVariable ["AWS_ITGT_GPS_TGTLIST_INDEX",_index,true];
	
systemChat format [localize "str_FIR_ITGT_POI_UPDATED",_tgt_id];




// _nan = round(random 10000);

	// Switch (_slotcheck) do
	// {
		// case 1:
		// {
			// _marker_v = _plane getvariable "ITGT_MARKER_1";
			// if (_marker_v == "none") then
			// {
			// }
			// else
			// {
				// deleteMarkerLocal _marker_v;
			// };
			// _mn = format["%1_default_slot_marker",_nan];			
			// _default_marker = createMarkerLocal [_mn, [0,0]];
			// _default_marker setMarkerColorLocal "ColorBlue";
			// _default_marker setMarkerShapeLocal "ICON";
			// _default_marker setMarkerSizeLocal [0.8,0.8];
			// _default_marker setMarkerTypeLocal "mil_triangle";
			// _default_marker setMarkerTextLocal "TGT POS 1";
			// _default_marker setMarkerAlphaLocal 1;
			// _default_marker setMarkerPosLocal _tgt_grid;	
			// _plane setVariable ["ITGT_MARKER_1",_default_marker,true];		
		
			// systemChat"SYSTEM : SLOT 1 SAVED";	
			// _plane setvariable ["ITGT_DATA_1",_tgt_grid,true];

		// };
		// case 2:
		// {
			// _marker_v = _plane getvariable "ITGT_MARKER_2";
			// if (_marker_v == "none") then
			// {
			// }
			// else
			// {
				// deleteMarkerLocal _marker_v;
			// };
			// _mn = format["%1_default_slot_marker",_nan];			
			// _default_marker = createMarkerLocal [_mn, [0,0]];
			// _default_marker setMarkerColorLocal "ColorBlue";
			// _default_marker setMarkerShapeLocal "ICON";
			// _default_marker setMarkerSizeLocal [0.8,0.8];
			// _default_marker setMarkerTypeLocal "mil_triangle";
			// _default_marker setMarkerTextLocal "TGT POS 2";
			// _default_marker setMarkerAlphaLocal 1;
			// _default_marker setMarkerPosLocal _tgt_grid;	
			// _plane setVariable ["ITGT_MARKER_2",_default_marker,true];		
		
			// systemChat"SYSTEM : SLOT 2 SAVED";	
			// _plane setvariable ["ITGT_DATA_2",_tgt_grid,true];

		// };
		// case 3:
		// {
			// _marker_v = _plane getvariable "ITGT_MARKER_3";
			// if (_marker_v == "none") then
			// {
			// }
			// else
			// {
				// deleteMarkerLocal _marker_v;
			// };
			// _mn = format["%1_default_slot_marker",_nan];			
			// _default_marker = createMarkerLocal [_mn, [0,0]];
			// _default_marker setMarkerColorLocal "ColorBlue";
			// _default_marker setMarkerShapeLocal "ICON";
			// _default_marker setMarkerSizeLocal [0.8,0.8];
			// _default_marker setMarkerTypeLocal "mil_triangle";
			// _default_marker setMarkerTextLocal "TGT POS 3";
			// _default_marker setMarkerAlphaLocal 1;
			// _default_marker setMarkerPosLocal _tgt_grid;	
			// _plane setVariable ["ITGT_MARKER_3",_default_marker,true];		
		
			// systemChat"SYSTEM : SLOT 3 SAVED";	
			// _plane setvariable ["ITGT_DATA_3",_tgt_grid,true];

		// };
		// case 4:
		// {
			// _marker_v = _plane getvariable "ITGT_MARKER_4";
			// if (_marker_v == "none") then
			// {
			// }
			// else
			// {
				// deleteMarkerLocal _marker_v;
			// };
			// _mn = format["%1_default_slot_marker",_nan];			
			// _default_marker = createMarkerLocal [_mn, [0,0]];
			// _default_marker setMarkerColorLocal "ColorBlue";
			// _default_marker setMarkerShapeLocal "ICON";
			// _default_marker setMarkerSizeLocal [0.8,0.8];
			// _default_marker setMarkerTypeLocal "mil_triangle";
			// _default_marker setMarkerTextLocal "TGT POS 4";
			// _default_marker setMarkerAlphaLocal 1;
			// _default_marker setMarkerPosLocal _tgt_grid;	
			// _plane setVariable ["ITGT_MARKER_4",_default_marker,true];		
		
			// systemChat"SYSTEM : SLOT 4 SAVED";	
			// _plane setvariable ["ITGT_DATA_4",_tgt_grid,true];

		// };
		// case 5:
		// {
			// _marker_v = _plane getvariable "ITGT_MARKER_5";
			// if (_marker_v == "none") then
			// {
			// }
			// else
			// {
				// deleteMarkerLocal _marker_v;
			// };
			// _mn = format["%1_default_slot_marker",_nan];			
			// _default_marker = createMarkerLocal [_mn, [0,0]];
			// _default_marker setMarkerColorLocal "ColorBlue";
			// _default_marker setMarkerShapeLocal "ICON";
			// _default_marker setMarkerSizeLocal [0.8,0.8];
			// _default_marker setMarkerTypeLocal "mil_triangle";
			// _default_marker setMarkerTextLocal "TGT POS 5";
			// _default_marker setMarkerAlphaLocal 1;
			// _default_marker setMarkerPosLocal _tgt_grid;	
			// _plane setVariable ["ITGT_MARKER_5",_default_marker,true];		
		
			// systemChat"SYSTEM : SLOT 5 SAVED";	
			// _plane setvariable ["ITGT_DATA_5",_tgt_grid,true];

		// };
	// };
