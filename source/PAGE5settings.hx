package;

import Discord.DiscordClient;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import MainVariables._variables;
import flixel.tweens.FlxEase;

using StringTools;

class PAGE5settings extends MusicBeatSubstate
{
	var menuItems:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = ['page', 'keybinds', 'gameplay', 'chart', 'animation'];

	private var grpSongs:FlxTypedGroup<Alphabet>;
	var selectedSomethin:Bool = false;
	var curSelected:Int = 0;
	var camFollow:FlxObject;

	var ResultText:FlxText = new FlxText(20, 69, FlxG.width, "", 48);
	var ExplainText:FlxText = new FlxText(20, 69, FlxG.width / 2, "", 48);

	var camLerp:Float = 0.32;

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
			FlxTween.tween(menuItem, {x: 800}, 0.15, {ease: FlxEase.expoInOut});
		}

		var nTex = Paths.getSparrowAtlas('Options_Navigation');
		navi = new FlxSprite();
		navi.frames = nTex;
		navi.animation.addByPrefix('arrow', "navigation_arrows", 24, true);
		navi.animation.addByPrefix('enter', "navigation_enter", 24, true);
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

		DiscordClient.changePresence("Settings page: Miscellaneous", null);
	}

	function createResults():Void
	{
		add(ResultText);
		ResultText.scrollFactor.x = 0;
		ResultText.scrollFactor.y = 0;
		ResultText.setFormat("Comic Sans MS", 45, FlxColor.WHITE, CENTER);
		ResultText.x = -400;
		ResultText.y = 350;
		ResultText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		ResultText.alpha = 0;
		FlxTween.tween(ResultText, {alpha: 1}, 0.15, {ease: FlxEase.expoInOut});

		add(ExplainText);
		ExplainText.scrollFactor.x = 0;
		ExplainText.scrollFactor.y = 0;
		ExplainText.setFormat("Comic Sans MS", 20, FlxColor.WHITE, CENTER);
		ExplainText.alignment = LEFT;
		ExplainText.x = 20;
		ExplainText.y = 625;
		ExplainText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		ExplainText.alpha = 0;
		FlxTween.tween(ExplainText, {alpha: 1}, 0.15, {ease: FlxEase.expoInOut});
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

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] != 'page')
				{
					FlxG.sound.play(Paths.sound('confirmMenu'), _variables.svolume / 100);
					selectedSomethin = true;

					DiscordClient.changePresence("Time to go in!", null);

					menuItems.forEach(function(spr:FlxSprite)
					{
						spr.animation.play('idle');
						FlxTween.tween(spr, {x: -1000}, 0.15, {ease: FlxEase.expoIn});
					});

					FlxTween.tween(FlxG.camera, {zoom: 7}, 0.5, {ease: FlxEase.expoIn, startDelay: 0.2});
					FlxTween.tween(ResultText, {alpha: 0}, 0.15, {ease: FlxEase.expoIn});
					FlxTween.tween(ExplainText, {alpha: 0}, 0.15, {ease: FlxEase.expoIn});

					new FlxTimer().start(0.3, function(tmr:FlxTimer)
					{
						switch (optionShit[curSelected])
						{
							case 'animation':
								FlxG.switchState(new AnimationDebug());

								DiscordClient.changePresence("offset message.", null);
							case 'chart':
								FlxG.switchState(new ChartingState());

								DiscordClient.changePresence("charting a song.", null);
							case 'gameplay':
								FlxG.switchState(new GameplayCustomizeState());
							case 'keybinds':
								FlxG.switchState(new MenuControls());

								DiscordClient.changePresence("keybinds.", null);
						}
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

				FlxTween.tween(FlxG.camera, {zoom: 7}, 0.5, {ease: FlxEase.expoIn, startDelay: 0.2});
				FlxTween.tween(ResultText, {alpha: 0}, 0.15, {ease: FlxEase.expoIn});
				FlxTween.tween(ExplainText, {alpha: 0}, 0.15, {ease: FlxEase.expoIn});

				new FlxTimer().start(0.3, function(tmr:FlxTimer)
				{
					FlxG.switchState(new MainMenuState());
				});
			}
		}

		switch (optionShit[curSelected])
		{
			case "page":
				ResultText.text = "";
				ExplainText.text = "previous page: GAMEPLAY \nnext page: CLEAR";
			case "gameplay":
				ResultText.text = "";
				ExplainText.text = "customize your gameplay.";
			case "animation":
				ResultText.text = "";
				ExplainText.text = "animation offsets and shit.";
			case "chart":
				ResultText.text = "";
				ExplainText.text = "GO ON THE CHART EDITOR. \n(this is a message from Stoopid Guy to the creator)";
			case "keybinds":
				ResultText.text = "";
				ExplainText.text = "the binding of keys.";
		}

		switch (optionShit[curSelected])
		{
			case 'gameplay' | 'animation' | 'chart' | 'keybinds':
				navi.animation.play('enter', true);
			default:
				navi.animation.play('arrow', true);
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
					FlxTween.tween(spr, {x: -1000}, 0.15, {ease: FlxEase.expoIn});
				});

				FlxTween.tween(ResultText, {alpha: 0}, 0.15, {ease: FlxEase.expoIn});
				FlxTween.tween(ExplainText, {alpha: 0}, 0.15, {ease: FlxEase.expoIn});

				new FlxTimer().start(0.2, function(tmr:FlxTimer)
				{
					navi.kill();
					menuItems.kill();
					if (Change == 1)
						openSubState(new PAGE6settings());
					else
						openSubState(new PAGE4settings());
				});
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
