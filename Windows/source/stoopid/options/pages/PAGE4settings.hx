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
import stoopid.backend.system.discord.Discord.DiscordClient;
import stoopid.backend.variables.MainVariables._variables;

using StringTools;

class PAGE4settings extends MusicBeatSubstate
{
	var menuItems:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = [
		'page', 'speed', 'offset', 'scroll', 'guitar', 'spam', 'ghostTapping', 'botplay', 'autoPause', 'pauseCountdown', 'resetButton', 'cheatButton',
		'lateD', 'accuType', 'combo+', 'comboH', '5k', 'cutscene', 'skip', 'skipCS'
	];

	private var grpSongs:FlxTypedGroup<Alphabet>;
	var selectedSomethin:Bool = false;
	var curSelected:Int = 0;
	var camFollow:FlxObject;

	var ResultText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
	var ExplainText:FlxText = new FlxText(20, 69, FlxG.width / 2, "", 48);

	var pause:Int = 0;

	var camLerp:Float = 0.32;

	var acc:Float;
	var scr:Float;

	var navi:FlxSprite;

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
			var menuItem:FlxSprite = new FlxSprite(950, 30 + (i * 160));
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
		navi.animation.addByPrefix('shiftArrow', "navigation_shiftArrow", 24, true);
		navi.animation.addByPrefix('enter', "navigation_enter", 24, true);
		navi.animation.addByPrefix('both', "navigation_both", 24, true);
		navi.animation.addByPrefix('shiftBoth', "navigation_shiftBoth", 24, true);
		navi.animation.play('arrow');
		navi.scrollFactor.set();
		add(navi);
		navi.y = 700 - navi.height;
		navi.x = 1260 - navi.width;

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		changeItem();

		createResults();

		updateResults();

		FlxG.camera.follow(camFollow, null, camLerp);
		FlxG.camera.zoom = 1;

