private ["_plane","_planetype","_killscore","_get_data","_get_texture_array"];

_plane = vehicle player;
_planetype = typeof _plane;
If (not Local _plane) ExitWith {};
if (not(_plane iskindof "Plane")) ExitWith {player vehiclechat "You Must get in the Plane!";};

_killmark_type = lbCurSel 2100;
_killmark_type2 = lbCurSel 2101;

_killmark_array = profileNamespace getVariable "FIR_AWS_Killcount";	


_airkill = _killmark_array select 0;
_softkill = _killmark_array select 1;
_armorkill = _killmark_array select 2;
_totalkill = _killmark_array select 3;	

_killscore = 0;

switch (_killmark_type2) do
{
    case -1:
    {
		_killscore = _airkill;
    };
    case 0:
    {
		_killscore = _airkill;
    };
    case 1:
    {
		_killscore = _softkill + _armorkill;
    };
    case 2:
    {
		_killscore = _totalkill;
    };
};

_get_data = lbData [2100, _killmark_type];

_get_texture_array = getArray (configFile >> "CfgKillmarks" >> _get_data >> "killmark_list");

_1kill_texture = _get_texture_array select 0;
_10kill_texture = _get_texture_array select 1;
_50kill_texture = _get_texture_array select 2;
_100kill_texture = _get_texture_array select 3;

if (_killscore > 999) exitWith {hint "killmark system only support 999 kills max"};

private ["_kill_1","_kill_10","_kill_50","_kill_100"];

_kill_100 = _killscore / 100;
_kill_10 = (_killscore % 100) / 10;
if (_kill_10 > 50) then
{
	_kill_10 = _kill_10 - 50;
	_kill_50 = 1;
}
else
{
	_kill_50 = 0;
};
_kill_1 = (_killscore % 100) % 10;

private ["_index_1kill_1","_index_1kill_9"];
_index_1kill_1 = -1;
{
	if (_x == "kill_1_1") exitwith {_index_1kill_1 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index_1kill_9 = -1;
{
	if (_x == "kill_1_9") exitwith {_index_1kill_9 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index_10kill_1 = -1;
{
	if (_x == "kill_10_1") exitwith {_index_10kill_1 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index_10kill_4 = -1;
{
	if (_x == "kill_10_4") exitwith {_index_10kill_4 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index_50kill_1 = -1;
{
	if (_x == "kill_50_1") exitwith {_index_50kill_1 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index_100kill_1 = -1;
{
	if (_x == "kill_100_1") exitwith {_index_100kill_1 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

_index_100kill_9 = -1;
{
	if (_x == "kill_100_9") exitwith {_index_100kill_9 = _foreachindex;};
} foreach getarray (configfile >> "CfgVehicles" >> _planetype >> "hiddenSelections");

for [{_i=_index_1kill_1}, {_i<=_index_100kill_9}, {_i=_i+1}] do
{
	_plane setObjectTextureGlobal [_i,""];				
};


if (_index_1kill_1 < 0) then
{
	_plane vehiclechat "this aircraft doesn't have Killmark Section";
}
else
{


	if (_killscore == 0) then
	{
		for [{_i=_index_1kill_1}, {_i<=_index_100kill_9}, {_i=_i+1}] do
		{
			_plane setObjectTextureGlobal [_i,""];				
		};
	}
	else
	{
		if (_kill_1 == 0) then
		{
			for [{_i=_index_1kill_1}, {_i<=_index_1kill_9}, {_i=_i+1}] do
			{
				_plane setObjectTextureGlobal [_i,""];				
			};		
		}
		else
		{
			_1kill_last = _index_1kill_1 + (_kill_1 - 1);
			for [{_i=_index_1kill_1}, {_i<=_1kill_last}, {_i=_i+1}] do
			{
				_plane setObjectTextureGlobal [_i,_1kill_texture];				
			};				
		};
		
		if (_kill_10 == 0) then
		{
			for [{_i=_index_10kill_1}, {_i<=_index_10kill_4}, {_i=_i+1}] do
			{
				_plane setObjectTextureGlobal [_i,""];				
			};		
		}
		else
		{
			_10kill_last = _index_10kill_1 + (_kill_10 - 1);
			for [{_i=_index_10kill_1}, {_i<=_10kill_last}, {_i=_i+1}] do
			{
				_plane setObjectTextureGlobal [_i,_10kill_texture];				
			};				
		};		
		
		if (_kill_50 == 0) then
		{
				_plane setObjectTextureGlobal [_index_50kill_1,""];				
		}
		else
		{
				_plane setObjectTextureGlobal [_index_50kill_1,_50kill_texture];				
		};		

		if (_kill_100 == 0) then
		{
			for [{_i=_index_100kill_1}, {_i<=_index_100kill_9}, {_i=_i+1}] do
			{
				_plane setObjectTextureGlobal [_i,""];				
			};		
		}
		else
		{
			_100kill_last = _index_100kill_1 + (_kill_100 - 1);
			for [{_i=_index_100kill_1}, {_i<=_100kill_last}, {_i=_i+1}] do
			{
				_plane setObjectTextureGlobal [_i,_100kill_texture];				
			};				
		};				

	};
};



hintsilent "pasted";

