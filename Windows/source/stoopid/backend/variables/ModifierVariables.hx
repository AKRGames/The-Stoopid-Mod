package stoopid.backend.variables;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;

/**
 * This is a list of every modifier in the MODIFIER MODULATOR MODIFIATION idfk menu.
 */
typedef ModiVariables =
{
	var Practice:Bool;
	var SingleDigits:Bool;
	var Perfect:Bool;
	var ShittyEnding:Bool;
	var BadTrip:Bool;
	var TruePerfect:Bool;
	var LivesSwitch:Bool;
	var Lives:Float;
	var BrightnessSwitch:Bool;
	var Brightness:Float;
	var HPGainSwitch:Bool;
	var HPGain:Float;
	var HPLossSwitch:Bool;
	var HPLoss:Float;
	var StartHealthSwitch:Bool;
	var StartHealth:Float;
	var Enigma:Bool;
	var VibeSwitch:Bool;
	var Vibe:Float;
	var OffbeatSwitch:Bool;
	var Offbeat:Float;
	var HitZonesSwitch:Bool;
	var HitZones:Float;
	var NoteSpeedSwitch:Bool;
	var NoteSpeed:Float;
	var InvisibleNotes:Bool;
	var SnakeNotesSwitch:Bool;
	var SnakeNotes:Float;
	var DrunkNotesSwitch:Bool;
	var DrunkNotes:Float;
	var AccelNotesSwitch:Bool;
	var AccelNotes:Float;
	var ShortsightedSwitch:Bool;
	var Shortsighted:Float;
	var LongsightedSwitch:Bool;
	var Longsighted:Float;
	var FlippedNotes:Bool;
	var HyperNotesSwitch:Bool;
	var HyperNotes:Float;
	var EelNotesSwitch:Bool;
	var EelNotes:Float;
	var StretchSwitch:Bool;
	var Stretch:Float;
	var WidenSwitch:Bool;
	var Widen:Float;
	var SeasickSwitch:Bool;
	var Seasick:Float;
	var UpsideDown:Bool;
	var Mirror:Bool;
	var CameraSwitch:Bool;
	var Camera:Float;
	var EarthquakeSwitch:Bool;
	var Earthquake:Float;
	var LoveSwitch:Bool;
	var Love:Float;
	var FrightSwitch:Bool;
	var Fright:Float;
	var MustDieSwitch:Bool;
	var MustDie:Float;
	var FreezeSwitch:Bool;
	var Freeze:Float;
	var PaparazziSwitch:Bool;
	var Paparazzi:Float;
	var JacktasticSwitch:Bool;
	var Jacktastic:Float;
}

class ModifierVariables
{
	public static var _modifiers:ModiVariables;

