package stoopid.menus.week;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.util.FlxTimer;
import stoopid.backend.system.discord.Discord.DiscordClient;
import stoopid.backend.variables.MainVariables._variables;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class MenuWeek extends MusicBeatState
{
	var scoreText:FlxText;

	var weekData:Array<Dynamic> = [['Tutorial'], ["Synthwave Type Beat"]];

	var curWeekData:Array<Dynamic> = [];

	public static var curDifficulty:Int = 2;

	public static var weekUnlocked:Array<Bool> = [true, true];

	var weekCharacters:Array<String> = ["gf", "stoopid guy"];

	var weekNames:Array<String> = ["Tutorial", "The STOOPID Week!!"];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;

	var sprDifficulty:FlxSprite;

	var bg:FlxSprite = new FlxSprite(-89).loadGraphic(Paths.image('wBG_Main'));
	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Week_Checker'));
	var gradientBar:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);
	var side:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Week_Top'));
	var bottom:FlxSprite = new FlxSprite(0).loadGraphic(Paths.image('Week_Bottom'));
	var boombox:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('Boombox'));

	var rankTable:Array<String> = [
		'P-small', 'X-small', 'X--small', 'SS+-small', 'SS-small', 'SS--small', 'S+-small', 'S-small', 'S--small', 'A+-small', 'A-small', 'A--small',
		'B-small', 'C-small', 'D-small', 'E-small', 'NA'
	];
	var ranks:FlxTypedGroup<FlxSprite>;

	var characterUI:FlxSprite = new FlxSprite(20, 20);

	override function create()
	{
		lime.app.Application.current.window.title = lime.app.Application.current.meta.get('name');

		ranks = new FlxTypedGroup<FlxSprite>();

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
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
		}

		persistentUpdate = persistentDraw = true;

		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.alpha = 1;
		add(bg);

		gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55F8FFAB, 0xAAFFDEF2], 1, 90, true);
		gradientBar.y = FlxG.height - gradientBar.height;
		add(gradientBar);
		gradientBar.scrollFactor.set(0, 0);

		add(checker);
		checker.scrollFactor.set(0, 0.07);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, 40, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;
			// weekThing.updateHitbox();
		}

		side.scrollFactor.x = 0;
		side.scrollFactor.y = 0;
		side.antialiasing = true;
		side.screenCenter();
		add(side);
		side.y = 0;
		side.x = FlxG.width / 2 - side.width / 2;

		bottom.scrollFactor.x = 0;
		bottom.scrollFactor.y = 0;
		bottom.antialiasing = true;
		bottom.screenCenter();
		add(bottom);
		bottom.y = FlxG.height - bottom.height;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 42);
		scoreText.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		scoreText.alignment = CENTER;
		scoreText.setFormat("Comic Sans MS", 42);
		scoreText.screenCenter(X);
		scoreText.y = 10;

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("Comic Sans MS", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alignment = CENTER;
		txtWeekTitle.screenCenter(X);
		txtWeekTitle.y = scoreText.y + scoreText.height + 5;
		txtWeekTitle.alpha = 0;

		trace("Line 96");

		trace("Line 124");

		var diffTex = Paths.getSparrowAtlas('difficulties');
		sprDifficulty = new FlxSprite(0, 20);
		sprDifficulty.frames = diffTex;
		sprDifficulty.animation.addByPrefix('noob', 'NOOB');
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.addByPrefix('expert', 'EXPERT');
		sprDifficulty.animation.addByPrefix('insane', 'INSANE');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		add(sprDifficulty);
		sprDifficulty.screenCenter(X);

		add(ranks);

		trace("Line 150");

		txtTracklist = new FlxText(FlxG.width * 0.05, 200, 0, "THE BANGERS:\n\n", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = Paths.font("calibri.ttf");
		txtTracklist.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		txtTracklist.color = 0xFFFCB697;
		txtTracklist.y = characterUI.y + 420;
		add(txtTracklist);
		add(scoreText);
		add(txtWeekTitle);

		var tex = Paths.getSparrowAtlas('Week_CharUI');
		characterUI.frames = tex;
		characterUI.x = FlxG.width;
		characterUI.antialiasing = true;
		add(characterUI);

		updateText();
		changeWeek();

		trace("Line 165");

		super.create();

		scoreText.alpha = sprDifficulty.alpha = characterUI.alpha = 1;
		txtWeekTitle.alpha = 0.75;

		FlxG.camera.zoom = 1;
		FlxG.camera.alpha = 1;

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			selectable = true;
		});
	}

	var selectable:Bool = false;

	override function update(elapsed:Float)
	{
		checker.x -= -0.12 / (_variables.fps / 60);
		checker.y -= -0.34 / (_variables.fps / 60);

		boombox.screenCenter();

		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5 / (_variables.fps / 60)));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE: " + lerpScore;

		scoreText.x = side.x + side.width / 2 - scoreText.width / 2;

		// FlxG.watch.addQuick('font', scoreText.font);

		if (!selectedSomethin && selectable)
		{
			if (controls.UP_P)
			{
				changeWeek(-1);
			}

			if (controls.DOWN_P)
			{
				changeWeek(1);
			}

			if (controls.RIGHT_P)
				changeDifficulty(1);
			if (controls.LEFT_P)
				changeDifficulty(-1);

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !selectedSomethin && selectable)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'), _variables.svolume / 100);
			selectedSomethin = true;
			FlxG.switchState(new PlaySelection());

			DiscordClient.changePresence("they headin' out", null);

			// FlxG.camera.fade(FlxColor.BLACK, 0.375);
			// FlxTween.tween(bg, {alpha: 0}, 0.5, {ease: FlxEase.expoOut});
			// FlxTween.tween(checker, {alpha: 0}, 0.25, {ease: FlxEase.expoOut});
			// FlxTween.tween(gradientBar, {alpha: 0}, 0.25, {ease: FlxEase.expoOut});
			// FlxTween.tween(side, {alpha: 0}, 0.25, {ease: FlxEase.expoOut});
			// FlxTween.tween(bottom, {alpha: 0}, 0.25, {ease: FlxEase.expoOut});
		}

		super.update(elapsed);
	}

	var selectedSomethin:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			FlxG.sound.play(Paths.sound('confirmMenu'), _variables.svolume / 100);

			grpWeekText.members[curWeek].startFlashing();

			PlayState.storyPlaylist = weekData[curWeek];
			LoadingState.no = weekData[curWeek];
			trace(PlayState.storyPlaylist);
			PlayState.gameplayArea = "Story";
			selectedSomethin = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-noob';
				case 1:
					diffic = '-easy';
				case 3:
					diffic = '-hard';
				case 4:
					diffic = '-expert';
				case 5:
					diffic = '-insane';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;

			FlxG.camera.fade(FlxColor.BLACK, 0.25);
			FlxTween.tween(checker, {alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(characterUI, {alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(txtTracklist, {alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(gradientBar, {alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(side, {alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(bottom, {alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(scoreText, {y: -50, alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(txtWeekTitle, {y: -50, alpha: 0}, 1, {ease: FlxEase.quintIn});
			FlxTween.tween(sprDifficulty, {y: -69, alpha: 0}, 1, {ease: FlxEase.quintIn});

			for (item in ranks.members)
			{
				FlxTween.tween(item, {x: 2023}, 1, {ease: FlxEase.expoIn});
			}

			DiscordClient.changePresence("they choosing a chart type", null);

			for (item in grpWeekText.members)
			{
				FlxTween.tween(item, {alpha: 0}, 1, {ease: FlxEase.expoOut});
			}

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				FlxG.state.openSubState(new Substate_ChartType());
			});
		}
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 5;
		if (curDifficulty > 5)
			curDifficulty = 0;

		updateRank();

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('noob');
			case 1:
				sprDifficulty.animation.play('easy');
			case 2:
				sprDifficulty.animation.play('normal');
			case 3:
				sprDifficulty.animation.play('hard');
			case 4:
				sprDifficulty.animation.play('expert');
			case 5:
				sprDifficulty.animation.play('insane');
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = txtWeekTitle.y + 5;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		DiscordClient.changePresence("they on the verge of selecting week " + curWeek + " on " + sprDifficulty.animation.name + "!!", null);

		FlxTween.tween(sprDifficulty, {y: txtWeekTitle.y + 62, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= weekData.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = weekData.length - 1;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = side.x + side.width / 2 - txtWeekTitle.width / 2;

		updateRank();

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && weekUnlocked[curWeek])
				item.alpha = 1;
			else
				item.alpha = 0.5;
			bullShit++;
		}

		DiscordClient.changePresence("they on the verge of selecting week " + curWeek + " on " + sprDifficulty.animation.name + "!!", null);

		FlxG.sound.play(Paths.sound('scrollMenu'), _variables.svolume / 100);

		updateText();
	}

	function updateText()
	{
		txtTracklist.text = "THE BANGERS:\n\n";

		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
		{
			txtTracklist.text += i + "\n";
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		characterUI.animation.addByPrefix(weekCharacters[curWeek], weekCharacters[curWeek], 24);
		characterUI.animation.play(weekCharacters[curWeek]);
		characterUI.scale.set(300 / characterUI.height, 300 / characterUI.height);
		characterUI.x = 2000 - FlxG.width;
		characterUI.y = 150;

		switch (characterUI.animation.curAnim.name)
		{
			case 'gf':
				characterUI.offset.set(32, 0);
			case 'stoopid guy':
				characterUI.offset.set(-50, 0);
		}

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}

	function updateRank():Void
	{
		ranks.clear();

		curWeekData = weekData[curWeek];

		for (i in 0...curWeekData.length)
		{
			var rank:FlxSprite = new FlxSprite(958, 100);
			rank.loadGraphic(Paths.image('rankings/' + rankTable[Highscore.getRank(curWeekData[i], curDifficulty)]));
			rank.ID = i;
			rank.scale.x = rank.scale.y = 80 / rank.height;
			rank.updateHitbox();
			rank.antialiasing = true;
			rank.scrollFactor.set();
			rank.y = 30 + i * 65;

			ranks.add(rank);
		}
	}
}
