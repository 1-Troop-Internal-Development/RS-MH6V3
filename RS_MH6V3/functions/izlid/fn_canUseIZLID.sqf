params [
	"_vehicle"
];

!isNull _vehicle &&
{typeOf _vehicle == "RHS_MELB_AH6M"} &&
{alive _vehicle} &&
{isEngineOn _vehicle} &&
{_vehicle getVariable ["RS_MH6V3_izlidEnabled", false]}
