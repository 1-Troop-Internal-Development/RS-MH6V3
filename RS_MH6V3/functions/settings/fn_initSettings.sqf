[
	"RS_MH6V3_irIlluminatorBrightness",
	"SLIDER",
	["[RS] IR Illuminator Brightness", "Client-side brightness percentage for the MH-6V3 IR illuminator."],
	["[RS] MH-6V3", "IZLID"],
	[0, 100, 100, 0, false],
	0
] call CBA_fnc_addSetting;

[
	"RS_MH6V3_weaponVibrationEnabled",
	"CHECKBOX",
	["[RS] Aircraft Weapon Vibration", "Enable interior vibration from guns, rockets, and missile launches."],
	["[RS] MH-6V3", "Camera"],
	true,
	0,
	{
		params ["_enabled"];

		if (!hasInterface || {_enabled}) exitWith {};

		if (!isNil "RS_MH6V3_minigunShakePfh") then {
			[RS_MH6V3_minigunShakePfh] call CBA_fnc_removePerFrameHandler;
			RS_MH6V3_minigunShakePfh = nil;
		};

		setCamShakeParams [0, 1, 1, 1, true];
		missionNamespace setVariable ["RS_MH6V3_gunShakeVehicle", objNull];
		missionNamespace setVariable ["RS_MH6V3_gunShakeUntil", -1];
	}
] call CBA_fnc_addSetting;

[
	"RS_MH6V3_acreStatusOverlayEnabled",
	"CHECKBOX",
	["[RS] ACRE Status UI", "Show the ACRE radio status overlay while seated as pilot or co-pilot."],
	["[RS] MH-6V3", "ACRE"],
	true,
	0,
	{
		params ["_enabled"];

		if (!hasInterface) exitWith {};

		uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", ""];
		if (!_enabled && {!isNil "RS_MH6V3_acreStopRadioStatus"}) then {
			[] call RS_MH6V3_acreStopRadioStatus;
		};
		if (_enabled && {!isNil "RS_MH6V3_acreStartRadioStatus"}) then {
			[] call RS_MH6V3_acreStartRadioStatus;
		};
	}
] call CBA_fnc_addSetting;

[
	"RS_MH6V3_acreStatusOverlayDelayedHide",
	"CHECKBOX",
	["[RS] ACRE Status UI Delayed Hide", "Keep the ACRE radio status overlay visible briefly after radio use stops. Disable for instant hide."],
	["[RS] MH-6V3", "ACRE"],
	true,
	0,
	{
		if (!hasInterface) exitWith {};

		if (!isNil "RS_MH6V3_acreStartRadioStatus") then {
			[] call RS_MH6V3_acreStartRadioStatus;
		};
	}
] call CBA_fnc_addSetting;

[
	"RS_MH6V3_acreStatusOverlayX",
	"SLIDER",
	["[RS] ACRE Status UI X", "Client-side horizontal position of the ACRE radio status overlay."],
	["[RS] MH-6V3", "ACRE"],
	[0, 1, 0.034, 3, false],
	0,
	{
		if (!hasInterface) exitWith {};

		uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", ""];
	}
] call CBA_fnc_addSetting;

[
	"RS_MH6V3_acreStatusOverlayY",
	"SLIDER",
	["[RS] ACRE Status UI Y", "Client-side vertical position of the ACRE radio status overlay."],
	["[RS] MH-6V3", "ACRE"],
	[0, 1, 0.535, 3, false],
	0,
	{
		if (!hasInterface) exitWith {};

		uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", ""];
	}
] call CBA_fnc_addSetting;
