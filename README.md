[h1]MH-6V3 Little Bird[/h1]
[hr][/hr][code]A gameplay-focused AH-6M Little Bird enhancement for Arma 3.

This mod expands the RHS MELB AH-6M with practical crew tools, aircraft controls,
ACRE radio management, IZLID/IR illumination capability, improved weapon options,
custom pylon defaults, joystick-friendly keybind support, and mission-maker/server
configuration where local presentation makes sense.

Little Bird V3 is re-scripted from the Little Bird V2 mod to add more functionality,
modernize the aircraft systems, and fix bugs or limitations that occurred in the
older version.

The goal is not to rebuild the Little Bird as a full avionics simulation. The goal
is to provide a cleaner, more capable, and more crew-friendly aircraft for Arma 3
operations while keeping the systems usable in live missions.
[/code]
[hr][/hr]
[h2]Based on Little Bird V2[/h2]
Little Bird V3 is a re-scripted continuation of the Little Bird V2 mod. It keeps the same general gameplay purpose while expanding the aircraft with additional crew tools, weapon options, radio support, keybind support, and bug fixes for issues found in the older version.

[code]
Little Bird V2 Workshop:
https://steamcommunity.com/sharedfiles/filedetails/?id=2787531417
[/code]

[h2]Aircraft[/h2]
This mod updates the RHS AH-6M Little Bird with expanded crew, weapon, and aircraft utility features.

Primary aircraft changes include:
[list]
[*]Custom AH-6M Little Bird configuration.
[*]Updated default pylon setup.
[*]Extended pylon editor options.
[*]ACE interaction support for aircraft systems.
[*]Livery and aircraft visual customization support.
[*]Improved pilot/co-pilot crew workflow.
[/list]

[h2]Pilot / Co-Pilot Pylon Ownership[/h2]
The Little Bird V3 includes pilot and co-pilot pylon ownership synchronization so weapon control follows the active crew control state more reliably.

This system helps keep pylon weapon ownership aligned when:
[list]
[*]Players enter or leave crew seats.
[*]Aircraft controls are shifted between pilot and co-pilot.
[*]The active co-pilot state changes.
[*]Pylon weapon control needs to remain consistent during crewed flight.
[/list]

[h2]IZLID & IR Illumination[/h2]
The Little Bird V3 includes an aircraft-mounted IZLID and IR illuminator system for night operations, marking, crew coordination, and air-to-ground support.

IZLID control options include:
[list]
[*]Toggle IZLID.
[*]Hold IZLID.
[*]Cycle IZLID mode.
[*]ACE interaction controls.
[*]CBA keybind controls.
[*]CfgUserActions support for joystick and controller binding.
[/list]

Available IZLID / illuminator modes include:
[list]
[*]IZLID laser marking.
[*]Wide IR illuminator.
[*]Narrow IR illuminator.
[*]Dynamic illuminator behavior.
[*]Combined mode options through ACE interaction.
[/list]

[code]
IR Illuminator Brightness - Client Addon Option
Toggle IZLID - Keybind / UserAction / ACE
Hold IZLID - Keybind / UserAction
Cycle IZLID Mode - Keybind / UserAction / ACE
[/code]

[h2]ACRE Radio Management[/h2]
The mod adds Little Bird-focused ACRE radio tools for pilots and co-pilots.

ACRE features include:
[list]
[*]ACRE Status UI for pilot and co-pilot positions.
[*]Client-side ACRE Status UI visibility toggle.
[*]Client-side ACRE Status UI X/Y positioning.
[*]Client-side delayed hide or instant hide option.
[*]Radio selection cycling.
[*]Selected radio volume increase/decrease controls.
[*]Seated ACE Radio Management action.
[*]Remote crew radio tune support.
[*]Radio change notifications only for valid crew/vehicle listeners.
[*]Automatic removal of ACRE interactions when ACRE is not loaded.
[/list]

The ACRE Status UI is designed to respond to actual radio transmissions rather than aircraft intercom speech.
ACRE Radio Management interactions are only registered when the required ACRE API is detected.

[code]
ACRE Status UI - Client Addon Option
ACRE Status UI Delayed Hide - Client Addon Option
ACRE Status UI X/Y Position - Client Addon Options
Cycle Selected ACRE Radio - Keybind / UserAction
Increase Selected ACRE Radio Volume - Keybind / UserAction
Decrease Selected ACRE Radio Volume - Keybind / UserAction
[/code]

[h2]Pylons & Weapons[/h2]
The Little Bird V3 includes expanded pylon and weapon options while keeping the aircraft practical for repeated mission use.

Weapon and pylon features include:
[list]
[*]Custom RS M134 pylon weapon variant.
[*]Clear pylon editor title difference between RHS and RS M134 variants.
[*]RS M134 set as the default gun pylon option.
[*]M134 LO and HI fire-rate modes tuned for more realistic output.
[*]Interior aircraft vibration while the RS M134 miniguns are firing.
[*]Stronger interior vibration while the GAU-19 is firing.
[*]Heavy interior impact vibration when rockets or missiles launch.
[*]HEAT Hydra pylon option.
[*]Quick Launch Hydra keybind.
[*]Hydra Rocket Ripple Configuration.
[*]Hydra Ripple Master Arm toggle.
[/list]

[code]
RS M134 Pylon Title - M134D-H (RS)
RS M134 Short Title - RS M134
Default AH-6M Gun Pylons - RS M134
Quick Launch Hydra - Keybind / UserAction
Hydra Rocket Ripple Configuration - Keybind / UserAction / ACE
Toggle Hydra Ripple Master Arm - Keybind / UserAction
[/code]

