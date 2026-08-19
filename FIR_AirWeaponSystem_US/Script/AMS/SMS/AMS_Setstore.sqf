private _weapon = param [0,""];
private _count = param [1.0];
private _ary_index = -1;

private _ary = missionNamespace getVariable ["AWS_AMS_SMS_List", [["empty",99999],["clean",99999],["f15se_cwb",99999],["f15se_cft",99999],["av8b_undertail",99999]]];

private _ary_c = (count _ary) - 1;

for [{_i=0}, {_i<_ary_c}, {_i=_i+1}] do
{
	_pick = _ary select _i;
	_wepname = _pick select 0;
	
	if (_weapon == _wepname) exitWith
	{
		_ary_index = _i;
	};
};


if (_ary_index != -1) then
{
	_ary set [_i,[_wepname,_count]];
}
else
{
	_ary pushBack [_weapon,_count];
};

missionNamespace setVariable ["AWS_AMS_SMS_List",_ary,true];


