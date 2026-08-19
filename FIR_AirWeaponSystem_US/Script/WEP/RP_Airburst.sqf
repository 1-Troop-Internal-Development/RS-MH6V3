
private _wp_rkt = _this select 0;
private _wp_rktzpos = getpos _wp_rkt select 2;

while {_wp_rktzpos > 30} do
{
	_wp_rktzpos = getpos _wp_rkt select 2;
	sleep 0.03;
};

private _wp_pos = getpos _wp_rkt;
private _wp_velocity = velocity _wp_rkt;
private _wp_dir = vectorDir _wp_rkt;
private _wp_up = vectorUp _wp_rkt;


deletevehicle _wp_rkt;

private _sub = "FIR_RP_Airburst" createvehicle _wp_pos;
_sub setpos [(getpos _sub select 0),(getpos _sub select 1),30];
_sub setVectorDirAndUp [_wp_dir,_wp_up];
_sub setVelocity _wp_velocity;
private _subpos = getpos _sub;
_sub setdamage 1;

sleep 0.02;
