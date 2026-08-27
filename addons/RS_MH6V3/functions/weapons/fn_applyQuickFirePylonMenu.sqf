disableSerialization;

private _display = uiNamespace getVariable ["RS_MH6V3_quickFireMenuDisplay", displayNull];
private _vehicle = uiNamespace getVariable ["RS_MH6V3_quickFireMenuVehicle", objNull];
private _sequence = +(uiNamespace getVariable ["RS_MH6V3_quickFireMenuSequence", []]);

if (isNull _display || {isNull _vehicle} || {!alive _vehicle}) exitWith {false};
if !(vehicle player isEqualTo _vehicle && {currentPilot _vehicle isEqualTo player}) exitWith {false};
if (_sequence isEqualTo []) exitWith {
	systemChat "RS MH-6V3: add at least one pylon step.";
	false
};

private _modeCombo = _display displayCtrl 86412;
private _modeIndex = lbCurSel _modeCombo;
private _mode = if (_modeIndex < 0) then {
	"single"
} else {
	_modeCombo lbData _modeIndex
};

_vehicle setVariable ["RS_MH6V3_quickHydraMode", _mode, true];
_vehicle setVariable ["RS_MH6V3_quickHydraSequence", _sequence, true];
_vehicle setVariable ["RS_MH6V3_quickHydraSequenceStep", 0, true];

private _modeLabel = if (_mode == "cycle") then {"Cycling"} else {"Single Pylon Priority"};
private _sequenceLabel = (_sequence apply {format ["Pylon %1", _x]}) joinString " > ";
systemChat format ["RS MH-6V3: Hydra Rocket Ripple Configuration - %1: %2", _modeLabel, _sequenceLabel];

closeDialog 1;
true
