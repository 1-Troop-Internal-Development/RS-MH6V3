/* Open MFD By Firewill */

_user = _this select 0;

_check = _user getVariable ["PDU_Check","no"];

if (_user != player) exitWith {};

_items = assignedItems _user;

if (not ("FIR_PDU" in _items)) exitWith {systemChat "you don't have PDU!"};


if (_check == "yes") then
{

}
else
{
	if (_user == player) then
	{
		player setVariable ["PDU_Check","yes",true];

		player setVariable ["ITGT_GRIDTYPE","8D",true];
		player setVariable ["ITGT_C_DATA",[]];

		player setVariable ["ITGT_DATA_1",[]];
		player setVariable ["ITGT_DATA_2",[]];
		player setVariable ["ITGT_DATA_3",[]];
		player setVariable ["ITGT_DATA_4",[]];
		player setVariable ["ITGT_DATA_5",[]];

		player setVariable ["ITGT_NEW","no"];
		player setVariable ["ITGT_TYPE","GPS",true];

		player setVariable ["ITGT_TGT_SET","no"];

		player setVariable ["ITGT_C_MARKER","none"];
		player setVariable ["ITGT_MARKER_1","none"];
		player setVariable ["ITGT_MARKER_2","none"];
		player setVariable ["ITGT_MARKER_3","none"];
		player setVariable ["ITGT_MARKER_4","none"];
		player setVariable ["ITGT_MARKER_5","none"];

		player setVariable ["ITGT_MARKER_1_SET","no"];
		player setVariable ["ITGT_MARKER_2_SET","no"];
		player setVariable ["ITGT_MARKER_3_SET","no"];
		player setVariable ["ITGT_MARKER_4_SET","no"];
		player setVariable ["ITGT_MARKER_5_SET","no"];	
	};

};


if (_user != player) exitWith {hint "you are not player.";};

findDisplay 46 createDisplay "FIR_AWS_PDU";
//_handle= CreateDialog "FIR_AWS_PDU";

_lb = (findDisplay 5589) displayCtrl 2100;
_txt = (findDisplay 5589) displayCtrl 1000;

lbClear _lb;

{_lb lbAdd _x} forEach 
[  
	"Memory Slot 1",
	"Memory Slot 2",
	"Memory Slot 3",
	"Memory Slot 4",
	"Memory Slot 5"
];

_type2 = player getvariable "ITGT_GRIDTYPE";

switch (_type2) do
{
    case "8D":
    {
		_txt ctrlSetText "8DIGITS";
    };

    case "10D":
    {
		_txt ctrlSetText "10DIGITS";
    };
};