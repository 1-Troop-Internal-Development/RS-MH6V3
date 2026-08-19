private ["_user","_type"];

_user = player;
_type = _this select 0;

_txt = (findDisplay 5589) displayCtrl 1000;

switch (_type) do
{
    case "8D":
    {
		_user setVariable ["ITGT_GRIDTYPE","8D",true];
		systemChat "SYSTEM : 8 DIGITS GRID";
		_txt ctrlSetText "8DIGITS";
    };

    case "10D":
    {
		_user setVariable ["ITGT_GRIDTYPE","10D",true];		
		systemChat "SYSTEM : 10 DIGITS GRID";
		_txt ctrlSetText "10DIGITS";
    };
};