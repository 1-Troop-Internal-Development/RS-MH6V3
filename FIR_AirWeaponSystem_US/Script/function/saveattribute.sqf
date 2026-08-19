_ctrl = _this select 0;
_config = _this select 1;
_value = _ctrl lbData lbCurSel _ctrl;
if ((count get3DENselected 'object') > 0) then
{
_att = getText (_config >> 'property');
collect3DENHistory
{
{
_x set3DENAttribute [_att,_value];
} forEach (get3DENSelected 'object');
};
};
_value
