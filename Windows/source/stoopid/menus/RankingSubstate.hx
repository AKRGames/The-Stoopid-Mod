package stoopid.menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.system.System;
import stoopid.backend.variables.MainVariables._variables;
import stoopid.backend.variables.ModifierVariables._modifiers;
import sys.FileSystem;
import sys.io.File;

class RankingSubstate extends MusicBeatSubstate
{
	var pauseMusic:FlxSound;

	var rank:FlxSprite = new FlxSprite(-200, 730);
	var combo:FlxSprite = new FlxSprite(-200, 730);
	var comboRank:String = "N/A";
	var ranking:String = "N/A";
	var rankingNum:Int = 15;

	public function new(x:Float, y:Float)
	{
		super();

		generateRanking();

		var image = lime.graphics.Image.fromFile('assets/images/iconOG.png');
		lime.app.Application.current.window.setIcon(image);

		if (!PlayState.cheated && !_variables.botplay)
			Highscore.saveRank(PlayState.SONG.song, rankingNum, PlayState.storyDifficulty);

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.volume = 1;
		pauseMusic.play(false, 0);

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		rank = new FlxSprite(-20, 40).loadGraphic(Paths.image('rankings/$ranking'));
		rank.scrollFactor.set();
		add(rank);
		rank.antialiasing = true;
		rank.setGraphicSize(0, 450);
		rank.updateHitbox();
		rank.screenCenter();

		combo = new FlxSprite(-20, 40).loadGraphic(Paths.image('rankings/$comboRank'));
		combo.scrollFactor.set();
		combo.screenCenter();
		combo.x = rank.x - combo.width / 2;
		combo.y = rank.y - combo.height / 2;
		add(combo);
		combo.antialiasing = true;
		combo.setGraphicSize(0, 130);

		var press:FlxText = new FlxText(20, 15, 0, "press any button to continue.", 20);
		press.scrollFactor.set();
		press.setFormat(Paths.font("comic.ttf"), 20);
		press.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		press.y = 690 - press.height;
		press.updateHitbox();
		add(press);

		var hint:FlxText = new FlxText(20, 15, 0, "you barely made it... if you'd missed under 10 times, you'd get the SCDB ranking.", 25);
		hint.scrollFactor.set();
		hint.setFormat(Paths.font("comic.ttf"), 25);
		hint.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
		hint.y = 640 - hint.height;
		hint.updateHitbox();
		add(hint);

		switch (comboRank)
		{
			case 'MFC':
				hint.text = "WTF HOW DID YOU DO THAT YOU'RE LITERALLY A GOD!!";
			case 'GFC':
				hint.text = "you're not supposed to be THAT good! if you could get only SICKs, you'd get the MFC ranking.";
			case 'FC':
				hint.text = "you're good at this. if you could get to GOODs (and SICKs), you'd get the GFC ranking.";
			case 'SDCB':
				hint.text = "you get a pass. if you didn't miss at all, you'd get the FC ranking.";
		}

		if (PlayState.cheated)
		{
			FlxG.openURL("https://www.youtube.com/watch?v=em-87F0UL-w");
			System.exit(0);
		}

		if (_variables.botplay)
		{
			hint.y -= 35;
			hint.text = "you have botplay on, this doesn't count, LOL!!";
		}

		if (PlayState.curDeaths >= 30)
		{
			hint.text = "skill issue\nnoob";
		}

		hint.screenCenter(X);

		hint.alpha = press.alpha = 0;

		press.screenCenter();
		press.y = 670 - press.height;

		FlxTween.tween(bg, {alpha: 0.5}, 2.5, {ease: FlxEase.expoOut});
		FlxTween.tween(press, {alpha: 1}, 2.5, {ease: FlxEase.circOut, startDelay: 0.3});
		FlxTween.tween(hint, {alpha: 1}, 2.5, {ease: FlxEase.circOut, startDelay: 0.3});

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ANY || _modifiers.Practice)
		{
			PlayState.ended = false;

			switch (PlayState.gameplayArea)
			{
				case "Story":
					if (PlayState.storyPlaylist.length <= 0)
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

						FlxG.switchState(new MenuWeek());
					}
					else
					{
						var difficulty:String = "";

						if (PlayState.storyDifficulty == 0)
							difficulty = '-noob';

						if (PlayState.storyDifficulty == 1)
							difficulty = '-easy';

						if (PlayState.storyDifficulty == 3)
							difficulty = '-hard';

						if (PlayState.storyDifficulty == 4)
							difficulty = '-expert';

						if (PlayState.storyDifficulty == 5)
							difficulty = '-insane';

						trace('LOADING NEXT SONG');
						trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);

						PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
						FlxG.sound.music.stop();
						LoadingState.loadAndSwitchState(new PlayState());
					}
				case "Freeplay":
					FlxG.switchState(new MenuFreeplay());
			}
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function generateRanking():String
	{
		if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0) // Marvelous (SICK) Full Combo
			comboRank = "MFC";
		else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
			comboRank = "GFC";
		else if (PlayState.misses == 0 && PlayState.bads >= 1 && PlayState.shits == 0 && PlayState.goods >= 0) // Alright Full Combo (Bads, Goods and Sicks)
			comboRank = "AFC";
		else if (PlayState.misses == 0) // Regular FC
			comboRank = "FC";
		else if (PlayState.misses < 10) // Single Digit Combo Breaks
			comboRank = "SDCB";

		// WIFE TIME :)))) (based on Wife3)

		// var wifeConditions:Array<Bool> = [
		// PlayState.accuracy >= 99.9935, // P
		// PlayState.accuracy >= 99.980, // X
		// PlayState.accuracy >= 99.950, // X-
		// PlayState.accuracy >= 99.90, // SS+
		// PlayState.accuracy >= 99.80, // SS
		// PlayState.accuracy >= 99.70, // SS-
		// PlayState.accuracy >= 99.50, // S+
		// PlayState.accuracy >= 99, // S
		// PlayState.accuracy >= 96.50, // S-
		// PlayState.accuracy >= 93, // A+
		// PlayState.accuracy >= 90, // A
		// PlayState.accuracy >= 85, // A-
		// PlayState.accuracy >= 80, // B
		// PlayState.accuracy >= 70, // C
		// PlayState.accuracy >= 60, // D
		// PlayState.accuracy < 60 // E
		// ];

		var wifeConditions:Array<Bool> = [
			PlayState.accuracy >= 99, // P
			PlayState.accuracy >= 95, // X
			PlayState.accuracy >= 92.5, // X-
			PlayState.accuracy >= 90, // SS+
			PlayState.accuracy >= 85, // SS
			PlayState.accuracy >= 80, // SS-
			PlayState.accuracy >= 75, // S+
			PlayState.accuracy >= 70, // S
			PlayState.accuracy >= 69, // S-
			PlayState.accuracy >= 65, // A+
			PlayState.accuracy >= 60, // A
			PlayState.accuracy >= 55, // A-
			PlayState.accuracy >= 50, // B
			PlayState.accuracy >= 40, // C
			PlayState.accuracy >= 30, // D
			PlayState.accuracy < 30 // E
		];

		for (i in 0...wifeConditions.length)
		{
			var b = wifeConditions[i];
			if (b)
			{
				rankingNum = i;
				switch (i)
				{
					case 0:
						ranking = "P";
					case 1:
						ranking = "X";
					case 2:
						ranking = "X-";
					case 3:
						ranking = "SS+";
					case 4:
						ranking = "SS";
					case 5:
						ranking = "SS-";
					case 6:
						ranking = "S+";
					case 7:
						ranking = "S";
					case 8:
						ranking = "S-";
					case 9:
						ranking = "A+";
					case 10:
						ranking = "A";
					case 11:
						ranking = "A-";
					case 12:
						ranking = "B";
					case 13:
						ranking = "C";
					case 14:
						ranking = "D";
					case 15:
						ranking = "E";
				}

				if (PlayState.cheated || PlayState.curDeaths >= 30 || PlayState.accuracy == 0)
					ranking = "F";
				break;
			}
		}
		return ranking;
	}
}
