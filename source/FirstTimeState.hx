package;

import lime.app.Application;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.Lib;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.addons.transition.Transition;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import MainVariables._variables;
import Discord.DiscordClient;

using StringTools;

class FirstTimeState extends MusicBeatState
{
	var nextMsg:Bool = false;
	var sinMod:Float = 0;
	var txt:FlxText;

	public static var leftState:Bool = false;

	override function create()
	{
		// var lol = (cast(Lib.current.getChildAt(0), Main)).lastY;
		// FlxTween.tween(Application.current.window, {y: lol}, 0.5, {ease: FlxEase.circOut});
		// the code above is horrendous

		transOut = FlxTransitionableState.defaultTransOut;
		
		DiscordClient.changePresence("guys don't jugde them it's their first time :(", null);

		txt = new FlxText(0, 100, FlxG.width,
			"heads up!\nFriday Night Funkin: The Stoopid Mod contains a lot of stoopid memes. viewer discretion is advised.\n\n"
			+ "you should set your options before you play.\n"
			+ "also, STOOPID GUY IS NOT LITTLE MAN ON STEROIDS AND WAS MADE BEFORE THE YIPPEE CREATURE WENT VIRAL.\n"
			+ "anyway, shoutout to Verwex for making this engine.\n\n"
			+ "thanks for reading. i hope you enjoy this mod.\n(you should also play little man and bob mod)\npress ENTER to proceed.",
			32);
		txt.setFormat("Comic Sans MS", 32, FlxColor.WHITE, CENTER);
		add(txt);

		super.create();
	}

	override function update(elapsed:Float)
	{
		var no:Bool = false;

		if (FlxG.keys.justPressed.ENTER)
		{
			_variables.firstTime = false;
			leftState = true;
			MainVariables.Save();
			FlxG.switchState(new TitleState());
		}

		super.update(elapsed);
	}
}
