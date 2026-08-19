
private ["_pilot","_weapon"];

_pilot = player;
_weapon = _this select 0;
If (not Local _pilot) ExitWith {};

if (cameraView == "External") ExitWith{};

enableCamShake true;
switch (_weapon) do
{
	case "FIR_GAU8":
	{
		addCamShake [1.1, 0.8, 50];
	};
	case "FIR_M61A2":
	{
		addCamShake [0.7, 0.3, 40];
	};
	default
	{
		addCamShake [0.7, 0.3, 40];
	};
};

