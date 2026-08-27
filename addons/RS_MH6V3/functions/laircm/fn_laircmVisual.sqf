params [
	["_vehicle", objNull, [objNull]],
	["_missile", objNull, [objNull]],
	["_success", true, [true]]
];

if (!hasInterface) exitWith {};
if (isNull _vehicle || {isNull _missile}) exitWith {};
if !(player in crew _vehicle) exitWith {};

private _activeKey = format ["RS_MH6V3_laircmVisualActive_%1", netId _missile];
if (missionNamespace getVariable [_activeKey, false]) exitWith {};
missionNamespace setVariable [_activeKey, true, false];

_vehicle vehicleChat (if (_success) then {"LAIRCM ENGAGED"} else {"LAIRCM FAILED"});

if (!_success) exitWith {
	missionNamespace setVariable [_activeKey, false, false];
};

[_vehicle, _missile, _activeKey] spawn {
	params ["_vehicle", "_missile", "_activeKey"];

	private _originModel = [0.291016, 0.723327, -0.506007];
	private _endTime = time + 10;
	private _closestDistance = _vehicle distance _missile;
	private _hasNearPass = false;
	private _beam = "#lightreflector" createVehicleLocal [0, 0, 0];
	private _beamNodes = [];
	_beam setLightIR true;
	_beam setLightColor [1, 1, 1];
	_beam setLightAmbient [1, 1, 1];
	_beam setLightIntensity 4500;
	_beam setLightDayLight true;
	_beam setLightUseFlare true;
	_beam setLightFlareSize 2.5;
	_beam setLightFlareMaxDistance 2600;
	_beam setLightConePars [4.5, 0.18, 26];
	_beam setLightAttenuation [0, 0, 0.012, 0, 2600, 3000];
	_beam setLightVolumeShape ["a3\data_f\VolumeLightFlashlight.p3d", [0.35, 18, 0.35]];

	for "_i" from 1 to 6 do {
		private _node = "#lightpoint" createVehicleLocal [0, 0, 0];
		_node setLightIR true;
		_node setLightColor [1, 1, 1];
		_node setLightAmbient [1, 1, 1];
		_node setLightIntensity 650;
		_node setLightDayLight true;
		_node setLightUseFlare true;
		_node setLightFlareSize 0.7;
		_node setLightFlareMaxDistance 1800;
		_node setLightAttenuation [0, 0, 0.18, 0, 55, 95];
		_beamNodes pushBack _node;
	};

	waitUntil {
		if (!isNull _vehicle && {!isNull _missile}) then {
			private _startAGL = _vehicle modelToWorldVisual _originModel;
			private _startASL = AGLToASL _startAGL;
			private _endASL = getPosASL _missile;
			private _beamVector = _endASL vectorDiff _startASL;
			private _dir = vectorNormalized _beamVector;
			private _up = vectorUpVisual _vehicle;
			private _distance = _vehicle distance _missile;

			_closestDistance = _closestDistance min _distance;
			if (_distance < 450) then {
				_hasNearPass = true;
			};

			_beam setPosASL _startASL;
			_beam setVectorDirAndUp [_dir, _up];
			_beam setLightVolumeShape ["a3\data_f\VolumeLightFlashlight.p3d", [0.35, (_distance max 18) min 2600, 0.35]];

			{
				private _step = (_forEachIndex + 1) / ((count _beamNodes) + 1);
				_x setPosASL (_startASL vectorAdd (_beamVector vectorMultiply _step));
			} forEach _beamNodes;
		};

		sleep 0.05;
		time > _endTime
		|| {isNull _vehicle}
		|| {isNull _missile}
		|| {_hasNearPass && {(_vehicle distance _missile) > (_closestDistance + 30)}}
	};

	deleteVehicle _beam;
	{
		deleteVehicle _x;
	} forEach _beamNodes;
	missionNamespace setVariable [_activeKey, false, false];
};
