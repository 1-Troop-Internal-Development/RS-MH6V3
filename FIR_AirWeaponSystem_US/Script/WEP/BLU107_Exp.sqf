_blu107 = _this;

sleep 1;

_secondboom = "FIR_GBU38" createvehicle _blu107;

sleep 0.01;
_range = 10;

for [{_i=0}, {_i < 5}, {_i=_i+1}] do
{
	_radius = random (_range)-(_range/2);
	_crater = "CraterLong" createvehicle [(_blu107 select 0)+_radius , (_blu107 select 1)+_radius , (_blu107 select 2)]; 
};