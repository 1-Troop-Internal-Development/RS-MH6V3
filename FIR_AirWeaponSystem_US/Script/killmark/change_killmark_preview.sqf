/*Loadout Dialog By Firewill*/

private ["_plane","_rank","_name","_rank_data","_font_color_get","_font_color"];

_plane = vehicle player;
_planetype = typeof _plane;

If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

_insignia = lbCurSel 2100;
_get_data = lbData [2100, _insignia];

_insignia_data = getText (configFile >> "CfgKillmarks" >> _get_data >> "texture");

ctrlSetText [1200, _insignia_data];//for Dialogs