private ["_plane","_weapon","_mssl"];

_array = _this select 0;

_plane = _array select 0;
_weapon = _array select 1;
_mssl = _array select 4;


_status = _plane getvariable "Cam_tracking";

_plane animate ["tvm_locked_hide",1];

if (_weapon != "FIR_AGM65" or _mssl == "FIR_AGM65L") exitWith {};

_plane animate ["cam_tracking_hide",1];

sleep 1;

if (_plane ammo "FIR_AGM65" >= 1) then
{
_plane animate ["cam_tracking_hide",0];
}
else
{
_plane setvariable ["ITGT_VT","no"];

_plane animate ["cam_tracking_hide",0];

};

_plane setPilotCameraTarget objNull;