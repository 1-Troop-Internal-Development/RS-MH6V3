params ["_vehicle"];

!isNull _vehicle &&
{_vehicle isKindOf "RHS_MELB_AH6M"} &&
{alive _vehicle} &&
{isEngineOn _vehicle} &&
{_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]}
