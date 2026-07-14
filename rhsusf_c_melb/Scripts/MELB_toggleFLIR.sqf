/*
toggle flir cam in UH1

a: reyhard
*/
private _p = call RHS_fnc_findPlayer;
private _v = vehicle _p;

if(_p == driver _v)then{
	if(_v animationPhase "MFD_Pilot" > 0)then{
		_v animate ["pilotpip",0];
		_v animate ["MFD_Pilot",0];
	}else{
		_v animate ["MFD_Pilot",1];
		_v animate ["pilotpip",1];
		/*
			camera restart
		*/
		melb_cam cameraeffect ["terminate","back", "rendertarget0"];
		melb_cam cameraEffect ["internal", "Back", "rendertarget0"];
		//mode reset
		private _mode=_v getVariable ["MELB_mode",0];
		switch(_mode)do
		{
			case 0: { "rendertarget0" setPiPEffect [3,1,1,0.8,-0.01,[0,0,0,0],[1,1,1,1],[1,1,1,0]]; };
			case 1: { "rendertarget0" setPiPEffect [3,1,1,3.5,0,[0,0,0,0],[0.5,1,0.5,0],[1,1,1,0]]; };
			case 2: { "rendertarget0" setPiPEffect [2]; };
		};
		//zoom reset
		private _n=(_v getVariable ["MELB_zoom",42])/40;
		melb_cam camSetFov (0.3/_n);
	};
}else{
	if(_p == gunner _v)then{
		if(_v animationPhase "MFD_CoPilot" > 0)then
		{
			_v animate ["copilotpip",0];
			_v animate ["MFD_CoPilot",0];
		}else{
			_v animate ["MFD_CoPilot",1];
			_v animate ["copilotpip",1];
			/*
				camera restart
			*/
			melb_cam cameraeffect ["terminate","back", "rendertarget0"];
			melb_cam cameraEffect ["internal", "Back", "rendertarget0"];
			//mode reset
			private _mode = _v getVariable ["MELB_mode",0];
			switch(_mode)do
			{
				case 0: { "rendertarget0" setPiPEffect [3,1,1,0.8,-0.01,[0,0,0,0],[1,1,1,1],[1,1,1,0]]; };
				case 1: { "rendertarget0" setPiPEffect [3,1,1,3.5,0,[0,0,0,0],[0.5,1,0.5,0],[1,1,1,0]]; };
				case 2: { "rendertarget0" setPiPEffect [2]; };
			};
			//zoom reset
			private _n=(_v getVariable ["MELB_zoom",42])/40;
			melb_cam camSetFov (0.3/_n);
		};
	};
};