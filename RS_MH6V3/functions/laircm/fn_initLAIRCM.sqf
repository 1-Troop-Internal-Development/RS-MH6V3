if (isServer) then {
	missionNamespace setVariable ["RS_MH6V3_laircmServerLoaded", true, true];
};

private _registerVehicle = {
	params [["_vehicle", objNull, [objNull]]];

	if (!isNull _vehicle && {_vehicle isKindOf "RHS_MELB_base"}) then {
		[_vehicle] call RS_MH6V3_fnc_initLAIRCMVehicle;
	};
};

{
	[_x] call _registerVehicle;
} forEach vehicles;

if (hasInterface) then {
	[] call RS_MH6V3_fnc_renderLAIRCMDebug;
};

addMissionEventHandler ["EntityCreated", {
	params [["_entity", objNull, [objNull]]];

	[_entity] spawn {
		params [["_entity", objNull, [objNull]]];

		sleep 0.1;
		if (!isNull _entity && {_entity isKindOf "RHS_MELB_base"}) then {
			[_entity] call RS_MH6V3_fnc_initLAIRCMVehicle;
		};
	};
}];
