package;

 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 using flixel.util.FlxSpriteUtil;

/**
 * @author Kevin
 */
class UI extends FlxTypedGroup<FlxSprite> 
{
	var MAX_LENGTH_OF_TEXT:Int = 240;
	var frame:Int = 0;
	
	var barHealth:FlxBar;
	var sprTextBox:FlxSprite;
	var textTextBox:FlxText;
	
	var sprHair:FlxSprite;
	var textHair:FlxText;
	var textTime:FlxSprite;
	
	var goalString:String = "";
	var goalStringIndex:Int = 0;
	

	public function new() 
	{
		super();
		
		barHealth = new FlxBar(0,0,FlxBar.FILL_LEFT_TO_RIGHT, 250,50);
		barHealth.createGradientBar([0xEE000000, 0xEE0C0C0], [0xFF00FF00, 0xFFFFFF00, 0xFFFF0000], 1, 180, true, 0xFF000000);
		barHealth.x = FlxG.width - barHealth.width;
		barHealth.percent = 100;
		sprTextBox = new FlxSprite().makeGraphic(700, 150);
		sprTextBox.x = (FlxG.width - sprTextBox.width)/2; //center it onscreen
		sprTextBox.y = (4 / 5) * FlxG.height;
		textTextBox = new FlxText(0, (2 / 3) * FlxG.height, (4 / 5) * FlxG.width, "", 20/*, BOOL use imbedded fonts)*/); 
		textTextBox.color = 0xFF000000;
		textTextBox.fieldWidth = sprTextBox.width - 40;
		textTextBox.x = sprTextBox.x + 20;
		textTextBox.y = sprTextBox.y + 20;
		textTextBox.alignment = "left";
		trace(textTextBox.text.length);
		if (textTextBox.text.length > MAX_LENGTH_OF_TEXT) FlxG.cameras.bgColor = 0xFF000000;
		sprHair = new FlxSprite(0, 0, "assets/images/racoon.jpg");
		
		//add(sprHealth);
		add(barHealth);
		add(sprTextBox);
		add(textTextBox);
		//add(sprHair);
		
		//prevent any scrolling onscreen
		forEach(function(spr:FlxSprite) {
             spr.scrollFactor.set();
         });	
	}
	
	override public function update():Void {
		frame++;
		
		if (textTextBox.text != goalString) {
			if (textTextBox.text.length > MAX_LENGTH_OF_TEXT) {
				goalString = goalString.substring(textTextBox.text.length, goalString.length);
				textTextBox.text = "";
				goalStringIndex = 0;
			}
			if (frame % 1 == 0){
				textTextBox.text += goalString.charAt(goalStringIndex);
				goalStringIndex++;
			}
		}
		
		
		super.update();
	}
	
	public function updateHealthBar(healthe:Int) : Void{
		//barHealth.health = healthe;
		barHealth.percent = healthe;
	}
	
	public function updateText(texte:String) : Void {
		goalString = texte;
		textTextBox.text = "";
		goalStringIndex = 0;
	}
	
}