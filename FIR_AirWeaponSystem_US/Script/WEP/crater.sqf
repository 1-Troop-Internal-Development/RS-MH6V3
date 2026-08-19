/*create bomb crater for 500lb bomb, gbu-38 and mk82 gbu12*/

private ["_bomb","_pos","_crater","_pound","_crater_class"];

_bomb = _this select 0;
_pound = _this select 1;
_pos = getpos _bomb;
_crater = "";
_crater_class = "";

switch (_pound) do
{  
	case "500lb":
    {
	_crater_class = "FIR_crater_500lb";
    };
	case "1000lb":
    {
	_crater_class = "FIR_crater_1000lb";
    };
	case "2000lb":
    {
	_crater_class = "FIR_crater_2000lb";
    };
};

while {alive _bomb} do
{
	_pos = getpos _bomb;
};

_isWater = surfaceIsWater _pos;

if(_isWater) ExitWith{};

for [{_i=0}, {_i < 1}, {_i=_i+1}] do
{
	_crater = _crater_class createvehicle _pos;
	_normal = surfaceNormal _pos;
	_crater setVectorUp _normal;
};

sleep 180;

deleteVehicle _crater;