params [
	["_armed", player getVariable ["RS_MH6V3_quickFireArmed", false]]
];

if (!hasInterface) exitWith {};

"RS_MH6V3_QuickFireStatusLayer" cutRsc ["RS_MH6V3_QuickFireStatus", "PLAIN", 0, false];

private _display = uiNamespace getVariable ["RS_MH6V3_quickFireStatusDisplay", displayNull];
if (isNull _display) exitWith {};

private _background = _display displayCtrl 86101;
private _status = _display displayCtrl 86102;

if (_armed) then {
	_background ctrlSetBackgroundColor [0.02, 0.2, 0.08, 0.78];
	_status ctrlSetText "QUICK FIRE: ARMED";
	_status ctrlSetTextColor [0.4, 1, 0.55, 1];
} else {
	_background ctrlSetBackgroundColor [0.22, 0.04, 0.03, 0.78];
	_status ctrlSetText "QUICK FIRE: NOT-ARMED";
	_status ctrlSetTextColor [1, 0.38, 0.32, 1];
};
