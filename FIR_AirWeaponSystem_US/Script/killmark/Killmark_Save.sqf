/*Loadout Dialog By Firewill*/

private ["_plane","_airkill","_airkill_p","_airkill_s","_armorkill","_armorkill_p","_armorkill_s","_killmark_array","_player_score","_softkill","_softkill_p","_softkill_s","_totalkill"];

_plane = vehicle player;
_score = score player;
If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};
if (_score <= 0) ExitWith {_plane vehiclechat "save failed : NO SCORE"};

disableSerialization;
_mydisplay = findDisplay 9919;

_player_score = getPlayerScores player;
_airkill_p = _player_score select 3;
_softkill_p = _player_score select 1;
_armorkill_p = _player_score select 2;

_killmark_array = [];

_killmark_array = profileNamespace getVariable "FIR_AWS_Killcount";		


_airkill = _killmark_array select 0;
_softkill = _killmark_array select 1;
_armorkill = _killmark_array select 2;
_totalkill = 0;

_airkill_s = _airkill + _airkill_p;
_softkill_s = _softkill + _softkill_p;
_armorkill_s = _armorkill + _armorkill_p;
_totalkill = _totalkill + (_airkill_s + _softkill_s + _armorkill_s);


profileNamespace setVariable ["FIR_AWS_Killcount",[_airkill_s,_softkill_s,_armorkill_s,_totalkill]];

_airkill_str = str(_airkill_s);
_softkill_str = str(_softkill_s);
_armorkill_str = str(_armorkill_s);
_totalkill_str = str(_totalkill);

ctrlSetText [1007, _airkill_str];	
ctrlSetText [1008, _softkill_str];	
ctrlSetText [1009, _armorkill_str];	
ctrlSetText [1010, _totalkill_str];	
	
_pScore = score player;
_pScore2 = _pScore*2;
_result = _pScore - _pScore2;

player addScore _result;

hintsilent "saved";