	public static function updateModifiers():Void
	{
		_modifiers = {
			Practice: MenuModifiers.modifierList[0].value,

			SingleDigits: MenuModifiers.modifierList[1].value,

			Perfect: MenuModifiers.modifierList[2].value,

			ShittyEnding: MenuModifiers.modifierList[3].value,

			BadTrip: MenuModifiers.modifierList[4].value,

			TruePerfect: MenuModifiers.modifierList[5].value,

			Lives: MenuModifiers.modifierList[6].curValue,
			LivesSwitch: MenuModifiers.modifierList[6].value,

			Brightness: MenuModifiers.modifierList[7].curValue,
			BrightnessSwitch: MenuModifiers.modifierList[7].value,

			HPGain: MenuModifiers.modifierList[8].curValue,
			HPGainSwitch: MenuModifiers.modifierList[8].value,

			HPLoss: MenuModifiers.modifierList[9].curValue,
			HPLossSwitch: MenuModifiers.modifierList[9].value,

			StartHealth: MenuModifiers.modifierList[10].curValue,
			StartHealthSwitch: MenuModifiers.modifierList[10].value,

			Enigma: MenuModifiers.modifierList[11].value,

			Vibe: MenuModifiers.modifierList[12].curValue,
			VibeSwitch: MenuModifiers.modifierList[12].value,

			Offbeat: MenuModifiers.modifierList[13].curValue,
			OffbeatSwitch: MenuModifiers.modifierList[13].value,

			HitZones: MenuModifiers.modifierList[14].curValue,
			HitZonesSwitch: MenuModifiers.modifierList[14].value,

			NoteSpeed: MenuModifiers.modifierList[15].curValue,
			NoteSpeedSwitch: MenuModifiers.modifierList[15].value,

			InvisibleNotes: MenuModifiers.modifierList[16].value,

			SnakeNotes: MenuModifiers.modifierList[17].curValue,
			SnakeNotesSwitch: MenuModifiers.modifierList[17].value,

			DrunkNotes: MenuModifiers.modifierList[18].curValue,
			DrunkNotesSwitch: MenuModifiers.modifierList[18].value,

			AccelNotes: MenuModifiers.modifierList[19].curValue,
			AccelNotesSwitch: MenuModifiers.modifierList[19].value,

			Shortsighted: MenuModifiers.modifierList[20].curValue,
			ShortsightedSwitch: MenuModifiers.modifierList[20].value,

			Longsighted: MenuModifiers.modifierList[21].curValue,
			LongsightedSwitch: MenuModifiers.modifierList[21].value,

			FlippedNotes: MenuModifiers.modifierList[22].value,

			HyperNotes: MenuModifiers.modifierList[23].curValue,
			HyperNotesSwitch: MenuModifiers.modifierList[23].value,

			EelNotes: MenuModifiers.modifierList[24].curValue,
			EelNotesSwitch: MenuModifiers.modifierList[24].value,

			Stretch: MenuModifiers.modifierList[25].curValue,
			StretchSwitch: MenuModifiers.modifierList[25].value,

			Widen: MenuModifiers.modifierList[26].curValue,
			WidenSwitch: MenuModifiers.modifierList[26].value,

			Jacktastic: MenuModifiers.modifierList[27].curValue,
			JacktasticSwitch: MenuModifiers.modifierList[27].value,

			Seasick: MenuModifiers.modifierList[28].curValue,
			SeasickSwitch: MenuModifiers.modifierList[28].value,

			UpsideDown: MenuModifiers.modifierList[29].value,

			Mirror: MenuModifiers.modifierList[30].value,

			Camera: MenuModifiers.modifierList[31].curValue,
			CameraSwitch: MenuModifiers.modifierList[31].value,

			Earthquake: MenuModifiers.modifierList[32].curValue,
			EarthquakeSwitch: MenuModifiers.modifierList[32].value,

			Love: MenuModifiers.modifierList[33].curValue,
			LoveSwitch: MenuModifiers.modifierList[33].value,

			Fright: MenuModifiers.modifierList[34].curValue,
			FrightSwitch: MenuModifiers.modifierList[34].value,

			MustDie: MenuModifiers.modifierList[35].curValue,
			MustDieSwitch: MenuModifiers.modifierList[35].value,

			Freeze: MenuModifiers.modifierList[36].curValue,
			FreezeSwitch: MenuModifiers.modifierList[36].value,

			Paparazzi: MenuModifiers.modifierList[37].curValue,
			PaparazziSwitch: MenuModifiers.modifierList[37].value
		};
	}

	public static function saveCurrent():Void
	{
		if (!FileSystem.isDirectory('presets/modifiers'))
			FileSystem.createDirectory('presets/modifiers');

		File.saveContent(('presets/modifiers/current'), Json.stringify(_modifiers, null, '    '));
	}

	public static function savePreset(input:String):Void
	{
		File.saveContent(('presets/modifiers/' + input), Json.stringify(_modifiers, null, '    ')); // just an example for now
	}

	public static function loadPreset(input:String):Void
	{
		var data:String = File.getContent('presets/modifiers/' + input);
		_modifiers = Json.parse(data);

		replaceValues();
	}

	public static function loadCurrent():Void
	{
		if (FileSystem.exists('presets/modifiers/current'))
		{
			var data:String = File.getContent('presets/modifiers/current');
			_modifiers = Json.parse(data);
		}

		replaceValues();
	}

