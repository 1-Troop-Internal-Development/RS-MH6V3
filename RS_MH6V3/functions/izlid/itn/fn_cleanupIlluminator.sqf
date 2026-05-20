if (!hasInterface) exitWith {false};

params ["_vehicle"];

private _illuminator = _vehicle getVariable ["RS_MH6V3_izlidIlluminator", objNull];
private _illuminatorBoost = _vehicle getVariable ["RS_MH6V3_izlidIlluminatorBoost", objNull];

deleteVehicle _illuminator;
deleteVehicle _illuminatorBoost;

_vehicle setVariable ["RS_MH6V3_izlidIlluminator", objNull];
_vehicle setVariable ["RS_MH6V3_izlidIlluminatorBoost", objNull];
_vehicle setVariable ["RS_MH6V3_izlidIlluminatorType", ""];
_vehicle setVariable ["RS_MH6V3_izlidIlluminatorSettings", -1];

true