		DiscordClient.changePresence("settings page: gameplay", null);
	}

	function updateResults():Void
	{
		switch (_variables.accuracyType)
		{
			case 'simple':
				acc = 0;
			case 'rating-based':
				acc = 1;
			case 'complex':
				acc = 2;
		}

		switch (_variables.scroll)
		{
			case 'up':
				scr = 0;
			case 'down':
				scr = 1;
			case 'left':
				scr = 2;
			case 'right':
				scr = 3;
		}
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

			if (controls.ACCEPT && optionShit[curSelected] == "offset")
			{
				FlxG.switchState(new AutoOffsetState());
			}

			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume / 100);
				selectedSomethin = true;

				DiscordClient.changePresence("they headin out", null);

				menuItems.forEach(function(spr:FlxSprite)
				{
					spr.animation.play('idle');
					FlxTween.tween(spr, {x: -1000}, 0.5, {ease: FlxEase.expoIn});
				});

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
			case "offset":
				ResultText.text = _variables.noteOffset + " ms";
				ExplainText.text = "NOTE OFFSET:\nhow much the notes get offset bro?\nif you don't know, press ENTER to get calibrated.";
			case "page":
				ResultText.text = "";
				ExplainText.text = "previous page: GRAPHICS \nnext page: MISCELLANEOUS";
			case "spam":
				ResultText.text = Std.string(_variables.spamPrevention).toUpperCase();
				ExplainText.text = "SPAM PREVENTION:\nyou wanna spam or not? (false = you can spam)";
			case "accuType":
				ResultText.text = _variables.accuracyType;
				ExplainText.text = "ACCURACY TYPE:\nwhat do you want the accuarcy to be like: simple, rating-based, or complex?";
			case "combo+":
				ResultText.text = Std.string(_variables.comboP).toUpperCase();
				ExplainText.text = "COMBO+:\nyou want your combo to have to do with your score or not?";
			case "comboH":
				ResultText.text = Std.string(_variables.comboH).toUpperCase();
				ExplainText.text = "COMBO HEALTH:\nyou want your combo to have to do with your health or not?";
			case "cutscene":
				ResultText.text = Std.string(_variables.cutscene).toUpperCase();
				ExplainText.text = "CUTSCENES:\nyou want your Story Mode cutscenes or not?";
			case "lateD":
				ResultText.text = Std.string(_variables.lateD).toUpperCase();
				ExplainText.text = "LATE DAMAGE:\nyou want your health to go down because of you hitting a note too late or not?";
			case "scroll":
				ResultText.text = _variables.scroll.toUpperCase();
				ExplainText.text = "SCROLL:\nwhere do you want the notes to scroll?";
			case "guitar":
				ResultText.text = Std.string(_variables.guitarSustain).toUpperCase();
				ExplainText.text = "GUITAR SUSTAIN:\nyou wanna get rid of the hold lines of the notes when you miss them or not?";
			case "5k":
				ResultText.text = Std.string(_variables.fiveK).toUpperCase();
				ExplainText.text = "5K LAYOUT:\nyou wanna add an extra key or not?";
			case "skip":
				ResultText.text = Std.string(_variables.skipGO).toUpperCase();
				ExplainText.text = "SKIP GAME OVER:\nyou wanna skip you getting blueballed or not?";
			case "botplay":
				ResultText.text = Std.string(_variables.botplay).toUpperCase();
				ExplainText.text = "BOTPLAY:\ntake a break, and watch a bot play for you.";
			case "autoPause":
				ResultText.text = Std.string(_variables.autoPause).toUpperCase();
				ExplainText.text = "AUTO PAUSE:\nyou wanna pause the game when you tab out or not?";
			case "pauseCountdown":
				ResultText.text = Std.string(_variables.pauseCountdown).toUpperCase();
				ExplainText.text = "PAUSE COUNTDOWN:\nyou wanna have a countdown when you hit resume?";
			case "resetButton":
				ResultText.text = Std.string(_variables.resetButton).toUpperCase();
				ExplainText.text = "RESET BUTTON:\nyou wanna get blueballed on purpose or not?";
			case "cheatButton":
				ResultText.text = Std.string(_variables.cheatButton).toUpperCase();
				ExplainText.text = "CHEAT BUTTON:\nwhen things are getting tough, we've got your back.";
			case "ghostTapping":
				ResultText.text = Std.string(_variables.ghostTapping).toUpperCase();
				ExplainText.text = "GHOST TAPPING:\nyou wanna ghost tap or not?";
			case "speed":
				if (_variables.speed != 0)
					ResultText.text = Std.string(_variables.speed);
				else
					ResultText.text = 'CHART DEPENDANT';
				ExplainText.text = "NOTE SPEED:\nhow much SPEED you want the notes to go bro?";
			case "skipCS":
				if (_variables.skipCS == 0)
					ResultText.text = 'ALWAYS';
				else if (_variables.skipCS == -1)
					ResultText.text = 'NEVER';
				else
					ResultText.text = Std.string(_variables.skipCS) + " DEATH(S)";

				ExplainText.text = "SKIP CUTSCENES AFTER DEATH:\nyou wanna skip cutscenes after you get blueballed? if so, after how much blueballs bro?";
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
			case 'offset':
				navi.animation.play('shiftBoth');
			case 'speed':
				navi.animation.play('shiftArrow');
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
						openSubState(new PAGE5settings());
					else
						openSubState(new PAGE3settings());
				});
			case "spam":
				_variables.spamPrevention = !_variables.spamPrevention;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "autoPause":
				_variables.autoPause = !_variables.autoPause;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "pauseCountdown":
				_variables.pauseCountdown = !_variables.pauseCountdown;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "combo+":
				_variables.comboP = !_variables.comboP;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "comboH":
				_variables.comboH = !_variables.comboH;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "cutscene":
				_variables.cutscene = !_variables.cutscene;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "lateD":
				_variables.lateD = !_variables.lateD;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "guitar":
				_variables.guitarSustain = !_variables.guitarSustain;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "5k":
				_variables.fiveK = !_variables.fiveK;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "skip":
				_variables.skipGO = !_variables.skipGO;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "botplay":
				_variables.botplay = !_variables.botplay;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "resetButton":
				_variables.resetButton = !_variables.resetButton;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "cheatButton":
				_variables.cheatButton = !_variables.cheatButton;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "ghostTapping":
				_variables.ghostTapping = !_variables.ghostTapping;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "accuType":
				acc += Change;
				if (acc > 2)
					acc = 0;
				if (acc < 0)
					acc = 2;

				switch (acc)
				{
					case 0:
						_variables.accuracyType = 'simple';
					case 1:
						_variables.accuracyType = 'rating-based';
					case 2:
						_variables.accuracyType = 'complex';
				}

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "scroll":
				scr += Change;
				if (scr > 3)
					scr = 0;
				if (scr < 0)
					scr = 3;

				switch (scr)
				{
					case 0:
						_variables.scroll = 'up';
					case 1:
						_variables.scroll = 'down';
					case 2:
						_variables.scroll = 'left';
					case 3:
						_variables.scroll = 'right';
				}

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "speed":
				if (controls.CENTER)
					Change *= 2;

				_variables.speed += Change * 0.1;
				_variables.speed = FlxMath.roundDecimal(_variables.speed, 2);

				if (_variables.speed > 8)
					_variables.speed = 8;
				if (_variables.speed < 0)
					_variables.speed = 0;

				FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);
			case "skipCS":
				_variables.skipCS += Change;

				if (_variables.skipCS > 20)
					_variables.skipCS = 20;
				if (_variables.skipCS < -1)
					_variables.skipCS = -1;

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
			case "offset":
				_variables.noteOffset += Change;
				if (_variables.noteOffset < -300)
					_variables.noteOffset = -300;
				if (_variables.noteOffset > 300)
					_variables.noteOffset = 300;

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
