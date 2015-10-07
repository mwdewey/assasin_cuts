package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author ...
 */
class CutScene1 extends FlxState
{
	var labelTest:FlxText;

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
		labelTest = new FlxText(0, FlxG.height / 2, FlxG.width, "In a town a long, long time ago...");
		labelTest.setFormat(null, 40, FlxColor.WHITE, "center");
		add(labelTest);
		
		new FlxTimer(1.0, endCutScene, 1);
		
        super.create();
    }
	
	override public function update():Void
	{
		super.update();
		
	}	
	
	function endCutScene(Timer:FlxTimer):Void {
	
		FlxG.switchState(new GameState1());
		
	}
	
}