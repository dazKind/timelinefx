package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class Emitter extends Entity {
    
    public var path:String = "";

    public var effects:Map<String, Effect>;

    public function new(_other:Entity) {
        super(_other);

        effects = new Map<String, Effect>();
    }

    public function loadFromXML(_fast:Fast):Void {}
}