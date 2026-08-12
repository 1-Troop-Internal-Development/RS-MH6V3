if (!hasInterface) exitWith {};

if (!(missionNamespace getVariable ["RS_MH6V3_laircmDebugEnabled", false])) exitWith {
	if (!isNil "RS_MH6V3_laircmDebugDrawEH") then {
		removeMissionEventHandler ["Draw3D", RS_MH6V3_laircmDebugDrawEH];
		RS_MH6V3_laircmDebugDrawEH = nil;
	};
};

if (!isNil "RS_MH6V3_laircmDebugDrawEH") exitWith {};

RS_MH6V3_laircmDebugDrawEH = addMissionEventHandler ["Draw3D", {
	if (!(missionNamespace getVariable ["RS_MH6V3_laircmDebugEnabled", false])) exitWith {};

	private _vehicle = vehicle player;
	if (isNull _vehicle || {!(_vehicle isKindOf "RHS_MELB_base")}) exitWith {};

	private _originModel = [0.291016, 0.723327, -0.506007];
	private _origin = _vehicle modelToWorldVisual _originModel;
	private _range = 2200;
	private _goodColor = [0, 0.8, 1, 0.75];
	private _sideColor = [0.2, 1, 0.45, 0.7];
	private _warnColor = [1, 0, 0, 0.85];
	private _topBottomColor = [1, 0, 0, 0.8];
	private _mw = {
		params ["_vehicle", "_modelPos"];

		_vehicle modelToWorldVisual _modelPos
	};
	private _drawFan = {
		params ["_vehicle", "_origin", "_label", "_center", "_points", "_color"];

		private _centerWorld = [_vehicle, _center] call _mw;
		private _fillColor = +_color;
		_fillColor set [3, 0.28];

		drawLine3D [_origin, _centerWorld, _color];
		{
			private _pointWorld = [_vehicle, _x] call _mw;
			drawLine3D [_origin, _pointWorld, _color];
			drawLine3D [_centerWorld, _pointWorld, _color];

			for "_i" from 1 to 5 do {
				private _step = _i / 6;
				drawLine3D [
					_origin vectorAdd ((_centerWorld vectorDiff _origin) vectorMultiply _step),
					_origin vectorAdd ((_pointWorld vectorDiff _origin) vectorMultiply _step),
					_fillColor
				];
			};
		} forEach _points;
		drawIcon3D ["", _color, _centerWorld, 0, 0, 0, _label, 2, 0.03, "RobotoCondensed"];
	};

	[
		_vehicle,
		_origin,
		"FRONT/SIDE VALID",
		[0, 900, -55],
		[
			[-420, 650, -55],
			[420, 650, -55],
			[0, 650, 300],
			[0, 650, -335]
		],
		_goodColor
	] call _drawFan;

	[
		_vehicle,
		_origin,
		"LEFT VALID",
		[-880, -120, -55],
		[
			[-650, 380, -55],
			[-760, -560, -55],
			[-650, 0, 260],
			[-650, 0, -335]
		],
		_sideColor
	] call _drawFan;

	[
		_vehicle,
		_origin,
		"RIGHT VALID",
		[880, -120, -55],
		[
			[650, 380, -55],
			[760, -560, -55],
			[650, 0, 260],
			[650, 0, -335]
		],
		_sideColor
	] call _drawFan;

	[
		_vehicle,
		_origin,
		"REAR PENALTY",
		[0, -700, -0.65],
		[
			[-195, -620, -0.65],
			[195, -620, -0.65],
			[0, -620, 170],
			[0, -620, -170]
		],
		_warnColor
	] call _drawFan;

	[
		_vehicle,
		_origin,
		"TOP PENALTY",
		[0, 0, 520],
		[
			[-260, 0, 390],
			[260, 0, 390],
			[0, 260, 390],
			[0, -260, 390]
		],
		_topBottomColor
	] call _drawFan;

	[
		_vehicle,
		_origin,
		"BOTTOM PENALTY",
		[0, 0, -520],
		[
			[-260, 0, -390],
			[260, 0, -390],
			[0, 260, -390],
			[0, -260, -390]
		],
		_topBottomColor
	] call _drawFan;

	drawIcon3D [
		"",
		_goodColor,
		_origin,
		0,
		0,
		0,
		format ["LWIRCM DEBUG | range %1m | active %2/2", _range, count ((_vehicle getVariable ["RS_MH6V3_laircmActiveMissiles", []]) select {!isNull _x && {alive _x}})],
		2,
		0.035,
		"RobotoCondensed"
	];

	{
		if (!isNull _x && {alive _x}) then {
			drawLine3D [_origin, ASLToAGL getPosASL _x, [0, 0.9, 1, 0.9]];
			drawIcon3D ["", [0, 0.9, 1, 0.9], ASLToAGL getPosASL _x, 0, 0, 0, "LWIRCM TRACK", 2, 0.03, "RobotoCondensed"];
		};
	} forEach (_vehicle getVariable ["RS_MH6V3_laircmActiveMissiles", []]);
}];
