private _cameraCategory = ["[RS] MH-6V3", "Camera & Effects"];
private _izlidCategory = ["[RS] MH-6V3", "IZLID & Illumination"];
private _acreAvailable = [] call RS_MH6V3_fnc_isACREAvailable;

// Camera & Effects
[
	"RS_MH6V3_weaponVibrationEnabled",
	"CHECKBOX",
	["Aircraft Weapon Vibration", "Enable interior camera vibration from guns, rockets, and missile launches."],
	_cameraCategory,
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

// IZLID & Illumination
[
	"RS_MH6V3_irIlluminatorBrightness",
	"SLIDER",
	["IR Illuminator Brightness", "Set the client-side brightness percentage for the aircraft IR illuminator."],
	_izlidCategory,
	[0, 100, 100, 0, false],
	0
] call CBA_fnc_addSetting;

if (_acreAvailable) then {
	private _acreCategory = ["[RS] MH-6V3", "ACRE Status UI"];

	// ACRE Status UI
	[
		"RS_MH6V3_acreStatusOverlayEnabled",
		"CHECKBOX",
		["Enable Status UI", "Show the ACRE radio status overlay while seated as pilot or co-pilot."],
		_acreCategory,
		false,
		0,
		{
			params ["_enabled"];

			if (!hasInterface || {!([] call RS_MH6V3_fnc_isACREAvailable)}) exitWith {};

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
		["Delayed Hide", "Keep the status UI visible briefly after radio use stops. Disable for instant hide."],
		_acreCategory,
		true,
		0,
		{
			if (!hasInterface || {!([] call RS_MH6V3_fnc_isACREAvailable)}) exitWith {};

			if (!isNil "RS_MH6V3_acreStartRadioStatus") then {
				[] call RS_MH6V3_acreStartRadioStatus;
			};
		}
	] call CBA_fnc_addSetting;

	[
		"RS_MH6V3_acreStatusOverlayX",
		"SLIDER",
		["Horizontal Position", "Set the client-side horizontal position of the ACRE status UI."],
		_acreCategory,
		[0, 1, 0.034, 3, false],
		0,
		{
			if (!hasInterface || {!([] call RS_MH6V3_fnc_isACREAvailable)}) exitWith {};

			uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", ""];
		}
	] call CBA_fnc_addSetting;

	[
		"RS_MH6V3_acreStatusOverlayY",
		"SLIDER",
		["Vertical Position", "Set the client-side vertical position of the ACRE status UI."],
		_acreCategory,
		[0, 1, 0.535, 3, false],
		0,
		{
			if (!hasInterface || {!([] call RS_MH6V3_fnc_isACREAvailable)}) exitWith {};

			uiNamespace setVariable ["RS_MH6V3_acreRadioStatusLayout", ""];
		}
	] call CBA_fnc_addSetting;
};
