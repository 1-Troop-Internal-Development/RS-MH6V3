/*Loadout Dialog By Firewill*/

private ["_plane","_cursel"];

_plane = vehicle player;

_mydisplay = findDisplay 5590;

_decoy_ctrl = _mydisplay displayCtrl 2100;
_decoy_txt = _mydisplay displayCtrl 2002;

//_cursel = lbdata [2100,(lbCurSel 2100)];
_cursel_get = lbCurSel _decoy_ctrl;
_cursel = _decoy_ctrl lbdata _cursel_get;
_text = getText (configFile >> "CfgAWS_EW_Decoy" >> _cursel >> "name");
_decoy_txt ctrlSetText _text;
//ctrlSetText [2002, _text];
