#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

[] spawn {
	waitUntil {!isNull findDisplay 46};

	private _display = findDisplay 46;

	if (!isNil "RS_MH6V3_mouseFireDownEh") then {
		_display displayRemoveEventHandler ["MouseButtonDown", RS_MH6V3_mouseFireDownEh];
	};

	if (!isNil "RS_MH6V3_mouseFireUpEh") then {
		_display displayRemoveEventHandler ["MouseButtonUp", RS_MH6V3_mouseFireUpEh];
	};

	RS_MH6V3_mouseFireDownEh = _display displayAddEventHandler ["MouseButtonDown", {
		params [
			"",
			"_button"
		];

		if (_button isEqualTo 0) then {
			missionNamespace setVariable ["RS_MH6V3_fireInputHeld", true];
		};
	}];

	RS_MH6V3_mouseFireUpEh = _display displayAddEventHandler ["MouseButtonUp", {
		params [
			"",
			"_button"
		];

		if (_button isEqualTo 0) then {
			missionNamespace setVariable ["RS_MH6V3_fireInputHeld", false];
		};
	}];
};

if (isNil "RS_MH6V3_controlsShiftedEh") then {
	RS_MH6V3_controlsShiftedEh = addMissionEventHandler ["ControlsShifted", {
		params [
			"_newController",
			"_oldController",
			"_vehicle"
		];

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
	"[RS] MH-6V3",
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
	"[RS] MH-6V3",
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
	"[RS] MH-6V3",
	"RS_MH6V3_toggleIZLIDMode",
	["Cycle IZLID Mode", "Cycle between IZLID output and wide, narrow, or dynamic illuminator cone modes."],
	{
		[] call RS_MH6V3_fnc_toggleIZLIDMode
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"[RS] MH-6V3",
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
	"[RS] MH-6V3",
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

[
	"[RS] MH-6V3",
	"RS_MH6V3_cycleACRERadioSelection",
	["Cycle Selected ACRE Radio", "Select the next Little Bird ACRE radio for volume controls."],
	{
		[1] call RS_MH6V3_fnc_cycleACRERadioSelection
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"[RS] MH-6V3",
	"RS_MH6V3_increaseSelectedACRERadioVolume",
	["Increase Selected ACRE Radio Volume", "Increase the selected Little Bird ACRE radio volume."],
	{
		[0.25] call RS_MH6V3_fnc_adjustACRERadioVolume
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

[
	"[RS] MH-6V3",
	"RS_MH6V3_decreaseSelectedACRERadioVolume",
	["Decrease Selected ACRE Radio Volume", "Decrease the selected Little Bird ACRE radio volume."],
	{
		[-0.25] call RS_MH6V3_fnc_adjustACRERadioVolume
	},
	{false},
	[],
	false,
	0
] call CBA_fnc_addKeybind;

missionNamespace setVariable [
	"RS_MH6V3_activeIZLIDVehicles",
	vehicles select {
		_x isKindOf "RHS_MELB_AH6M" &&
		{[_x] call RS_MH6V3_fnc_canUseIZLID}
	}
];

[objNull, false] call RS_MH6V3_fnc_trackIZLIDVehicle;
