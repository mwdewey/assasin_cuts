package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class GameState2 extends FlxState
{

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
        super.create();
		
		FlxG.sound.playMusic(AssetPaths.Level2__wav, 1, true);
	}
	
	override public function update() {
		super.update();
		
		if (FlxG.keys.justPressed.R) FlxG.switchState(new RestartState(new CutScene2()));
		if (FlxG.keys.justPressed.F5) FlxG.switchState(new CutScene3());
	}
	
}