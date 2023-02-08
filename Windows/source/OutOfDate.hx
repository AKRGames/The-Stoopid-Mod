package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class OutOfDate extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "the latest version";

	public static var changelog:String = "stuff.";

	override function create()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		super.create();

		// var lol = (cast(Lib.current.getChildAt(0), Main)).lastY;
		// FlxTween.tween(Application.current.window, {y: lol}, 0.5, {ease: FlxEase.circOut});
		// the code above is horrendous

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('oNo'));
		add(bg);
		bg.alpha = 0.69;
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"uh oh! your version of the mod seems to be outdated.\n"
			+ "fortunatly, you can update the mod from "
			+ Application.current.meta.get('version')
			+ " to "
			+ needVer
			+ " for free. "
			+ "new features include:\n"
			+ changelog
			+ " press ENTER to go to its official page and get the latest build from there."
			+ "\npress BACK to ignore this.",
			32);
		txt.setFormat("Comic Sans MS", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.openURL("https://gamejolt.com/games/fnfstoopidmod/688327");
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new TitleState());
		}
		super.update(elapsed);
	}
}
