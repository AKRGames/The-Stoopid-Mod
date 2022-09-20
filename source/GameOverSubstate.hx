package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import MainVariables._variables;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var camLerp:Float = 0.14;
	var zoomLerp:Float = 0.09;

	var stageSuffix:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (daStage)
		{
			case 'school':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			case 'schoolEvil':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			default:
				daBf = 'bf';
		}

		PlayState.ended = false;

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(PlayState.cameraX, PlayState.cameraY, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix ,'shared'),_variables.svolume/100);
		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		FlxG.camera.flash(0xFF0000, 0.4);

		if (PlayState.gameplayArea == "Marathon" || PlayState.gameplayArea == "Endless" || PlayState.gameplayArea == "Survival")
		{
			bf.visible = false;
			var press:FlxText = new FlxText(20, 15, 1200, "GAME OVER!\ntry again?", 32);
			press.alignment = CENTER;
			press.scrollFactor.set();
			press.setFormat(Paths.font("comic.ttf"), 72);
			press.setBorderStyle(OUTLINE, 0xFF000000, 5, 1);
			press.updateHitbox();
			add(press);

			press.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

			press.alpha = 0;
			FlxTween.tween(press, {alpha: 1, y: 550 - press.height}, 1, {ease: FlxEase.backOut, startDelay: 0.3});
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT && PlayState.gameplayArea != "Marathon" && PlayState.gameplayArea != "Endless" && PlayState.gameplayArea != "Survival")
		{
			endBullshit();
		}

		if (controls.BACK)
		{	
			iHopeThisWorks();
			PlayState.curDeaths = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				switch (PlayState.gameplayArea)
				{
					case "Story":
						FlxG.switchState(new MenuWeek());
					case "Freeplay":
						FlxG.switchState(new MenuFreeplay());
					case "Marathon":
						FlxG.switchState(new MenuMarathon());
					case "Endless":
						FlxG.switchState(new MenuEndless());
					case "Survival":
						FlxG.switchState(new MenuSurvival());
					case "Charting":
						FlxG.switchState(new ChartingState());
				}
			});
		}

		FlxG.camera.zoom = FlxMath.lerp(FlxG.camera.zoom, 1, zoomLerp/(_variables.fps/60));

		if (bf.animation.curAnim.name == 'firstDeath')
		{
			FlxG.camera.follow(camFollow, LOCKON, camLerp);
			camFollow.x = FlxMath.lerp(camFollow.x, bf.getGraphicMidpoint().x, (camLerp * _variables.cameraSpeed)/(_variables.fps/60));
			camFollow.y = FlxMath.lerp(camFollow.y, bf.getGraphicMidpoint().y, (camLerp * _variables.cameraSpeed)/(_variables.fps/60));
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix, 'shared'),_variables.mvolume/100);
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	var shake:Float = 0;

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix, 'shared'), _variables.mvolume/100);
			FlxG.camera.fade(FlxColor.BLACK, 5, false, function()
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}
	}

	function iHopeThisWorks():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 1);
		FlxG.sound.music.fadeOut(1, 0);
	}
}