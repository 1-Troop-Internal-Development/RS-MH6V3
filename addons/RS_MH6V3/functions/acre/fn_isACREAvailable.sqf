private _acrePatchLoaded =
	isClass (configFile >> "CfgPatches" >> "acre_main") ||
	{isClass (configFile >> "CfgPatches" >> "acre_sys_core")};

if (!_acrePatchLoaded) exitWith {false};

!isNil "acre_api_fnc_isInitialized" &&
{!isNil "acre_api_fnc_getCurrentRadioList"}
