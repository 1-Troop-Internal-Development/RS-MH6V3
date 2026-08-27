if (isNil "RS_MH6V3_fastRopeInitDone") then {
	RS_MH6V3_fastRopeInitDone = true;

	missionNamespace setVariable ["RS_MH6V3_fastRopeAceAvailable", call RS_MH6V3_fnc_isACEFastRopingAvailable];
	missionNamespace setVariable ["RS_MH6V3_fastRopeHatchetAvailable", call RS_MH6V3_fnc_isHatchetFrameworkAvailable];

	if (isNil "RS_MH6V3_fastRopePoints") then {
		missionNamespace setVariable [
			"RS_MH6V3_fastRopePoints",
			[
				[0.026611, 0.821605, -0.107002],
				[-1.23242, 0.794033, -0.0076561],
				[1.26709, 0.794001, -0.00635719],
				[-1.1665, 0.796253, -0.108951],
				[1.1333, 0.792804, -0.107751],
				[-1.23926, 0.791841, -0.109039],
				[1.35791, 0.775916, -0.107684],
				true,
				[-1.1665, 0.796253, -0.108951],
				[1.1333, 0.792804, -0.107751]
			]
		];
	};

	if (hasInterface) then {
		addMissionEventHandler ["Draw3D", {
			call RS_MH6V3_fnc_drawFastRopePrompts;
		}];
	};
};
