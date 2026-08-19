private ["_tgt","_missile"];
_plane = _this select 0;
_pilot = driver _plane;

_tgt = (getPilotCameraTarget _plane) select 2;
// _tgt = cursorTarget;


if (isNull _tgt) ExitWith{_plane vehiclechat "SYSTEM : Target not found";};
if (_tgt isKindOf "LandVehicle") then
{
	_plane vehiclechat "SYSTEM : Target found. Locking..";

	sleep 3;

	_plane setVariable ["AWS_MAV_TGT",_tgt,true];
	_plane setVariable ["AWS_MAV_TGT_Stat","yes",true];		

	_plane vehiclechat "SYSTEM  : LOCKED";
	
	_plane animate ["tvm_locked_hide",0];

}
else
{
	_plane vehiclechat "SYSTEM : Target not found";
	_plane animate ["tvm_locked_hide",1];
};
