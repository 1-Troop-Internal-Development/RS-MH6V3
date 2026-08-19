/*AI Ejection By Firewill*/

/*AI Ejection By Firewill
based on BIS AI ejection*/

private _plane = param [0,objNull];

if (speed _plane < 1) exitWith {};

if (_plane getVariable ["bis_aiEjected",false]) exitWith {};
_plane setVariable ["bis_aiEjected",true];

_plane spawn
{
	private _plane = _this;

	sleep 1.5;	//sleep to simulate Ai human-like reaction time

	//check validity of plane
	if (isNull _plane || {!alive _plane || {damage _plane < 0.1 || {unitIsUAV _plane}}}) exitWith {};

	private _driver = driver _plane;

	//check validity of pilot
	if (isNull _driver || {!alive _driver || {isPlayer _driver}}) exitWith {};
	
	if (damage _plane >= 0.8) then {[_this] call FIR_fnc_AWS_Ejection;};
};


// private _plane = param [0,objNull];
// _pilot = driver _plane;

// if (isNull _pilot || {!alive _pilot || {isPlayer _pilot}}) exitWith {};

// while {true} do
// {
	// if (damage _plane >= 0.85) ExitWith
	// {
		// [_plane] call FIR_fnc_AWS_Ejection;
	// };
// };
