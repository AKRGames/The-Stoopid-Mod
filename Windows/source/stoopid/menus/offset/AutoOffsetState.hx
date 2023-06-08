package stoopid.menus.offset;

import MainVariables;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import stoopid.backend.variables.MainVariables._variables;
import sys.FileSystem;
import sys.io.File;

using StringTools;

/*
 * MADE BY ROZEBUD THE CHAMP P.S. cool code roze
 */
class AutoOffsetState extends MusicBeatState
{
	var easterEgg:Bool = FlxG.random.bool(1);

	public static var forceEasterEgg:Int = 0;

	var font:Array<String> = [Paths.font("comic.ttf"), Paths.font("calibri.ttf")];

	var hitBeats:Int = 0;
	var offsetCalc:Int = 0;
	var offsetTotal:Int = 0;

	var offsetText:FlxText;
	var previousText:FlxText;
	var descText:FlxText;

	var started:Bool = false;
	var endOfSong:Bool = false;
	var ending:Bool = false;
	var canExit:Bool = false;

	var bg:FlxSprite;

	public static var ass:Bool = false;

	var speakers:FlxSprite = new FlxSprite(0, 0);

	override function create()
	{
		// Setup Conductor
		Conductor.changeBPM(100);
		Conductor.songPosition = 0;

		FlxG.sound.music.volume = 0;

		// Cache the 3 2 1 go
		FlxG.sound.cache(Paths.sound('intro3' + (easterEgg ? "-pixel" : ""), "shared"));
		FlxG.sound.cache(Paths.sound('intro2' + (easterEgg ? "-pixel" : ""), "shared"));
		FlxG.sound.cache(Paths.sound('intro1' + (easterEgg ? "-pixel" : ""), "shared"));
		FlxG.sound.cache(Paths.sound('introGo' + (easterEgg ? "-pixel" : ""), "shared"));

		// Easter egg check // a
		easterEgg = false;

		// Init BG
		bg = new FlxSprite(0, 0).loadGraphic(Paths.image('fpsPlus/offsetBG'));
		bg.antialiasing = true;
		bg.active = true;
		bg.screenCenter();
		add(bg);

		// Init Speakers
		speakers.frames = Paths.getSparrowAtlas('fpsPlus/speaker');
		speakers.antialiasing = true;
		speakers.animation.addByIndices('idle', 'BUMP', [3], "", 24, false);
		speakers.animation.addByPrefix('bump', 'BUMP', 24, false);
		speakers.animation.play("idle");
		speakers.screenCenter();
		// speakers.x -= speakers.width / 2;
		// speakers.y -= speakers.height / 2;
		add(speakers);

		// Init Text
		offsetText = new FlxText(0, 235, 1280, "", 50);
		offsetText.scrollFactor.set(0, 0);
		offsetText.setFormat(font[easterEgg ? 1 : 0], 50, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		offsetText.borderSize = 3;
		offsetText.borderQuality = 1;
		offsetText.alpha = 0;

		previousText = new FlxText(0, 400, 1280, "", 50);
		previousText.scrollFactor.set(0, 0);
		previousText.setFormat(font[easterEgg ? 1 : 0], 50, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		previousText.borderSize = 3;
		previousText.borderQuality = 1;
		previousText.alpha = 0;

		descText = new FlxText(320, 540, 600, "tap any key to the beat of the music.\n", 40);
		descText.scrollFactor.set(0, 0);
		descText.setFormat(font[1], 40, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.borderSize = 2;
		descText.borderQuality = 1;
		descText.alpha = 0;

		add(offsetText);
		add(previousText);
		add(descText);

		offsetText.text = "offset\n" + offsetCalc + "ms\n";
		previousText.text = "previous\n0ms\n";

		FlxG.camera.fade(FlxColor.BLACK, 0.5, true, function()
		{
			FlxG.sound.music.volume = 1;
			FlxG.sound.playMusic(Paths.music("fpsPlus/offsetSong" + (easterEgg ? "-pixel" : "")), 1, false);
			FlxG.sound.music.onComplete = exit;

			started = true;

			offsetText.y -= 10;
			offsetText.alpha = 0;
			FlxTween.tween(offsetText, {y: offsetText.y + 10, alpha: 1}, 1, {ease: FlxEase.backOut, startDelay: 0});

			previousText.y -= 10;
			previousText.alpha = 0;
			FlxTween.tween(previousText, {y: previousText.y + 10, alpha: 1}, 1, {ease: FlxEase.backOut, startDelay: 0.6});

			descText.y -= 10;
			descText.alpha = 0;
			FlxTween.tween(descText, {y: descText.y + 10, alpha: 1}, 1, {ease: FlxEase.backOut, startDelay: 1.2});
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (started)
		{
			Conductor.songPosition = FlxG.sound.music.time;
			// trace(Conductor.songPosition);

			if ((FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.ENTER) && canExit)
			{
				endOfSong = true;
				endSong();
			}

			if (FlxG.keys.justPressed.ANY && (Conductor.songPosition >= 4500 && Conductor.songPosition <= 43500) && !(ending || endOfSong))
			{
				hitBeat();
			}

			if (!canExit && Conductor.songPosition >= 2400)
			{
				canExit = true;
				countdown();
			}
		}

		if (Conductor.songPosition >= 43200 && !endOfSong)
		{
			new FlxTimer().start(2.4, function(tmr:FlxTimer)
			{
				endOfSong = true;
				endSong();
			});
		}
	}

	// Cues the 3, 2, 1, GO! sound effects
	function countdown()
	{
		FlxG.sound.play(Paths.sound('intro3' + (easterEgg ? "-pixel" : ""), "shared"), 0.6);
		speakers.animation.play("bump", true);

		new FlxTimer().start(0.6, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('intro2' + (easterEgg ? "-pixel" : ""), "shared"), 0.6);
			speakers.animation.play("bump", true);
		});

		new FlxTimer().start(1.2, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('intro1' + (easterEgg ? "-pixel" : ""), "shared"), 0.6);
			speakers.animation.play("bump", true);
		});

		new FlxTimer().start(1.8, function(tmr:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('introGo' + (easterEgg ? "-pixel" : ""), "shared"), 0.6);
			speakers.animation.play("bump", true);
		});
	}

