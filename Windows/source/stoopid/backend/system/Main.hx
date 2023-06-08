package stoopid.backend.system;

import flixel.FlxState;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import stoopid.Discord.DiscordClient;
import stoopid.backend.system.haxelibrewrites.OldAhhFlxGame;

class Main extends Sprite
{
	/**
	 * Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	 */
	var gameWidth:Int = 1280;

	/**
	 * Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	 */
	var gameHeight:Int = 720;

	/**
	 * The FlxState the game starts with.
	 */
	var initialState:Class<FlxState> = FirstCheckState;

	/**
	 * If -1, zoom is automatically calculated to fit the window dimensions.
	 */
	var zoom:Float = 1;

	/**
	 * How many frames per second the game should run at.
	 */
	var framerate:Int = 69;

	/**
	 * Whether to skip the flixel splash screen that appears in release mode.
	 */
	var skipSplash:Bool = false;

	/**
	 * Whether to start the game in fullscreen on desktop targets.
	 */
	var startFullscreen:Bool = false;

	/**
	 * The Y that the game window starts in.
	 */
	public var lastY:Float = 0;

	// You can pretty much ignore everything from here on - your code should go in your states.
	public static var watermark:Sprite;

	public var webmHandle:WebmHandler;

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		lastY = Application.current.window.y;
		// Application.current.window.y = 1000;
		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		// if (zoom == -1)
		// {
		var ratioX:Float = stageWidth / gameWidth;
		var ratioY:Float = stageHeight / gameHeight;
		zoom = Math.min(ratioX, ratioY);
		gameWidth = Math.ceil(stageWidth / zoom);
		gameHeight = Math.ceil(stageHeight / zoom);
		// }

		#if !debug
		initialState = FirstCheckState;
		#end

		addChild(new OldAhhFlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
		#if windows
		DiscordClient.initialize();
		#end

		var ourSource:String = "assets/videos/dontDelete.webm";

		var str1:String = "WEBM SHIT";
		webmHandle = new WebmHandler();
		webmHandle.source(ourSource);
		webmHandle.makePlayer();
		webmHandle.webm.name = str1;
		addChild(webmHandle.webm);
		GlobalVideo.setWebm(webmHandle);

		#if !mobile
		fpsCounter = new FramasPorSex(10, 3, 0xFFFFFF);
		addChild(fpsCounter);

		memoryCounter = new MemoryCounter(10, 3, 0xffffff);
		addChild(memoryCounter);
		#end

		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});

		var bitmapData = Assets.getBitmapData("assets/images/watermark.png");

		watermark = new Sprite();
		watermark.addChild(new Bitmap(bitmapData)); // Sets the graphic of the sprite to a Bitmap object, which uses our embedded BitmapData class.
		watermark.alpha = 0.5;
		watermark.x = Lib.application.window.width - 10 - watermark.width;
		watermark.y = Lib.application.window.height - 10 - watermark.height;
		addChild(watermark);

		MainVariables.Load(); // Funnily enough you can do this. I say this optimizes options better in a way or another.
	}

	public static var fpsCounter:FramasPorSex;

	public static function toggleFPS(fpsEnabled:Bool):Void
	{
		fpsCounter.visible = fpsEnabled;
	}

	public static var memoryCounter:MemoryCounter;

	public static function toggleMem(memEnabled:Bool):Void
	{
		memoryCounter.visible = memEnabled;
	}

	public function changeColor(color:FlxColor)
	{
		fpsCounter.textColor = color;
		memoryCounter.textColor = color;
	}
}