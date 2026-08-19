/*TWAS Script by Firewill */

_array = _this select 0;
_unit = _array select 0;
_damage = _array select 2;
_attacker = _array select 3;
_projectile = _array select 4;

private _score = 0;
private _acmi_data = [];
private _team = "";

_unit_pilot = (driver _unit);
_attacker_pilot = (driver _attacker);
_weaponClass = currentWeapon _attacker;

_unit_name = name _unit_pilot;
_attacker_name = name _attacker_pilot;

if (_unit == _attacker) exitWith {};
if (_projectile == "") exitWith {};

_unitside = side _unit_pilot;

_text2 = format ["ATMS MSG : %1 's Aircraft is Hit by %2 's Aircraft / WEP : %3",_unit_name,_attacker_name,_weaponClass];
[_unit,_text2] remoteExec ["vehiclechat",([0,-2] select isDedicated)];
[_unit,"FIR_TWAS_Hit"] remoteExec ["say",([0,-2] select isDedicated)];

_text3 = format ["ATMS MSG : %1 's Aircraft is Hit by %2 's Aircraft / WEP : %3",_unit_name,_attacker_name,_weaponClass];
[_attacker,_text3] remoteExec ["vehiclechat",([0,-2] select isDedicated)];
[_attacker,"FIR_TWAS_Hit_Attacker"] remoteExec ["say",([0,-2] select isDedicated)];

_check = missionNamespace getVariable ["ATMS_Check","no"];

if (_check == "yes") then
{
	_score = missionNamespace getVariable "ATMS_Team_Score";
	_acmi_data = _attacker getVariable ["AWS_ACMI_PLANE_DATA",[000,"tempcallsign","nyet"]];
	_team = [_acmi_data,2,"nyet"] call BIS_fnc_param;
	
	switch (_team) do
	{
		case "red":
		{
			_r_c = _score select 0;
			_r_c = _r_c + 1;
			_score set [0, _r_c];
		};
		case "blue":
		{
			_b_c = _score select 1;
			_b_c = _b_c + 1;
			_score set [1, _b_c];
		};
		case "green":
		{
			_g_c = _score select 2;
			_g_c = _g_c + 1;
			_score set [2, _g_c];
		};
		case "yellow":
		{
			_y_c = _score select 3;
			_y_c = _y_c + 1;
			_score set [3, _y_c];
		};		
		default
		{
			//do nothing.
		};
	};
	missionNamespace setVariable ["ATMS_Team_Score",_score,true];
}
else
{

};
