params [
	"_vehicle"
];

!isNull _vehicle &&
{typeOf _vehicle in ["RHS_MELB_H6M", "RHS_MELB_MH6M", "RHS_MELB_AH6M"]} &&
{alive _vehicle} &&
{
	(typeOf _vehicle == "RHS_MELB_AH6M" && {isEngineOn _vehicle} && {_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]}) ||
	{_vehicle getVariable ["RS_MH6V3_pilotIZLIDEnabled", false]}
}
