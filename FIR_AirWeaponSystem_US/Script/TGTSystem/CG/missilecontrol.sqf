//Command Guidance system based on nuxil's Tvs script. all credit goes to nuxil who created the original Tvs script.

private ["_unit","_weapon","_missile","_vink","_pitch","_turn","_dlgchk","_mx","_my"];

_unit = _this select 0;
_missile = _this select 1;
// get the roll/pitch/dir of the plane/heli onto the bomb
_vink = -(asin(vectordir _missile select 2));
_pitch=_vink;
_turn = getdir vehicle _missile;
_dlgchk = true;
while {alive player && alive _missile} do
{
	if (not dialog) exitwith {_dlgchk = false;};
	_turn = getdir _missile;	
	_mx = FIR_AWS_Nux_tvs_mousepos select 0;
	_my = FIR_AWS_Nux_tvs_mousepos select 1;		
	if (_my > 0.75) then { _pitch = _pitch + (_my /2);};
	if (_my < 0.75) then { _pitch = _pitch + (_my - 0.5);};
	if (_pitch >= 89) then {_pitch = 89;};
	if (_pitch <= -89) then {_pitch = -89;};
	_turn = _turn + ((_mx ) - 0.5);
	[_missile,[_turn,-_pitch,0]] call FIR_fnc_AWS_Nux_setvector;
	//update some ui info.. speed, alt and dir.
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8566) ctrlSetText format["SPD:%1",floor(speed _missile)];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8566) ctrlCommit 0;
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8567) ctrlSetText format["ALT:%1",floor(getposatl _missile select 2)];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8567) ctrlCommit 0;
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8568) ctrlSetText format["DIR:%1",floor(_turn)];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8568) ctrlCommit 0;
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8574) ctrlSetPosition [0.78 + (0.0025), (0.5 - (0.02 / 2) + ((((_pitch / 90) * 100) / 100) * 0.246))];
	((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8574) ctrlCommit 0;
	sleep 0.001;
};
if (not alive _unit) then {_dlgchk=false; closeDialog 0;};
if (_dlgchk) then {closeDialog 0;1 cuttext ["","black out", 0.0000001];2 cutRsc["RscNoise","PLAIN",0.0001];sleep 1.1;2 cutFadeOut 0;1 cutFadeOut 0;};
vehicle _unit switchCamera "internal";
