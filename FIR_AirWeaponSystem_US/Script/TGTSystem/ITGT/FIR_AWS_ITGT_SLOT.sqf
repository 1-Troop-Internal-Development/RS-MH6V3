/* Open MFD By Firewill */
private ["_plane","_slotnum_str","_slotnum","_slotnum_temp"];

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

_status = _this select 0;

_slotnum = _plane getVariable "AWS_MEMORYSLOT";
_slotnum_temp = _slotnum;
if (_status == "inc") then
{
	if (_slotnum == 5) exitWith {systemChat "SYSTEM : NO. 5 IS MAX";};
	_slotnum_temp = _slotnum + 1;
	_slotnum = _slotnum_temp;
};

if (_status == "dec") then
{
	if (_slotnum == 1) exitWith {systemChat "SYSTEM : NO.1 IS MIN"};
	_slotnum_temp = _slotnum - 1;
	_slotnum = _slotnum_temp;
};

_slotnum_str = "Slot No." + str _slotnum;

ctrlSetText [1997, _slotnum_str];		

_plane setVariable ["AWS_MEMORYSLOT",_slotnum,true];

