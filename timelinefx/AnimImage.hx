package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class AnimImage {
	public var width:Int = 0;
	public var height:Int = 0;
	public var maxRadius:Int = 0;
	public var index:Int = 0;
	public var frames:Int = 0;
	public var imageSourceName:String = "";
	public var horizCells:Int = 1;

	public function new() {}

	public function loadFromXML(_fast:Fast):Void {
		imageSourceName = _fast.att.URL;
		width = Std.parseInt(_fast.att.WIDTH);
		height = Std.parseInt(_fast.att.HEIGHT);
		frames = Std.parseInt(_fast.att.FRAMES);
		index = Std.parseInt(_fast.att.INDEX);

		// Note that we don't actually know this until we load the image, as we don't have the total image dimensions
		// i.e. we have the size of each cell/frame, and the number of cells, but we don't know the arrangement (e.g. 2x4 or 1x8)
		// Must be set once the image is loaded if we have sprite sheets with different horizontal/vertical number of cells/frames
		horizCells = Std.int(Math.sqrt(frames));
	}

	//inline public function getFrameCount():Int return frames;
}