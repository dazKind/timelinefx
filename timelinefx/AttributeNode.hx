package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class AttributeNode {
	public var frame:Int = 0;
	public var value:Float = 0.0;
	public var isCurve:Bool = false;
	public var c0x:Float = 0.0;
	public var c0y:Float = 0.0;
	public var c1x:Float = 0.0;
	public var c1y:Float = 0.0;

	public function new() {}

	public function setCurvePoints(_x0:Float, _y0:Float, _x1:Float, _y1:Float):Void {
		c0x = _x0; c0y = _y0;
		c1x = _x1; c1y = _y1;
		isCurve = true;
	}

	public function toggleCurve():Void 
		isCurve = !isCurve;

	public function loadFromXML(_fast:Fast):Void {
		c0x = Std.parseFloat(_fast.att.LEFT_CURVE_POINT_X);
		c0y = Std.parseFloat(_fast.att.LEFT_CURVE_POINT_Y);

		c1x = Std.parseFloat(_fast.att.RIGHT_CURVE_POINT_X);
		c1y = Std.parseFloat(_fast.att.RIGHT_CURVE_POINT_Y);
		isCurve = true;
	}
}