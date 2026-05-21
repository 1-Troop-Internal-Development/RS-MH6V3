if (!hasInterface) exitWith {};

[] spawn {
	RS_MH6V3_acreGetVolumeCrewVehicle = {
		private _vehicle = vehicle player;
		if (
			isNull _vehicle ||
			{!(_vehicle isKindOf "RHS_MELB_AH6M")} ||
			{!(player in [driver _vehicle, gunner _vehicle, _vehicle turretUnit [0]])}
		) exitWith {objNull};

		_vehicle
	};

	RS_MH6V3_acreCaptureRadioVolumes = {
		params ["_vehicle"];

		private _volumes = createHashMap;
		if (isNil "acre_api_fnc_getRadioVolume") exitWith {_volumes};

		private _lists = [_vehicle] call RS_MH6V3_fnc_getACRERadioLists;
		{
			private _volume = [_x] call acre_api_fnc_getRadioVolume;
			if (!isNil "_volume" && {_volume isEqualType 0}) then {
				_volumes set [_x, _volume];
			};
		} forEach (_lists get "all");

		_volumes
	};

	RS_MH6V3_acreRestoreRadioVolumes = {
		if (isNil "acre_api_fnc_getRadioVolume" || {isNil "acre_api_fnc_setRadioVolume"}) exitWith {};

		private _volumes = missionNamespace getVariable ["RS_MH6V3_acreOriginalRadioVolumes", createHashMap];
		{
			[_x, _y] call acre_api_fnc_setRadioVolume;
		} forEach _volumes;

		if (!isNil "acre_api_fnc_getCurrentRadioList") then {
			{
				if (isNil {_volumes get _x}) then {
					private _volume = [_x] call acre_api_fnc_getRadioVolume;
					if (!isNil "_volume" && {_volume isEqualType 0} && {_volume > 1}) then {
						[_x, 1] call acre_api_fnc_setRadioVolume;
					};
				};
			} forEach ([] call acre_api_fnc_getCurrentRadioList);
		};

		missionNamespace setVariable ["RS_MH6V3_acreOriginalRadioVolumes", createHashMap];
	};

	RS_MH6V3_acreRefreshRadioVolumeState = {
		private _vehicle = call RS_MH6V3_acreGetVolumeCrewVehicle;
		private _trackedVehicle = missionNamespace getVariable ["RS_MH6V3_acreVolumeVehicle", objNull];

		if (!isNull _vehicle && {!(_vehicle isEqualTo _trackedVehicle)}) then {
			if (!isNull _trackedVehicle) then {
				call RS_MH6V3_acreRestoreRadioVolumes;
			};

			missionNamespace setVariable ["RS_MH6V3_acreVolumeVehicle", _vehicle];
			missionNamespace setVariable ["RS_MH6V3_acreOriginalRadioVolumes", [_vehicle] call RS_MH6V3_acreCaptureRadioVolumes];
		};

		if (isNull _vehicle && {!isNull _trackedVehicle}) then {
			call RS_MH6V3_acreRestoreRadioVolumes;
			missionNamespace setVariable ["RS_MH6V3_acreVolumeVehicle", objNull];
			missionNamespace setVariable ["RS_MH6V3_acreSelectedRadioId", ""];
			missionNamespace setVariable ["RS_MH6V3_acreSelectionNonce", (missionNamespace getVariable ["RS_MH6V3_acreSelectionNonce", 0]) + 1];
		};
	};

	if (!isNil "RS_MH6V3_acreVolumeGetInEh") then {
		player removeEventHandler ["GetInMan", RS_MH6V3_acreVolumeGetInEh];
	};
	if (!isNil "RS_MH6V3_acreVolumeGetOutEh") then {
		player removeEventHandler ["GetOutMan", RS_MH6V3_acreVolumeGetOutEh];
	};
	if (!isNil "RS_MH6V3_acreVolumeSeatSwitchedEh") then {
		player removeEventHandler ["SeatSwitchedMan", RS_MH6V3_acreVolumeSeatSwitchedEh];
	};

	RS_MH6V3_acreVolumeGetInEh = player addEventHandler ["GetInMan", {
		[] call RS_MH6V3_acreRefreshRadioVolumeState;
	}];
	RS_MH6V3_acreVolumeGetOutEh = player addEventHandler ["GetOutMan", {
		[] call RS_MH6V3_acreRefreshRadioVolumeState;
	}];
	RS_MH6V3_acreVolumeSeatSwitchedEh = player addEventHandler ["SeatSwitchedMan", {
		[] call RS_MH6V3_acreRefreshRadioVolumeState;
	}];

	call RS_MH6V3_acreRefreshRadioVolumeState;
};