	function hitBeat():Void
	{
		hitBeats++;
		var offsetAdd = Std.int(Conductor.songPosition % 600);
		offsetAdd = (offsetAdd >= 300) ? offsetAdd - 600 : offsetAdd;
		offsetTotal += offsetAdd;

		offsetCalc = Std.int(offsetTotal / hitBeats);

		offsetText.text = "offset:\n" + offsetCalc + "ms\n";
		previousText.text = "previous:\n" + offsetAdd + "ms\n";

		speakers.animation.play("bump", true);

		trace("Add: " + offsetAdd + "\nTotal: " + offsetTotal + "\noffsetCalc: " + offsetCalc);
	}

	function updateOverrideText():Void
	{
		offsetText.text = "offset:\n" + offsetCalc;
	}

	function endSong():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 2);
		FlxTween.tween(offsetText, {y: offsetText.y - 10, alpha: 0}, 1, {ease: FlxEase.backIn, startDelay: 0.6});
		FlxTween.tween(previousText, {y: previousText.y - 10, alpha: 0}, 1, {ease: FlxEase.backIn, startDelay: 0.3});
		FlxTween.tween(descText, {y: descText.y - 10, alpha: 0}, 1, {ease: FlxEase.backIn, startDelay: 0});
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			exit();
		});
	}

	function exit():Void
	{
		ending = true;
		_variables.noteOffset = offsetCalc;
		MainVariables.Save();

		if (FileSystem.exists(Paths.music('menu/' + _variables.music)))
		{
			FlxG.sound.playMusic(Paths.music('menu/' + _variables.music), _variables.mvolume / 100);
			Conductor.changeBPM(Std.parseFloat(File.getContent('assets/music/menu/' + _variables.music + '_BPM.txt')));
		}
		else
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), _variables.mvolume / 100);
			Conductor.changeBPM(102);
		}

		if (!ass)
			FlxG.switchState(new SettingsState());
		else
			FlxG.switchState(new AfterCallib());
	}
}
