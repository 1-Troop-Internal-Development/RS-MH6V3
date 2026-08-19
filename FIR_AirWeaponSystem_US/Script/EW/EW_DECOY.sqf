/*
AWS EW "HIRIS" - HIgh-risk Radar Interupt System 
creates Radar decoy on jammer position randomly.
its give high risk to jammer but give more jamming time and less cool-time than LORIS - LOw-risk Radar Interupt System.

by Firewill
*/
private ["_jammerpos","_r","_ew_marker","_ew_marker_t","_randompos","_randompos_wp","_wp","_decoy_ary","_ary_count","_decoy_select","_decoy","_pylon","_pylon_c","_jammer_c","_ary_init","_alt","_range","_sleep_time","_cooltime"];

_plane = vehicle player;
_pilot = driver _plane;
_planetype = typeof _plane;
_sleep_time = 60;
_cooltime = 60;

if (not(_plane iskindof "Plane") and not(_plane isKindOf "Helicopter")) ExitWith {player vehiclechat "You Must get in the Aircraft!";};

_alt = _plane getVariable ["AWS_EW_ALT",2000];
_range = _plane getVariable ["AWS_EW_RANGE",1500];
_active = _plane getVariable "AWS_EW_ACTIVE";

if (_active == "yes") exitWith {_plane vehicleChat "ERROR: JAMMING ON PROGRESS.";};

_jammerpos = getpos _plane;
_r = random 9999;
_ew_marker_t = "EW_MARKER" + str(_r);
_decoy_ary = [];

_mydisplay = findDisplay 5590;
_decoy_ctrl = _mydisplay displayCtrl 2100;

_cursel = _decoy_ctrl lbdata (lbCurSel _decoy_ctrl);

_pylon = getPylonMagazines _plane;
_pylon_c = count _pylon;
_jammer_c = 0;
_ary_init = 2;

_plane setVariable ["AWS_EW_ACTIVE","yes",true];

for "_i" from 0 to _pylon_c-1 do
{
	_mag = _pylon select _i;
	_ecm = getNumber (configFile >> "CfgMagazines" >> _mag >> "AWS_ECMJAMMER");

	if (_ecm == 1) then
	{
		_jammer_c = _jammer_c + 1;
		_sleep_time = _sleep_time + 30;
		_cooltime = _cooltime - 10;
	};
}; 

_ary_init = _ary_init + _jammer_c;

_plane vehicleChat format ["SYSTEM: JAMMING INITIATED. TYPE : HIRIS. TIME : %1 sec",_sleep_time];
_ew_marker = createMarker [_ew_marker_t, _plane];
for "_i" from 0 to _ary_init do 
{ 
	_randompos = [_ew_marker_t,_range] call BIS_fnc_randomPosTrigger;
	_decoy = createVehicle [_cursel, [(_randompos select 0), (_randompos select 1), _alt], [], 0, "FLY"];
	createVehicleCrew _decoy;

	_decoy_ary pushBack _decoy;
	 
	 _randompos_wp = [_ew_marker_t,_range ] call BIS_fnc_randomPosTrigger;
	 _wp =(group _decoy) addWaypoint [_randompos_wp, 300];
	 [(group _decoy), 1] setWaypointType "HOLD";
 };
 
 sleep _sleep_time;
 
 _ary_count = count _decoy_ary;
 
 for "_j" from 0 to _ary_count-1 do
 {
 _decoy_select = _decoy_ary select _j;
 deletevehicle _decoy_select;
{_decoy_select deleteVehicleCrew _x} forEach crew _decoy_select;
 
 };
 
_plane vehicleChat format ["SYSTEM: JAMMING COMPLETED. COOLTIME ON PROGRESS. COOLTIME : %1 sec",_cooltime];

sleep _cooltime;

_plane setVariable ["AWS_EW_ACTIVE","no",true];
_plane vehicleChat "SYSTEM: HIRIS STAND-BY.";
 
