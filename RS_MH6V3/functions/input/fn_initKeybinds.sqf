#include "\a3\ui_f\hpp\defineDIKCodes.inc"

if (!hasInterface) exitWith {};

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

addMissionEventHandler ["Draw3D", {
	call RS_MH6V3_fnc_renderIZLID;
}];
