class CfgFunctions
{
	class RHS_MELB
	{recompile=1;
		tag = "RHS_MELB";
		class functions
		{recompile=1;
			class MFD_toggle
			{
				file = "rhsusf\addons\rhsusf_c_melb\Scripts\MELB_toggleFLIR.sqf";
				description = "MELB MFD Toggle";
			};
			class Handler
			{
				file = "rhsusf\addons\rhsusf_c_melb\Scripts\MELB_Handler.sqf";
				description = "MELB Handler";
			};
			class FLIRHandler
			{
				file = "rhsusf\addons\rhsusf_c_melb\Scripts\MELB_FLIRHandler.sqf";
				description = "MELB FLIR Handler";
			};
			class tailNumber
			{
				file = "rhsusf\addons\rhsusf_c_melb\Scripts\MELB_tailNumber.sqf";
				description = "Tail number handler for MELB";
			};
			/*class fallDamage
			{
				file = "rhsusf\addons\rhsusf_c_melb\Scripts\rhs_fallDamage.sqf";
				description = "Vehicle fall damage reducer";
			};*/
		};
	};
};