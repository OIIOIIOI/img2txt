package;


import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import sys.io.File;


class Main extends Sprite
{
	
	var path:String;
	var filename:String;
	var dir:String;

	var tf:TextField;
	var tfv:TextField;
	var tfp:TextField;
	var button:Sprite;
	var bd:BitmapData;
	
	public function new ()
	{	
		super ();

		var format = new TextFormat("Arial", 20);

		tf = new TextField();
		tf.type = TextFieldType.INPUT;
		tf.border = true;
		tf.width = 600;
		tf.height = 30;
		tf.defaultTextFormat = format;
		tf.multiline = false;
		tf.x = tf.y = 10;
		this.addChild(tf);

		tfv = new TextField();
		tfv.type = TextFieldType.INPUT;
		tfv.border = true;
		tfv.width = 30;
		tfv.height = 30;
		tfv.defaultTextFormat = format;
		tfv.multiline = false;
		tfv.x = tf.x + tf.width + 10;
		tfv.y = tf.y;
		tfv.text = ",";
		this.addChild(tfv);

		tfp = new TextField();
		tfp.type = TextFieldType.INPUT;
		tfp.border = true;
		tfp.width = 30;
		tfp.height = 30;
		tfp.defaultTextFormat = format;
		tfp.multiline = false;
		tfp.x = tfv.x + tfv.width + 10;
		tfp.y = tf.y;
		tfp.text = ";";
		this.addChild(tfp);
		
		button = new Sprite();
		button.x = tfp.x + tfp.width + 10;
		button.y = tf.y;
		button.graphics.beginFill(0x26343f, 1);
		button.graphics.drawRect(0, 0, 90, 30);
		button.graphics.endFill();
		button.buttonMode = true;
		this.addChild(button);
		button.addEventListener(MouseEvent.CLICK, clickHandler);
	}

	function clickHandler (e:MouseEvent)
	{
		path = tf.text;

		var array = path.split("/");
		filename = array.pop();
		dir = array.join("/");
		
		bd = BitmapData.fromFile(path);

		var content = "";
		for (yy in 0...bd.height)
		{
			for (xx in 0...bd.width)
			{
				var rgb = ColorConverter.toRGB(bd.getPixel(xx, yy));
				var hsv = ColorConverter.rgb2hsv(rgb);
				content += hsv.h+","+hsv.s+","+hsv.v+"\n";
			}
		}
		if (content == "")
			content = "Error loading image";

		File.saveContent(dir+"/"+filename+".txt", content);
	}

}
