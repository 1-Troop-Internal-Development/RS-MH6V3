
private _plane = _this select 0;
private _pilot = driver _plane;

private _data = _plane getVariable "AWS_ACMI_PLANE_DATA";

_plane vehicleChat format ["ID : %1 / CALLSIGN : %2 / TEAM : %3",_data select 0, _data select 1, _data select 2];

