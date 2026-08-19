
_plane = _this select 0;

sleep 0.5;

_soundSource = createSoundSource ["FIR_Afterburenr_SFX_Sound", position _plane, [], 0];
_soundSource attachto [_plane,[0,-5,0]];

while {(alive _plane) and (_plane getvariable "AWS_AB" == "on") and (isengineon _plane)} do 
{
sleep 0.1;
};
detach _soundSource;
deletevehicle _soundSource;
Exit;