	public static function replaceValues():Void
	{
		MenuModifiers.modifierList[0].value = _modifiers.Practice;

		MenuModifiers.modifierList[1].value = _modifiers.SingleDigits;

		MenuModifiers.modifierList[2].value = _modifiers.Perfect;

		MenuModifiers.modifierList[3].value = _modifiers.ShittyEnding;

		MenuModifiers.modifierList[4].value = _modifiers.BadTrip;

		MenuModifiers.modifierList[5].value = _modifiers.TruePerfect;

		MenuModifiers.modifierList[6].curValue = _modifiers.Lives;
		MenuModifiers.modifierList[6].value = _modifiers.LivesSwitch;

		MenuModifiers.modifierList[7].curValue = _modifiers.Brightness;
		MenuModifiers.modifierList[7].value = _modifiers.BrightnessSwitch;

		MenuModifiers.modifierList[8].curValue = _modifiers.HPGain;
		MenuModifiers.modifierList[8].value = _modifiers.HPGainSwitch;

		MenuModifiers.modifierList[9].curValue = _modifiers.HPLoss;
		MenuModifiers.modifierList[9].value = _modifiers.HPLossSwitch;

		MenuModifiers.modifierList[10].curValue = _modifiers.StartHealth;
		MenuModifiers.modifierList[10].value = _modifiers.StartHealthSwitch;

		MenuModifiers.modifierList[11].value = _modifiers.Enigma;

		MenuModifiers.modifierList[12].curValue = _modifiers.Vibe;
		MenuModifiers.modifierList[12].value = _modifiers.VibeSwitch;

		MenuModifiers.modifierList[13].curValue = _modifiers.Offbeat;
		MenuModifiers.modifierList[13].value = _modifiers.OffbeatSwitch;

		MenuModifiers.modifierList[14].curValue = _modifiers.HitZones;
		MenuModifiers.modifierList[14].value = _modifiers.HitZonesSwitch;

		MenuModifiers.modifierList[15].curValue = _modifiers.NoteSpeed;
		MenuModifiers.modifierList[15].value = _modifiers.NoteSpeedSwitch;

		MenuModifiers.modifierList[16].value = _modifiers.InvisibleNotes;

		MenuModifiers.modifierList[17].curValue = _modifiers.SnakeNotes;
		MenuModifiers.modifierList[17].value = _modifiers.SnakeNotesSwitch;

		MenuModifiers.modifierList[18].curValue = _modifiers.DrunkNotes;
		MenuModifiers.modifierList[18].value = _modifiers.DrunkNotesSwitch;

		MenuModifiers.modifierList[19].curValue = _modifiers.AccelNotes;
		MenuModifiers.modifierList[19].value = _modifiers.AccelNotesSwitch;

		MenuModifiers.modifierList[20].curValue = _modifiers.Shortsighted;
		MenuModifiers.modifierList[20].value = _modifiers.ShortsightedSwitch;

		MenuModifiers.modifierList[21].curValue = _modifiers.Longsighted;
		MenuModifiers.modifierList[21].value = _modifiers.LongsightedSwitch;

		MenuModifiers.modifierList[22].value = _modifiers.FlippedNotes;

		MenuModifiers.modifierList[23].curValue = _modifiers.HyperNotes;
		MenuModifiers.modifierList[23].value = _modifiers.HyperNotesSwitch;

		MenuModifiers.modifierList[24].curValue = _modifiers.EelNotes;
		MenuModifiers.modifierList[24].value = _modifiers.EelNotesSwitch;

		MenuModifiers.modifierList[25].curValue = _modifiers.Stretch;
		MenuModifiers.modifierList[25].value = _modifiers.StretchSwitch;

		MenuModifiers.modifierList[26].curValue = _modifiers.Widen;
		MenuModifiers.modifierList[26].value = _modifiers.WidenSwitch;

		MenuModifiers.modifierList[27].curValue = _modifiers.Jacktastic;
		MenuModifiers.modifierList[27].value = _modifiers.JacktasticSwitch;

		MenuModifiers.modifierList[28].curValue = _modifiers.Seasick;
		MenuModifiers.modifierList[28].value = _modifiers.SeasickSwitch;

		MenuModifiers.modifierList[29].value = _modifiers.UpsideDown;

		MenuModifiers.modifierList[30].value = _modifiers.Mirror;

		MenuModifiers.modifierList[31].curValue = _modifiers.Camera;
		MenuModifiers.modifierList[31].value = _modifiers.CameraSwitch;

		MenuModifiers.modifierList[32].curValue = _modifiers.Earthquake;
		MenuModifiers.modifierList[32].value = _modifiers.EarthquakeSwitch;

		MenuModifiers.modifierList[33].curValue = _modifiers.Love;
		MenuModifiers.modifierList[33].value = _modifiers.LoveSwitch;

		MenuModifiers.modifierList[34].curValue = _modifiers.Fright;
		MenuModifiers.modifierList[34].value = _modifiers.FrightSwitch;

		MenuModifiers.modifierList[35].curValue = _modifiers.MustDie;
		MenuModifiers.modifierList[35].value = _modifiers.MustDieSwitch;

		MenuModifiers.modifierList[36].curValue = _modifiers.Freeze;
		MenuModifiers.modifierList[36].value = _modifiers.FreezeSwitch;

		MenuModifiers.modifierList[37].curValue = _modifiers.Paparazzi;
		MenuModifiers.modifierList[37].value = _modifiers.PaparazziSwitch;
	}

