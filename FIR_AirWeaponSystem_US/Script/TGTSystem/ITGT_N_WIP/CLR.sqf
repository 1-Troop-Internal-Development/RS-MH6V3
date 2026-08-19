
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

_lb_pylon_ctrl = (findDisplay 5581) displayCtrl 1500;
_pylon_cursel = lbCurSel _lb_pylon_ctrl;

if (_pylon_cursel isEqualTo -1) exitWith {systemChat localize "str_FIR_ITGT_CLR_SELECT_CHECK";};

systemChat localize "str_FIR_ITGT_CLR_MSG";

_pylon_value = _lb_pylon_ctrl lbData _pylon_cursel;
_gps_array = _plane getVariable "AWS_ITGT_GPS_ARRAY";
_pylon_path = [_gps_array, _pylon_value] call BIS_fnc_findNestedElement;
_pylon_selected_path = _pylon_path select 0;

_pylon_code = ((_gps_array select _pylon_selected_path)select 0);
_pylon_num = ((_gps_array select _pylon_selected_path) select 1);
_pylon_ammo_count = ((_gps_array select _pylon_selected_path) select 2);
_wep_name = ((_gps_array select _pylon_selected_path) select 3);
_tgt_id = ((_gps_array select _pylon_selected_path) select 4);
_islock = ((_gps_array select _pylon_selected_path) select 5);
_mode = ((_gps_array select _pylon_selected_path) select 6);

_tgt_array = _plane getVariable "AWS_ITGT_GPS_TGTLIST";
_tgt_path = [_tgt_array,_tgt_id] call BIS_fnc_findNestedElement;
_tgt_selected_path = _tgt_path select 0;

_mkr_id = ((_tgt_array select _tgt_selected_path)select 3);
_mkr_local = ((_tgt_array select _tgt_selected_path)select 4);

if (_mkr_local isEqualTo "global") then
{
	_mkr_id setMarkerColor "ColorBlue";
}
else
{
	_mkr_id setMarkerColorLocal "ColorBlue";
};


uiSleep 0.003;

_gps_array set [_pylon_selected_path,[_pylon_code,_pylon_num,_pylon_ammo_count,_wep_name,"",false,_mode]];
_plane setVariable ["AWS_ITGT_GPS_ARRAY",_gps_array,true];
