
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

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat localize "str_FIR_ITGT_AIRCRAFT_WARN";};
if (ctrlShown ((findDisplay 5581) displayCtrl 3620)) exitWith {systemChat localize "str_FIR_ITGT_NOT_LIST"};

_lb_tgt_ctrl = (findDisplay 5581) displayCtrl 1501;
_tgt_cursel = lbCurSel _lb_tgt_ctrl;
_tgt_data = _lb_tgt_ctrl lbData _tgt_cursel;

_gps_array = _plane getVariable "AWS_ITGT_GPS_ARRAY";
_tgt_array = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
_tgt_path = [_tgt_array,_tgt_data] call BIS_fnc_findNestedElement;
_tgt_selected_path = _tgt_path select 0;

_tgt_index = ((_tgt_array select _tgt_selected_path)select 0);
_tgt_id_get = ((_tgt_array select _tgt_selected_path)select 1); 
_tgt_pos = ((_tgt_array select _tgt_selected_path)select 2);
_mkr_id = ((_tgt_array select _tgt_selected_path)select 3);
_mkr_local = ((_tgt_array select _tgt_selected_path)select 4); 

_check = [_gps_array, _tgt_id_get] call BIS_fnc_findAllNestedElements;

if (_check isEqualTo []) then
{
	if (_mkr_local isEqualTo "global") then
	{
		deleteMarker _mkr_id;	
	}
	else
	{
		deleteMarkerLocal _mkr_id;	
	};

	_tgt_array deleteAt _tgt_selected_path;
	_plane setVariable ["AWS_ITGT_GPS_TGTLIST",_tgt_array];
	_lb_tgt_ctrl lbDelete _tgt_cursel;
	systemChat localize "str_FIR_ITGT_DEL_DONE";	
}
else
{
	systemChat localize "str_FIR_ITGT_DEL_FAIL";
};




