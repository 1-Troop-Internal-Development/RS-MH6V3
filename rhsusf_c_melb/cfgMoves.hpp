class CfgMovesBasic
{
	class DefaultDie;
	class ManActions
	{
		MELB_Pilot = "MELB_Pilot";
		MELB_Copilot = "MELB_Copilot";
		MELB_FL_Bench = "MELB_FL_Bench";
		MELB_L_Rack = "MELB_L_Rack";
		MELB_L_Rack_in = "MELB_L_Rack_in";
	};
};

class CfgMovesMaleSdr: CfgMovesBasic
{
	class States
	{
		class Crew;
		class MELB_Pilot: Crew
		{
			leftHandIKCurve[] = {1};
			rightHandIKCurve[] = {1};
			leftLegIKCurve[] = {1};
			rightLegIKCurve[] = {1};
			file = "rhsusf\addons\rhsusf_melb\Data\anim\MELB_Pilot.rtm";
			speed = 1e+010;
			looped = 0;
			interpolateTo[] = {"KIA_chopperLight_L_01_H",1,"KIA_chopperLight_L_02_H",1,"KIA_chopperLight_L_03_H",1};
		};
		class MELB_Copilot: Crew
		{
			leftHandIKCurve[] = {1};
			rightHandIKCurve[] = {1};
			leftLegIKCurve[] = {1};
			rightLegIKCurve[] = {1};
			file = "rhsusf\addons\rhsusf_melb\Data\anim\MELB_Copilot.rtm";
			speed = 1e+010;
			looped = 0;
			interpolateTo[] = {"KIA_chopperLight_R_01_H",1,"KIA_chopperLight_R_02_H",1};
		};
		class MELB_FL_Bench: Crew
		{
			leftHandIKCurve[] = {1};
			rightHandIKCurve[] = {1};
			leftLegIKCurve[] = {1};
			rightLegIKCurve[] = {1};
			file = "rhsusf\addons\rhsusf_melb\Data\anim\MELB_FL_Bench.rtm";
			speed = 1e+010;
			looped = 0;
			interpolateTo[] = {"KIA_chopperLight_L_01_H",1,"KIA_chopperLight_L_02_H",1,"KIA_chopperLight_L_03_H",1};
		};
		class MELB_L_Rack: Crew
		{
			leftHandIKCurve[] = {1};
			rightHandIKCurve[] = {1};
			leftLegIKCurve[] = {1};
			rightLegIKCurve[] = {1};
			file = "rhsusf\addons\rhsusf_melb\Data\anim\MELB_L_Rack.rtm";
			speed = 0.43;
			looped = 0;
			interpolateTo[] = {"KIA_chopperLight_L_01_H",1,"KIA_chopperLight_L_02_H",1,"KIA_chopperLight_L_03_H",1};
		};
		class AmovPercMstpSnonWnonDnon;
		class MELB_L_Rack_in: AmovPercMstpSnonWnonDnon
		{
			variantsPlayer[] = {};
			file = "rhsusf\addons\rhsusf_melb\Data\anim\MELB_L_Rack_in.rtm";
			speed = 1;
			looped = 0;
			soundOverride = "Walk";
			disableWeapons = 0;
			enableOptics = 0;
			headBobMode = 1;
			headBobStrength = 0.5;
			ConnectTo[] = {"AmovPercMstpSnonWnonDnon",0.02};
			InterpolateTo[] = {"Unconscious",0.1};
		};
	};
};