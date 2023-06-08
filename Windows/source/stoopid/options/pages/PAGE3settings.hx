package stoopid.options.pages;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Lib;
import stoopid.backend.system.discord.Discord.DiscordClient;
import stoopid.backend.variables.MainVariables._variables;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class PAGE3settings extends MusicBeatSubstate
{
	var menuItems:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = [
		'page', 'chromakeyM', 'iconZoom', 'cameraZoom', 'cameraSpeed', 'noteSplashes', 'noteGlow', 'eNoteGlow', 'hpIcons', 'hpAnims', 'hpColors',
		'distractions', 'bgAlpha', 'enemyAlpha', 'rainbow', 'missAnims', 'score', 'misses', 'accuracy', 'nps', 'rating', 'timing', 'combo', 'songPos'
	];

	private var grpSongs:FlxTypedGroup<Alphabet>;
	var selectedSomethin:Bool = false;
	var curSelected:Int = 0;
	var camFollow:FlxObject;

	var ResultText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
	var ExplainText:FlxText = new FlxText(20, 69, FlxG.width / 2, "", 48);

	var pause:Int = 0;

	var camLerp:Float = 0.32;

	var navi:FlxSprite;

	var style:Int;

	public function new()
	{
		super();

		persistentDraw = persistentUpdate = true;
		destroySubStates = false;

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('Options_Buttons');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(800, 30 + (i * 160));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " idle", 24, true);
			menuItem.animation.addByPrefix('select', optionShit[i] + " select", 24, true);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
			menuItem.scrollFactor.x = 0;
			menuItem.scrollFactor.y = 1;

			menuItem.x = 2000;
			FlxTween.tween(menuItem, {x: 800}, 0.5, {ease: FlxEase.expoInOut});
		}

		var nTex = Paths.getSparrowAtlas('Options_Navigation');
		navi = new FlxSprite();
		navi.frames = nTex;
		navi.animation.addByPrefix('arrow', "navigation_arrows", 24, true);
		navi.animation.addByPrefix('enter', "navigation_enter", 24, true);
		navi.animation.addByPrefix('shiftArrow', "navigation_shiftArrow", 24, true);
		navi.animation.play('arrow');
		navi.scrollFactor.set();
		add(navi);
		navi.y = 700 - navi.height;
		navi.x = 1260 - navi.width;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		changeItem();

		createResults();

		FlxG.camera.follow(camFollow, null, camLerp);
		FlxG.camera.zoom = 1;

		if (!FlxG.sound.music.playing)
		{
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
		}

		DiscordClient.changePresence("settings page: graphics", null);
	}

	function createResults():Void
	{
		add(ResultText);
		ResultText.scrollFactor.x = 0;
		ResultText.scrollFactor.y = 0;
		ResultText.setFormat("Calibri", 45, FlxColor.WHITE, CENTER);
		ResultText.x = -400;
		ResultText.y = 350;
		ResultText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		ResultText.alpha = 0;
		FlxTween.tween(ResultText, {alpha: 1}, 0.15, {ease: FlxEase.expoOut});

		add(ExplainText);
		ExplainText.scrollFactor.x = 0;
		ExplainText.scrollFactor.y = 0;
		ExplainText.setFormat("Comic Sans MS", 20, FlxColor.WHITE, CENTER);
		ExplainText.alignment = LEFT;
		ExplainText.x = 20;
		ExplainText.y = 632;
		ExplainText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		ExplainText.alpha = 0;
		FlxTween.tween(ExplainText, {alpha: 1}, 0.15, {ease: FlxEase.expoOut});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
				changeItem(1);
			}

			if (controls.LEFT_P)
			{
				changePress(-1);
			}

			if (controls.RIGHT_P)
			{
				changePress(1);
			}

			if (controls.LEFT)
			{
				changeHold(-1);
			}

			if (controls.RIGHT)
			{
				changeHold(1);
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'chromakeyM')
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
					selectedSomethin = true;

					menuItems.forEach(function(spr:FlxSprite)
					{
						spr.animation.play('idle');
						FlxTween.tween(spr, {x: -1000}, 0.25, {ease: FlxEase.expoOut});
					});

					FlxTween.tween(ResultText, {alpha: 0}, 0.15, {ease: FlxEase.expoOut});
					FlxTween.tween(ExplainText, {alpha: 0}, 0.15, {ease: FlxEase.expoOut});

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						FlxG.sound.music.fadeOut(0, 0);
						FlxG.sound.music.stop();
						navi.kill();
						openSubState(new ChromaSettings());
					});
				}
			}

			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume / 100);
				selectedSomethin = true;

				DiscordClient.changePresence("they headin out", null);

				menuItems.forEach(function(spr:FlxSprite)
				{
					spr.animation.play('idle');
					FlxTween.tween(spr, {x: -1000}, 0.15, {ease: FlxEase.expoIn});
				});

				FlxTween.tween(FlxG.camera, {zoom: 2.5}, 1, {ease: FlxEase.expoIn, startDelay: 0.2});
				FlxTween.tween(ResultText, {alpha: 0}, 0.25, {ease: FlxEase.expoIn});
				FlxTween.tween(ExplainText, {alpha: 0}, 0.25, {ease: FlxEase.expoIn});

				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					FlxG.switchState(new MainMenuState());
				});
			}
		}

		switch (optionShit[curSelected])
		{
			case "score":
				ResultText.text = Std.string(_variables.scoreDisplay).toUpperCase();
				ExplainText.text = "SCORE DISPLAY:\nyou wanna see your score or not?";
			case "misses":
				ResultText.text = Std.string(_variables.missesDisplay).toUpperCase();
				ExplainText.text = "MISS COUNTER:\nyou wanna see how many misses you got or not?";
			case "accuracy":
				ResultText.text = Std.string(_variables.accuracyDisplay).toUpperCase();
				ExplainText.text = "ACCURACY DISPLAY:\nyou wanna see how accurate you are or not?";
			case "page":
				ResultText.text = "";
				ExplainText.text = "previous page: SOUNDS \nnext page: GAMEPLAY";
			case "rating":
				ResultText.text = Std.string(_variables.ratingDisplay).toUpperCase();
				ExplainText.text = "RATING DISPLAY:\nyou wanna see your rating or not?";
			case "combo":
				ResultText.text = Std.string(_variables.comboDisplay).toUpperCase();
				ExplainText.text = "COMBO COUNTER:\nyou wanna see your combo or not?";
			case "timing":
				ResultText.text = Std.string(_variables.timingDisplay).toUpperCase();
				ExplainText.text = "TIMING DISPLAY:\nyou wanna see your timing or not?";
			case "iconZoom":
				ResultText.text = _variables.iconZoom + "ZOOM";
				ExplainText.text = "ICON ZOOM:\nhow much ZOOM you want your icons to be bro?";
			case "cameraZoom":
				ResultText.text = _variables.cameraZoom + "ZOOM";
				ExplainText.text = "CAMERA ZOOM:\nhow much ZOOM you want the camera to be bro?";
			case "cameraSpeed":
				ResultText.text = _variables.cameraSpeed + "SPEED";
				ExplainText.text = "CAMERA SPEED:\nhow much SPEED you want the camera to be bro?";
			case "songPos":
				ResultText.text = Std.string(_variables.songPosition).toUpperCase();
				ExplainText.text = "SONG POSITION DISPLAY:\nyou wanna see how far are you into the song or not?";
			case "nps":
				ResultText.text = Std.string(_variables.nps).toUpperCase();
				ExplainText.text = "NOTES PER SECOND DISPLAY:\nyou wanna see how much notes you hit per second or not?";
			case "rainbow":
				ResultText.text = Std.string(_variables.rainbow).toUpperCase();
				ExplainText.text = "RAINBOW FPS COUNTER:\npretty colors...";
			case "distractions":
				ResultText.text = Std.string(_variables.distractions).toUpperCase();
				ExplainText.text = "DISTRACTIONS:\nyou wanna get distracted or not?";
			case "chromakeyM":
				ResultText.text = "";
				ExplainText.text = "GREENSCREEN (smb funk mix reference): \nget yourself some chroma key bro!";
			case "bgAlpha":
				ResultText.text = _variables.bgAlpha * 100 + "%";
				ExplainText.text = "BACKGROUND ALPHA:\nhow much background transparency bro?";
			case "noteSplashes":
				ResultText.text = Std.string(_variables.noteSplashes).toUpperCase();
				ExplainText.text = "NOTE SPLASHES:\nsplashy splashy!";
			case "noteGlow":
				ResultText.text = Std.string(_variables.noteGlow).toUpperCase();
				ExplainText.text = "NOTE GLOW:\nglowy glowy!";
			case "eNoteGlow":
				ResultText.text = Std.string(_variables.eNoteGlow).toUpperCase();
				ExplainText.text = "ENEMY NOTE GLOW:\nAPPLIES ONLY FOR UPSCROLL AND DOWNSCROLL.\nevil glowy glowy!";
			case "enemyAlpha":
				ResultText.text = _variables.enemyAlpha * 100 + "%";
				ExplainText.text = "ENEMY NOTE ALPHA:\nAPPLIES  ONLY FOR LEFTSCROLL AND RIGHTSCROLL.\nhow much opponent note transparency bro?";
			case "missAnims":
				ResultText.text = Std.string(_variables.missAnims).toUpperCase();
				ExplainText.text = "MISS ANIMATIONS:\nyou want to see him miss or not?";
			case "hpColors":
				ResultText.text = Std.string(_variables.hpColors).toUpperCase();
				ExplainText.text = "HEALTH BAR COLORS:\nyou wanna see how flexible the health bar colors can be or not?";
			case "hpIcons":
				ResultText.text = Std.string(_variables.hpIcons).toUpperCase();
				ExplainText.text = "HEALTH ICONS:\nyou wanna see them cute icons or not?";
			case "hpAnims":
				ResultText.text = Std.string(_variables.hpAnims).toUpperCase();
				ExplainText.text = "HEALTH ICON ANIMATIONS:\nyou wanna see them cute icons get animated or not?";
		}

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.scale.set(FlxMath.lerp(spr.scale.x, 0.5, camLerp / (_variables.fps / 60)), FlxMath.lerp(spr.scale.y, 0.5, 0.4 / (_variables.fps / 60)));

			if (spr.ID == curSelected)
			{
				camFollow.y = FlxMath.lerp(camFollow.y, spr.getGraphicMidpoint().y, camLerp / (_variables.fps / 60));
				camFollow.x = spr.getGraphicMidpoint().x;
				spr.scale.set(FlxMath.lerp(spr.scale.x, 0.9, camLerp / (_variables.fps / 60)), FlxMath.lerp(spr.scale.y, 0.9, 0.4 / (_variables.fps / 60)));
			}

			spr.updateHitbox();
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('select');
			}

			spr.updateHitbox();
		});

		switch (optionShit[curSelected])
		{
			case 'cameraSpeed' | 'iconZoom' | 'cameraZoom' | 'bgAlpha':
				navi.animation.play('shiftArrow');
			case 'chromakeyM':
				navi.animation.play('enter');
			default:
				navi.animation.play('arrow');
		}
	}

	function changePress(Change:Int = 0)
	{
		switch (optionShit[curSelected])
		{
			case 'page':
				SettingsState.page += Change;
				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
				selectedSomethin = true;

				menuItems.forEach(function(spr:FlxSprite)
				{
					spr.animation.play('idle');
					FlxTween.tween(spr, {x: -1000}, 0.25, {ease: FlxEase.expoOut});
				});

				FlxTween.tween(ResultText, {alpha: 0}, 0.15, {ease: FlxEase.expoOut});
				FlxTween.tween(ExplainText, {alpha: 0}, 0.15, {ease: FlxEase.expoOut});

				new FlxTimer().start(0.25, function(tmr:FlxTimer)
				{
					navi.kill();
					menuItems.kill();
					if (Change == 1)
						openSubState(new PAGE4settings());
					else
						openSubState(new PAGE2settings());
				});
			case "score":
				_variables.scoreDisplay = !_variables.scoreDisplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "misses":
				_variables.missesDisplay = !_variables.missesDisplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "missAnims":
				_variables.missAnims = !_variables.missAnims;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "songPos":
				_variables.songPosition = !_variables.songPosition;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "distractions":
				_variables.distractions = !_variables.distractions;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "accuracy":
				_variables.accuracyDisplay = !_variables.accuracyDisplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "rainbow":
				_variables.rainbow = !_variables.rainbow;

				if (!_variables.rainbow)
					(cast(Lib.current.getChildAt(0), Main)).changeColor(0xFFFFFFFF);

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "rating":
				_variables.ratingDisplay = !_variables.ratingDisplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "timing":
				_variables.timingDisplay = !_variables.timingDisplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "combo":
				_variables.comboDisplay = !_variables.comboDisplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "nps":
				_variables.nps = !_variables.nps;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "noteSplashes":
				_variables.noteSplashes = !_variables.noteSplashes;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "noteGlow":
				_variables.noteGlow = !_variables.noteGlow;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "eNoteGlow":
				_variables.eNoteGlow = !_variables.eNoteGlow;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "hpAnims":
				_variables.hpAnims = !_variables.hpAnims;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "hpIcons":
				_variables.hpIcons = !_variables.hpIcons;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "iconZoom":
				if (controls.CENTER)
					Change *= 2;

				_variables.iconZoom += FlxMath.roundDecimal(Change / 10, 2);
				if (_variables.iconZoom < 0)
					_variables.iconZoom = 0;

				_variables.iconZoom = FlxMath.roundDecimal(_variables.iconZoom, 2);

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "cameraZoom":
				if (controls.CENTER)
					Change *= 2;

				_variables.cameraZoom += FlxMath.roundDecimal(Change / 10, 2);
				if (_variables.cameraZoom < 0)
					_variables.cameraZoom = 0;

				_variables.cameraZoom = FlxMath.roundDecimal(_variables.cameraZoom, 2);

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "cameraSpeed":
				if (controls.CENTER)
					Change *= 2;

				_variables.cameraSpeed += FlxMath.roundDecimal(Change / 10, 2);
				if (_variables.cameraSpeed < 0.1)
					_variables.cameraSpeed = 0.1;

				_variables.cameraSpeed = FlxMath.roundDecimal(_variables.cameraSpeed, 2);

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "hpColors":
				_variables.hpColors = !_variables.hpColors;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
		}

		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			MainVariables.Save();
		});
	}

	function changeHold(Change:Int = 0)
	{
		if (controls.CENTER)
			Change *= 2;

		switch (optionShit[curSelected])
		{
			case "bgAlpha":
				_variables.bgAlpha += Change / 100;
				_variables.bgAlpha = FlxMath.roundDecimal(_variables.bgAlpha, 3);

				if (_variables.bgAlpha < 0)
					_variables.bgAlpha = 0;
				if (_variables.bgAlpha > 1)
					_variables.bgAlpha = 1;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "enemyAlpha":
				_variables.enemyAlpha += Change / 100;
				_variables.enemyAlpha = FlxMath.roundDecimal(_variables.enemyAlpha, 3);

				if (_variables.enemyAlpha < 0)
					_variables.enemyAlpha = 0;
				if (_variables.enemyAlpha > 1)
					_variables.enemyAlpha = 1;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
		}

		new FlxTimer().start(0.2, function(tmr:FlxTimer)
		{
			MainVariables.Save();
		});
	}

	override function openSubState(SubState:FlxSubState)
	{
		super.openSubState(SubState);
	}
}
