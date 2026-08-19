if (not Local player) Exitwith {};
_plane = vehicle Player;
_pilot = driver _plane;

if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the plane";};
if (player != _pilot) exitwith {};

_insignia = [_pilot] call BIS_fnc_getUnitInsignia;

sleep 0.3;

[_plane,_insignia] call FIR_fnc_AWS_Setinsignia;