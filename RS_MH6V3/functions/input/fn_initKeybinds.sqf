#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

if (isNil "RS_MH6V3_controlsShiftedEh") then {
	RS_MH6V3_controlsShiftedEh = addMissionEventHandler ["ControlsShifted", {
		params ["_newController", "_oldController", "_vehicle"];

		if (isNull _vehicle || {!(typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"])}) exitWith {};

		private _copilot = _vehicle turretUnit [0];
		private _activeCopilot = if (!isNull _copilot && {_newController isEqualTo _copilot}) then {
			_copilot
		} else {
			objNull
		};

		_vehicle setVariable ["RS_MH6V3_activeCopilot", _activeCopilot, true];
		[_vehicle] call RS_MH6V3_fnc_syncPylonOwner;
	}];
};

[
	"RS MH-6V3",
	"RS_MH6V3_toggleIZLID",
	["Toggle IZLID", "Toggle the AH-6M IZLID marking laser."],
	{
		[] call RS_MH6V3_fnc_toggleIZLID
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"RS MH-6V3",
	"RS_MH6V3_holdIZLID",
	["Hold IZLID", "Keep the AH-6M IZLID on while this key is held."],
	{
		[true] call RS_MH6V3_fnc_holdIZLID
	},
	{
		[false] call RS_MH6V3_fnc_holdIZLID
	},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"RS MH-6V3",
	"RS_MH6V3_toggleIZLIDMode",
	["Cycle IZLID Mode", "Cycle between IZLID, IR illuminator, and combined output."],
	{
		[] call RS_MH6V3_fnc_toggleIZLIDMode
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"RS MH-6V3",
	"RS_MH6V3_quickLaunchHydra",
	["Quick Launch Hydra", "Fire one AH-6M Hydra without selecting rockets."],
	{
		[] call RS_MH6V3_fnc_quickLaunchHydra
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"RS MH-6V3",
	"RS_MH6V3_toggleQuickFireArm",
	["Toggle Quick Fire Master Arm", "Arm or safe the AH-6M quick-fire Hydra key."],
	{
		[] call RS_MH6V3_fnc_toggleQuickFireArm
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

if (isNil "RS_MH6V3_izlidIlluminatorEh") then {
	RS_MH6V3_izlidIlluminatorEh = addMissionEventHandler ["EachFrame", {
		call RS_MH6V3_fnc_updateIZLIDIlluminators;
	}];
};

if (isNil "RS_MH6V3_izlidRenderEh") then {
	RS_MH6V3_izlidRenderEh = addMissionEventHandler ["Draw3D", {
		call RS_MH6V3_fnc_renderIZLID;
	}];
};
