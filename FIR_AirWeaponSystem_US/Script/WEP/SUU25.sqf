/* suu-25 flare dispenser script
   Made by Firewill 
 */
private ["_suu25","_suu25xpos","_suu25ypos","_suu25zpos","_para","_flr"];
_suu25 = _this select 0;
_suu25xpos = getposATL _suu25 select 0;
_suu25ypos = getposATL _suu25 select 1;
_suu25zpos = getposATL _suu25 select 2;

for [{_i=0}, {_i < 1}, {_i=_i+1}] do
{
	_para = createVehicle ["B_Parachute_02_F", [0,0,100000], [], 0, ""];
	_para setPosATL [_suu25xpos,_suu25ypos,_suu25zpos];
	_flr = createVehicle ["FIR_IRFlare", [0,0,100000], [], 0, ""];
	_flr attachTo [_para,[0,0,0]];
};
deletevehicle _suu25;

sleep 65;

deletevehicle _para;
deletevehicle _flr;


