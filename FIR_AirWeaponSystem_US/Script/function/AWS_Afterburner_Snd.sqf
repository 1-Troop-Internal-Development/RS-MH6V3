
_plane = _this select 0;
_abswitch = _this select 1;

sleep 0.5;

_soundSource = createSoundSource ["FIR_Afterburenr_SFX_Sound", position _plane, [], 0];
_soundSource attachto [_plane,[0,-5,0]];

while {(alive _plane) and (_plane animationphase _abswitch >= 0.1) and (isengineon _plane)} do 
{
sleep 0.1;
};
detach _soundSource;
deletevehicle _soundSource;
Exit;


