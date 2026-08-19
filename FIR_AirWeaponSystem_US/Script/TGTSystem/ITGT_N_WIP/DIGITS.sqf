private ["_plane","_type"];

// _plane = vehicle player;

private _plane = "";
private _planetype = "";

private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only

		_plane = _UAV;	
		_plane_pilot = player;		
};

_planetype = typeof _plane;

_type = _plane getVariable "ITGT_GRIDTYPE";
switch (_type) do
{
    case "8D":
    {
		_plane setVariable ["ITGT_GRIDTYPE","10D",true];		
		systemChat"SYSTEM : SWITCH TO 10 DIGITS GRID";
		ctrlSetText [1998, "10DIGITS"];	

    };
    case "10D":
    {
		_plane setVariable ["ITGT_GRIDTYPE","8D",true];
		systemChat"SYSTEM : SWITCH TO 8 DIGITS GRID";
		ctrlSetText [1998, "8DIGITS"];
    };
};