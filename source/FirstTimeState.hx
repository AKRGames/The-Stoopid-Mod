package;

import lime.app.Application;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import openfl.Lib;
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
		var lol = (cast(Lib.current.getChildAt(0), Main)).lastY;
		FlxTween.tween(Application.current.window, {y: lol}, 0.5, {ease: FlxEase.circOut});
		
		DiscordClient.changePresence("Started for the first time.", null);

		txt = new FlxText(0, 360, FlxG.width,
			"Heads up!\nFriday Night Funkin: The Stoopid Mod contains a lot of stoopid memes. Viewer discretion is advised.\n\n"
			+ "The Stoopid Mod is cool. You should agree. "
			+ "Also, STOOPID GUY IS NOT LITTLE MAN ON STEROIDS. That's the only argument I can make. "
			+ "Anyway, shoutout to Verwex for making this engine.\n\n"
			+ "Thanks for reading. I hope you enjoy this mod.\n(you should also play little man and bob mod)\nPress ENTER to proceed.",
			32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		add(txt);

		super.create();
	}

	override function update(elapsed:Float)
	{
		var no:Bool = false;
		sinMod += 0.007;
		txt.y = Math.sin(sinMod) * 60 + 100;

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
