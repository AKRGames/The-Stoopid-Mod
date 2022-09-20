package;

import MainVariables._variables;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class Substate_PresetSaveOK extends MusicBeatSubstate
{
	public static var curSelected:Int = 0;

	var goingBack:Bool = false;

	var camLerp:Float = 0.16;

	var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 1, FlxColor.BLACK);

	var resultText:FlxText;

	var resultName:FlxText;
	var eggText:String = "";

	var eggImage:FlxSprite;

	public function new()
	{
		super();

		add(blackBarThingie);
		blackBarThingie.scrollFactor.set();
		blackBarThingie.scale.y = 750;

		resultText = new FlxText(FlxG.width * 0.7, 5, 1000, "are you sure you want to name your preset this?", 32);
		resultText.setFormat(Paths.font("comic.ttf"), 32, FlxColor.WHITE, RIGHT);
		resultText.alignment = CENTER;
		resultText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		resultText.screenCenter(X);
		resultText.y = 38;
		resultText.scrollFactor.set();
		add(resultText);

		resultName = new FlxText(FlxG.width * 0.7, 5, 1280, Substate_PresetSave.nameResult, 96);
		resultName.setFormat(Paths.font("calibri.ttf"), 50, FlxColor.WHITE, RIGHT);
		resultName.alignment = CENTER;
		resultName.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		resultName.screenCenter();
		resultName.y += 35;
		resultName.scrollFactor.set();
		add(resultName);

		eggText = resultName.text.toLowerCase();

		if (eggText.contains('<') || eggText.contains('>') || eggText.contains('*') || eggText.contains('?') || eggText.contains('/')
			|| eggText.contains(':') || eggText.contains('"'))
		{
			#if windows
			canOK = false;
			resultText.text = "no stop what are you doing don't use *, ?, |, slashes, arrow parenthesis, : and double quotes cuz it doesn't make sense!!!";
			#end
		}

		switch (eggText)
		{
			case 'con' | 'prn' | 'aux' | 'nul' | 'com1' | 'com2' | 'com3' | 'com4' | 'com5' | 'com6' | 'com7' | 'com8' | 'com9' | 'lpt1' | 'lpt2' | 'lpt3' |
				'lpt4' | 'lpt5' | 'lpt6' | 'lpt7' | 'lpt8' | 'lpt9': // what a backdoor
				#if windows
				canOK = false;
				resultText.text = "QUICK THE FBI ARE COMING RENAME IT QUICKLY BY PRESSING BACKSPACE \nAÀAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAƏÆAAAAAA";
				#end
			case 'current':
				canOK = false;
				resultText.text = "don't replace what saves on your way. it'll autosave itself.";
			case 'whose fault':
				Conductor.changeBPM(86);
			case "legion fits in everything":
				FlxG.sound.playMusic(Paths.musicRandom('easterEgg_randomMusic/legion', 1, 3));
			default:
		}

		if (FileSystem.exists(Paths.txt('easterEgg_Data/$eggText')))
		{
			resultText.text = File.getContent(Paths.txt('easterEgg_Data/$eggText'));
		}
		if (FileSystem.exists(Paths.music('easterEgg_Music/$eggText')))
		{
			FlxG.sound.playMusic(Paths.music('easterEgg_Music/$eggText'), _variables.mvolume / 100);
		}
		if (FileSystem.exists(Paths.sound('easterEgg_Sounds/$eggText')))
		{
			FlxG.sound.play(Paths.sound('easterEgg_Sounds/$eggText'), _variables.svolume / 100);
		}
		if (FileSystem.exists('assets/images/easterEgg_Images/$eggText.png'))
		{
			eggImage = new FlxSprite(0, 0).loadGraphic(Paths.image('easterEgg_Images/$eggText'));
			eggImage.antialiasing = true;

			if (eggImage.width <= 256)
				eggImage.antialiasing = false;

			eggImage.setGraphicSize(400);
			eggImage.updateHitbox();

			if (eggImage.height > 400)
			{
				eggImage.setGraphicSize(0, 400);
				eggImage.updateHitbox();
			}
			add(eggImage);

			eggImage.x = 450 - eggImage.width;
			eggImage.y = 270;

			easterImage = true;
		}

		if (easterImage)
		{
			FlxTween.tween(resultName, {size: 40, x: 300, y: 350}, 0.25, {ease: FlxEase.expoOut});
		}
		else
		{
			FlxTween.tween(resultName, {size: 64, y: 280}, 0.25, {ease: FlxEase.expoOut});
		}

		new FlxTimer().start(0.25, function(tmr:FlxTimer)
		{
			selectable = true;
		});
	}

	var selectable:Bool = false;
	var canOK:Bool = true;
	var easterImage:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		blackBarThingie.y = 360 - blackBarThingie.height / 2;
		blackBarThingie.x = 640 - blackBarThingie.width / 2;

		if (selectable && !goingBack)
		{
			if (controls.BACK)
			{
				FlxG.state.closeSubState();
				FlxG.state.openSubState(new Substate_PresetSave());
			}

			if (controls.ACCEPT && canOK)
			{
				switch (eggText)
				{
					case "julyym2612":
						PlayState.SONG = Song.loadFromJson('slapper remix', 'slapper remix');
						LoadingState.loadAndSwitchState(new PlayState());
					default:
						switch (Substate_PresetSave.coming)
						{
							case "Modifiers":
								ModifierVariables.savePreset(eggText);
							case "Marathon":
								MenuMarathon.savePreset(eggText);
							case "Survival":
								MenuSurvival.savePreset(eggText);
						}
				}

				goingBack = true;

				FlxTween.tween(blackBarThingie, {'scale.x': 0}, 0.5, {ease: FlxEase.expoOut});
				FlxTween.tween(resultText, {'scale.x': 0}, 0.5, {ease: FlxEase.expoOut});
				FlxTween.tween(resultName, {'scale.x': 0}, 0.5, {ease: FlxEase.expoOut});
				if (easterImage)
					FlxTween.tween(eggImage, {'scale.x': 0}, 0.5, {ease: FlxEase.expoOut});

				FlxG.sound.play(Paths.sound('confirmMenu'), _variables.svolume / 100);
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					FlxG.state.closeSubState();
					switch (Substate_PresetSave.coming)
					{
						case "Modifiers":
							FlxG.state.openSubState(new Substate_Preset());
						case "Marathon":
							FlxG.state.openSubState(new Marathon_Substate());
						case "Survival":
							FlxG.state.openSubState(new Survival_Substate());
					}
				});
			}
		}
	}
}
