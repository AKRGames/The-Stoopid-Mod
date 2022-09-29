package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import lime.system.System;

class PiracyState extends MusicBeatState
{
	public static var leftState:Bool = false;

	override function create()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		super.create();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('oNo'));
		add(bg);
		var txt:FlxText = new FlxText(0, 0, FlxG.width, "i guess piracy is cool now, huh?...\n ...well ok", 69);
		txt.setFormat("Comic Sans MS", 69, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
		bg.alpha = txt.alpha = 0;
		FlxTween.tween(bg, {alpha: 0.69}, 5, {ease: FlxEase.linear});
		FlxTween.tween(txt, {alpha: 1}, 5, {ease: FlxEase.linear, startDelay: 2.5});
		Application.current.window.alert("Your game isn't legit.", '...');
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			hello();
		}
		if (controls.BACK)
		{
			goodbye();
		}
		super.update(elapsed);
	}

	function hello():Void
	{
		leftState = true;
		FlxG.switchState(new TitleState());
	}

	function goodbye():Void
	{
		System.exit(0);
	}
}