[h2]M134D-H RS Variant[/h2]
The RS M134 variant is separated from the RHS M134 in the pylon editor so mission makers can clearly identify which gun option is being used.

The fire-rate behavior has been edited to better represent the real M134's high-output capability. LO and HI modes are tuned to feel meaningfully different, with HI providing a much higher volume of fire instead of only a minor change from LO.

RS M134 features include:
[list]
[*]Dedicated RS pylon magazine.
[*]Dedicated RS pylon weapon class.
[*]Default AH-6M pylon placement.
[*]LO fire mode.
[*]HI fire mode.
[*]More realistic fire-rate behavior for sustained minigun employment.
[*]Crew-visible interior vibration while firing, with stronger feedback in HI mode.
[/list]

[code]
LO - Lower output fire-rate mode
HI - Higher output fire-rate mode
[/code]

[h2]HEAT Hydras[/h2]
The mod adds an M247 HEAT Hydra option intended for anti-vehicle use.

The HEAT Hydra setup is designed to provide:
[list]
[*]Reduced fragmentation radius compared to standard HE Hydras.
[*]Higher direct-hit anti-armor damage.
[*]Dedicated 7-round M260 HEAT pylon magazine.
[*]Dedicated 19-round M261 HEAT pylon magazine.
[*]Separate HEAT Hydra weapon selection from normal Hydras.
[*]HEAT preset support in the pylon editor.
[/list]

[code]
M247 HEAT Hydra (M260) - 7-round pod
M247 HEAT Hydra (M261) - 19-round pod
Hydra (M247 HEAT) - Dedicated weapon selection
[/code]

[h2]Hydra Rocket Ripple Configuration[/h2]
The Hydra Rocket Ripple system allows the pilot to launch configured Hydra pylons without manually selecting the rocket weapon first. The system temporarily fires the required Hydra launcher and restores the pilot's previously selected weapon.

The pilot can configure the pylon order from the seated AH-6M ACE interaction or through the dedicated keybind/UserAction.

Ripple configuration features include:

[h3]Single Pylon Priority[/h3]
Single Pylon Priority uses the first available pylon in the configured sequence until that pylon is depleted. The system then advances to the next loaded configured pylon.

[h3]Cycling Sequence[/h3]
Cycling Sequence advances one configured step on every trigger pull. Pylons may be entered multiple times to create a custom firing pattern.

[code]
Example: Pylon 1 > Pylon 2 > Pylon 2 > Pylon 3
Each Quick Launch input advances one step.
[/code]

The system requires a saved sequence. If Quick Launch is attempted without one, no Hydra is fired and the occupied pilot/co-pilot crew seats receive a notification.

Available UserActions include:
[list]
[*]Toggle IZLID.
[*]Hold IZLID.
[*]Cycle IZLID Mode.
[*]Quick Launch Hydra.
[*]Hydra Rocket Ripple Configuration.
[*]Toggle Hydra Ripple Master Arm.
[*]Cycle Selected ACRE Radio.
[*]Increase Selected ACRE Radio Volume.
[*]Decrease Selected ACRE Radio Volume.
[/list]

[code]
Addon / Keybind Group: [RS] MH-6V3
[/code]

[h2]ACE Interaction Features[/h2]
ACE interaction is used where aircraft-side interaction makes sense.

ACE-supported systems include:
[list]
[*]IZLID / IR illuminator controls.
[*]Hydra Rocket Ripple Configuration for the active AH-6M pilot.
[*]ACRE Radio Management for valid aircraft crew when ACRE is loaded.
[*]Aircraft livery tools.
[*]Pylon-related aircraft actions.
[/list]

[h2]Livery & Visual Customization[/h2]
The mod retains and extends aircraft visual customization options for mission makers and crews.

[h2]Addon Options[/h2]
The mod includes client-side addon options for systems where local presentation or preference matters.

Addon options include:
[list]
[*]IR Illuminator Brightness.
[*]ACRE Status UI enabled/disabled.
[*]ACRE Status UI delayed hide or instant hide.
[*]ACRE Status UI horizontal position.
[*]ACRE Status UI vertical position.
[/list]

[h2]Mission Maker Notes[/h2]
The mod is intended to be mission-friendly and crew-safe.

Mission maker considerations:
[list]
[*]The default AH-6M pylon loadout uses the RS M134 variant.
[*]The HEAT loadout preset uses RS M134 guns and HEAT Hydras.
[*]ACRE actions validate vehicle and crew context before applying remote radio changes.
[*]ACRE interactions do not appear when ACRE is not loaded.
[*]Intercom speech should not trigger the radio status overlay.
[*]Hydra Quick Launch cannot fire until the pilot saves a ripple sequence.
[*]Joystick users can bind key systems through normal UserActions.
[/list]

[h2]Dependencies[/h2]
This mod is built for the RHS MELB AH-6M and uses common Arma 3 community systems.

Required or expected systems include:
[list]
[*]CBA.
[*]ACE for ACE interaction features.
[*]ACRE for ACRE radio features.
[*]RHS United States Forces / RHS MELB content.
[/list]

[h2]Disclaimer[/h2]
This mod is designed around gameplay usability, crew workflow, and immersion first. While inspired by real-world aviation equipment and aircraft survivability practices, it is not intended to function as a fully realistic avionics or aircraft systems simulation.

Feedback and suggestions are welcome as development continues.

[h1]Support Discord[/h1]
https://discord.gg/HcwP6daZ9G

[h1]License[/h1]
Reupload in private packs if you wish. Just don't reupload as a copy for public use.

[h1]Unit[/h1]
If you are looking for a realism Arma unit, check out 1 Troop.

https://1troop.net
