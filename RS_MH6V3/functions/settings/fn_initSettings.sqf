if (!hasInterface) exitWith {};

[
	"RS_MH6V3_irIlluminatorBrightness",
	"SLIDER",
	["[RS] IR Illuminator Brightness", "Client-side brightness percentage for the MH-6V3 IR illuminator."],
	["[RS] MH-6V3", "IZLID"],
	[0, 100, 100, 0, false],
	0
] call CBA_fnc_addSetting;
