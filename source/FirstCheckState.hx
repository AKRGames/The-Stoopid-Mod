package;

import MainVariables._variables;
import flixel.FlxG;
import lime.app.Application;

using StringTools;

class FirstCheckState extends MusicBeatState
{
	var isDebug:Bool = false;

	override public function create()
	{
		FlxG.mouse.visible = false;

		NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		PlayerSettings.init();
		ModifierVariables.modifierSetup();
		ModifierVariables.loadCurrent();

		super.create();

		#if debug
		isDebug = true;
		#end
	}

	override public function update(elapsed:Float)
	{
		if (InternetConnection.isAvailable() && !isDebug)
		{
			var http = new haxe.Http("https://raw.githubusercontent.com/AKRGames/The-Stoopid-Mod/main/versionShit.txt");
			var returnedData:Array<String> = [];

			http.onData = function(data:String)
			{
				returnedData[0] = data.substring(0, data.indexOf(';'));
				returnedData[1] = data.substring(data.indexOf('-'), data.length);

				if (!Application.current.meta.get('version').contains(returnedData[0].trim())
					&& !OutOfDate.leftState
					&& MainMenuState.nightly == "")
				{
					trace('outdated lmao! ' + returnedData[0] + ' != ' + Application.current.meta.get('version'));
					OutOfDate.needVer = returnedData[0];
					OutOfDate.changelog = returnedData[1];

					FlxG.switchState(new OutOfDate());
				}
				else
				{
					switch (_variables.firstTime)
					{
						case true:
							FlxG.switchState(new FirstTimeState()); // First time language setting
						case false:
							FlxG.switchState(new TitleState()); // First time language setting
					}
				}
			}

			http.onError = function(error)
			{
				trace('error: $error');
				switch (_variables.firstTime)
				{
					case true:
						FlxG.switchState(new FirstTimeState()); // First time language setting
					case false:
						FlxG.switchState(new TitleState()); // First time language setting
				}
			}

			http.request();
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}
		else
		{
			trace('fucking offline noob');
			switch (_variables.firstTime)
			{
				case true:
					FlxG.switchState(new FirstTimeState()); // First time language setting
				case false:
					// LoadingState.loadAndSwitchState(new VideoState("assets/videos/paint.webm", new TitleState(), -1, false, false, false, true)); // First time language setting
					FlxG.switchState(new TitleState()); // First time language setting
			}
		}

		if (_variables.piratedThisGame == true)
		{
			FlxG.switchState(new PiracyState());
		}
		else
		{
			switch (_variables.firstTime)
			{
				case true:
					FlxG.switchState(new FirstTimeState()); // First time language setting
				case false:
					FlxG.switchState(new TitleState()); // First time language setting
			}
		}
	}
}
