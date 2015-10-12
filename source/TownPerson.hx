package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;

class TownPerson extends FlxSprite
{
	var walkFrames:Array<Int> = [0, 6, 12, 18];
	var topFrames:Array<Int> = [1, 7, 13];
	var bottomFrames:Array<Int> = [3, 19];
	var hairFrames:Array<Int> = [3,4,5,8,9,10,11,14,15,16,17,21,22,23];

	var pos_x:Int;
	var pos_y:Int;
	
	public var spriteGroup:FlxGroup;
	var hair_sprite:FlxSprite;
	var top_sprite:FlxSprite;
	var bottom_sprite:FlxSprite;

	public function new(pos_x:Int, pos_y:Int) 
	{
		super();
		
		//this.makeGraphic(64, 128, FlxColor.AZURE);
		var resLocation:String = "assets/images/Characters/TownPeople/TownPeople_0.png";
		this.loadGraphic(resLocation, true, 64, 96);
		this.animation.add("tap", [0,6,12,18], 8, true);
		this.animation.play("tap");
		this.setPosition(pos_x, pos_y);
		
		spriteGroup = new FlxGroup();
		
		hair_sprite = new FlxSprite();
		hair_sprite.loadGraphic(resLocation, true, 64, 96);
		hair_sprite.setPosition(pos_x, pos_y);
		hair_sprite.animation.add("idle", [hairFrames[FlxRandom.intRanged(0, hairFrames.length-1)]], 1, true);
		hair_sprite.animation.play("idle");
		
		top_sprite = new FlxSprite();
		top_sprite.loadGraphic(resLocation, true, 64, 96);
		top_sprite.setPosition(pos_x, pos_y);
		top_sprite.animation.add("idle", [topFrames[FlxRandom.intRanged(0, topFrames.length-1)]], 1, true);
		top_sprite.animation.play("idle");
		
		
		bottom_sprite = new FlxSprite();
		bottom_sprite.loadGraphic(resLocation, true, 64, 96);
		bottom_sprite.setPosition(pos_x, pos_y);
		bottom_sprite.animation.add("idle", [bottomFrames[FlxRandom.intRanged(0, bottomFrames.length-1)]], 1, true);
		bottom_sprite.animation.play("idle");
		
		
		spriteGroup.add(this);
		spriteGroup.add(top_sprite);
		spriteGroup.add(bottom_sprite);
		spriteGroup.add(hair_sprite);
	}
	
	override public function update():Void
	{
		super.update();
		
	}
	
}