	public static function nullify():Void
	{
		for (i in MenuModifiers.modifierList)
		{
			i.value = false;

			if (i.type == 'number')
			{
				i.curValue = i.offAt;
			}
		}
	}

	public static function modifierSetup():Void
	{
		MenuModifiers.modifierList = [
			{
				name: 'Practice Mode',
				value: false,
				conflicts: [1, 2, 3, 4, 5, 6, 8, 9, 10, 32, 33],
				multi: 0,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "you're a certified pussy, and you should be proud of it. after all, practice makes perfect! \nscore multiplier: x0."
			},
			{
				name: 'Single Digits Only (SDCB)',
				value: false,
				conflicts: [0, 2, 3, 4, 5, 8, 9, 10, 11, 24, 32, 33, 34],
				multi: 1.5,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "try to miss less than 10 times, okay? \nscore multiplier: x1.5."
			},
			{
				name: 'No Misses (FC)',
				value: false,
				conflicts: [0, 1, 3, 4, 5, 8, 9, 10, 11, 24, 32, 33, 34],
				multi: 3,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "you can't miss bro. \nscore multiplier: x3."
			},
			{
				name: 'Try not to SHIT! (AFC)',
				value: false,
				conflicts: [0, 1, 2, 4, 5, 8, 9, 10, 11, 24, 32, 33, 34],
				multi: 5,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "hold it in bro. don't 'Shit', amirite ? \nscore multiplier: x5."
			},
			{
				name: 'Only your GF can be a BADdie! (GFC)',
				value: false,
				conflicts: [0, 1, 2, 3, 5, 8, 9, 10, 11, 24, 32, 33, 34],
				multi: 7,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "you don't want to be BAD, do you? then don't get bad. \nscore multiplier: x7."
			},
			{
				name: 'Ascension (MFC)',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 8, 9, 10, 11, 24, 32, 33, 34],
				multi: 9,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "you can do this, all you have to do is to not score a 'Good', it's very easy.\nscore multiplier: x9."
			},
			{
				name: 'Lives',
				value: false,
				conflicts: [0],
				multi: 0.6,
				realmulti: 0,
				equation: 'division',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 1,
				maxValue: 15,
				curValue: 1,
				offAt: 1,
				addChange: 1,
				string: '\nHEART(S)',
				explanation: "how much lives bro? (fun fact, a cat has 9!) \nscore divider: 3/5 per life."
			},
			{
				name: 'Brightness',
				value: false,
				conflicts: [],
				multi: 0.005,
				realmulti: 0,
				equation: '',
				abs: true,
				revAtLow: false,
				type: 'number',
				minValue: -100,
				maxValue: 100,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nBRIGHTNESS',
				explanation: "how much brightness bro? \nscore adder: +0.025 per 5% or -5% of brightness."
			},
			{
				name: 'HP GET!',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 5],
				multi: -0.2,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: true,
				type: 'number',
				minValue: 0,
				maxValue: 10,
				curValue: 1,
				offAt: 1,
				addChange: 0.5,
				string: 'x\nHEALTH GAIN',
				explanation: "how much more health bro? \nscore rate: +0.1 for less health gain and -0.1 for more health gain."
			},
			{
				name: 'HP LOSE!',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 5],
				multi: 0.2,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: true,
				type: 'number',
				minValue: 0,
				maxValue: 10,
				curValue: 1,
				offAt: 1,
				addChange: 0.5,
				string: 'x\nHEALTH LOSS',
				explanation: "how much less health bro? \nscore rate: -0.1 for less health loss and +0.1 for more health loss."
			},
			{
				name: 'Starting HP',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 5],
				multi: -0.0025,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: -100,
				maxValue: 100,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nMORE START\nHEALTH',
				explanation: "you gon' place your health or what? \nscore rate: 0.1 per amount."
			},
			{
				name: 'Did we get em?',
				value: false,
				conflicts: [1, 2, 3, 4, 5],
				multi: 0.3,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "you wanna see your health bar or not? \nscore adder: +0.3."
			},
			{
				name: 'Vibe',
				value: false,
				conflicts: [],
				multi: -0.9,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: true,
				type: 'number',
				minValue: 0.8,
				maxValue: 1.2,
				curValue: 1,
				offAt: 1,
				addChange: 0.2,
				string: 'x\nTHE VIBE',
				explanation: "mmm, vibes. \n1 = normal, 1.2 = daycore/lofi, and 0.8 = nightcore/hifi."
			},
			{
				name: 'Offbeat',
				value: false,
				conflicts: [],
				multi: 0.001,
				realmulti: 0,
				equation: '',
				abs: true,
				revAtLow: false,
				type: 'number',
				minValue: -1000,
				maxValue: 1000,
				curValue: 0,
				offAt: 0,
				addChange: 10,
				string: '%\nMORE NOTE\nOFFSET',
				explanation: "'ay man i don't do music like that i have OCD', you said. \nscore adder: +0.01. WARNING: YOU CAN GET BLUEBALLED IF YOU PUT IN A LARGE NEGATIVE VALUE."
			},
			{
				name: 'Safe Frames',
				value: false,
				conflicts: [],
				multi: -0.08,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: -8,
				maxValue: 30,
				curValue: 0,
				offAt: 0,
				addChange: 1,
				string: '\nMORE SAFE\nFRAMES',
				explanation: "how much frames do you want to save bro? \nscore rate: 0.8 per amount."
			},
			{
				name: 'Note Speed',
				value: false,
				conflicts: [],
				multi: 0.0125,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: -90,
				maxValue: 400,
				curValue: 0,
				offAt: 0,
				addChange: 2,
				string: '%\nMORE NOTE\nSPEED',
				explanation: "how speed are the notes gonna be bro? \nscore multiplier : x0.025 per amount. WARNING: YOU CAN GET BLUEBALLED IF YOU PUT IN A LARGE VALUE."
			},
			{
				name: 'Invisible Notes',
				value: false,
				conflicts: [17, 18, 19],
				multi: 2.5,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "you wanna see your notes or not? \nscore adder: +2.5."
			},
			{
				name: 'Snake Notes',
				value: false,
				conflicts: [16],
				multi: 0.003,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 300,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nOF SNAKE\nMOVES',
				explanation: "y'know, Snake? from Metal Gear Solid? \nscore adder: +0.015."
			},
			{
				name: 'Drunk Notes',
				value: false,
				conflicts: [16],
				multi: 0.003,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 300,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nOF DRUNK\nMOVES',
				explanation: "how many shots you took bro? \nscore adder: +0.015."
			},
			{
				name: 'Accelerant Notes',
				value: false,
				conflicts: [16],
				multi: 0.0045,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 300,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nOF SPEED\nACCELERATION',
				explanation: "OMG? FNF ONLINE VS REFERENCE!!! \nscore adder: +0.0225. WARNING: PLEASE DON'T USE AT HIGH VALUES."
			},
			{
				name: 'Squint',
				value: false,
				conflicts: [16, 21],
				multi: 0.0045,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 100,
				curValue: 0,
				offAt: 0,
				addChange: 2,
				string: '%\nOF SCREEN\nHEIGHT',
				explanation: "why you squinting bro? \nscore adder: +0.009."
			},
			{
				name: 'You Cannot See',
				value: false,
				conflicts: [16, 20],
				multi: 0.0045,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 100,
				curValue: 0,
				offAt: 0,
				addChange: 2,
				string: '%\nOF SCREEN\nHEIGHT',
				explanation: "bro idk what to say anymore. \nscore adder: +0.009."
			},
			{
				name: 'Flipped Notes',
				value: false,
				conflicts: [16],
				multi: 0.5,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "the notes got flipped; left is right, up is down. \nscore adder: +0.5."
			},
			{
				name: 'Hyper Notes',
				value: false,
				conflicts: [],
				multi: 0.009,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 300,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nOF SUGAR\nRUSH',
				explanation: "you're on a sugar crash, you ain't got no funkin' cash. \nscore adder: +0.045. WARNING: IT GETS REALLY HARD AT HIGH VALUES."
			},
			{
				name: 'Eel Notes',
				value: false,
				conflicts: [1, 2, 3, 4, 5],
				multi: 0.01,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 100,
				curValue: 0,
				offAt: 0,
				addChange: 10,
				string: '%\nOF EXTRA\nLENGTH',
				explanation: "when an eel lunges out, and he takes a bite of your snout. \nUSE AT YOUR OWN RISK. TIP: you can hold to possibly win."
			},
			{
				name: 'Stretched',
				value: false,
				conflicts: [],
				multi: 0.001,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 400,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nMORE\nSTRETCHED\n',
				explanation: "damn why they tall... \nscore adder: +0.01 every 10%."
			},
			{
				name: 'Widen',
				value: false,
				conflicts: [],
				multi: 0.001,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 400,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nMORE\nWIDE',
				explanation: "damn why they thicc... \nscore adder: +0.01 every 10%."
			},
			{
				name: 'Jack-TASTIC!',
				value: false,
				conflicts: [],
				multi: 1.5,
				realmulti: 0,
				equation: 'times',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 500,
				curValue: 0,
				offAt: 0,
				addChange: 1,
				string: '\nMORE\nJACK(S)',
				explanation: "ah a a ahh ee ah ah ah jAcktAstIc! \nscore multiplier: x1.5. WARNING: IT'S ABSOLUTE BULLSHIT!"
			},
			{
				name: 'Camera Swing',
				value: false,
				conflicts: [],
				multi: 0.005,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 10000,
				curValue: 0,
				offAt: 0,
				addChange: 10,
				string: '%\nSWING',
				explanation: "how much camera swing bro? \nscore adder: +0.05."
			},
			{
				name: 'Upside Down',
				value: false,
				conflicts: [],
				multi: 0.2,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "upside down. \nscore adder: +0.2."
			},
			{
				name: 'Mirror',
				value: false,
				conflicts: [],
				multi: 0.2,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'switch',
				minValue: 0,
				maxValue: 0,
				curValue: 0,
				offAt: 0,
				addChange: 0,
				string: '',
				explanation: "y'know, Mirror? by Porter Robinson? \nscore adder: +0.2."
			},
			{
				name: 'Camera Spin',
				value: false,
				conflicts: [],
				multi: 0.005,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 10000,
				curValue: 0,
				offAt: 0,
				addChange: 10,
				string: '%\nSPIN',
				explanation: "*insert Klaskii Romper here* \nscore adder: +0.05."
			},
			{
				name: 'EARFQUAKE',
				value: false,
				conflicts: [],
				multi: 0.006,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 500,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nQUAKING',
				explanation: "for real, for real this time... \nscore adder: +0.03."
			},
			{
				name: 'I Love You!',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 5],
				multi: -0.006,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 500,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nMORE LOVE',
				explanation: "you say that to your girlfriend, and she says that back to you. \nscore subtracter: -0.03."
			},
			{
				name: 'Poison Fright',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 5],
				multi: 0.006,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 500,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: '%\nPOISON\nDOSE',
				explanation: "did you consume something that had poison? \nscore adder: +0.03. WARNING: YOU CAN GET BLUEBALLED IF YOU SET IT TOO HIGH."
			},
			{
				name: 'Across the Ass',
				value: false,
				conflicts: [0, 1, 2, 3, 4, 5],
				multi: 0.006,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 500,
				curValue: 0,
				offAt: 0,
				addChange: 5,
				string: "%\nASS\nWHOOPIN'",
				explanation: "bro why yo ass red? \nscore adder: +0.03. WARNING: YOU CAN GET BLUEBALLED IF YOU SET IT TOO HIGH."
			},
			{
				name: 'Stage Fright',
				value: false,
				conflicts: [1, 2, 3, 4, 5],
				multi: 0.05,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 30,
				curValue: 0,
				offAt: 0,
				addChange: 1,
				string: '\nLESS\nMISSES',
				explanation: "shoutout Lil' Diabetes. \nYOU ARE GIVEN 30 MISSES BY 1 LESS MISS. score adder: +0.05."
			},
			{
				name: 'Paparazzi',
				value: false,
				conflicts: [],
				multi: 0.004,
				realmulti: 0,
				equation: '',
				abs: false,
				revAtLow: false,
				type: 'number',
				minValue: 0,
				maxValue: 100,
				curValue: 0,
				offAt: 0,
				addChange: 1,
				string: '\nCAMERAMA(E)N',
				explanation: "i can't believe they exist. \nscore adder: +0.004."
			},
		];

		updateModifiers();
	}
}
