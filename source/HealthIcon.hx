package;

import sys.FileSystem;
import flixel.FlxSprite;
import MainVariables._variables;

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 	-NinjaMuffin99

	 * Who said that was the case??
	 	-Verwex
	 */
	public var sprTracker:FlxSprite;

	public var usingFallback:Bool;

	var style = _variables.iconStyle;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		if (FileSystem.exists('assets/shared/images/icons/$style/icon-' + char + '.png') || FileSystem.exists('mods/mainMods/_append/shared/images/icons/$style/icon-' + char + '.png'))
		{
			loadGraphic(Paths.image('icons/$style/icon-' + char, 'shared'), true, 150, 150);

			trace('exists');
			usingFallback = false;

			animation.add(char, [0, 1, 2], 0, false, isPlayer);

			animation.play(char);
		}
		else // fallback support
		{
			loadGraphic(Paths.image('iconGrid'), true, 150, 150);

			trace('does not');
			usingFallback = true;

			animation.add('bf', [0, 1, 2], 0, false, isPlayer);
			animation.add('bf-car', [0, 1, 2], 0, false, isPlayer);
			animation.add('bf-christmas', [0, 1, 2], 0, false, isPlayer);
			animation.add('bf-pixel', [33, 34, 35], 0, false, isPlayer);
			animation.add('spooky', [3, 4, 5], 0, false, isPlayer);
			animation.add('pico', [6, 7, 8], 0, false, isPlayer);
			animation.add('mom', [9, 10, 11], 0, false, isPlayer);
			animation.add('mom-car', [9, 10, 11], 0, false, isPlayer);
			animation.add('tankman', [12, 13, 14], 0, false, isPlayer);
			animation.add('face', [15, 16, 17], 0, false, isPlayer);
			animation.add('dad', [18, 19, 20], 0, false, isPlayer);
			animation.add('senpai', [36, 37, 39], 0, false, isPlayer);
			animation.add('senpai-angry', [37, 38, 36], 0, false, isPlayer);
			animation.add('spirit', [40, 41, 42], 0, false, isPlayer);
			animation.add('bf-old', [21, 22, 23], 0, false, isPlayer);
			animation.add('gf', [24, 25, 26], 0, false, isPlayer);
			animation.add('gf-car', [24, 25, 26], 0, false, isPlayer);
			animation.add('gf-christmas', [24, 25, 26], 0, false, isPlayer);
			animation.add('gf-pixel', [24, 25, 26], 0, false, isPlayer);
			animation.add('parents-christmas', [27, 28, 29], 0, false, isPlayer);
			animation.add('monster', [30, 31, 32], 0, false, isPlayer);
			animation.add('monster-christmas', [30, 31, 32], 0, false, isPlayer);

			animation.play(char);
		}

		switch (char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
			default:
				antialiasing = true; //grrrrr this is what makes the rest not look blocky, mannnnn
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
