package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class EmitterArray {
    public var life:Float = 0.0;
    public var compiled:Bool = false;
    public var min:Float;
    public var max:Float;
    public var changes:Array<Float>;
    public var attributes:Array<AttributeNode>;

    var effectsLib:EffectsLibrary;

    public function new(_effectsLib:EffectsLibrary, _min:Float, _max:Float) {
        min = _min;
        max = _max;
        changes = [];
        attributes = [];
        effectsLib = _effectsLib;
    }

    public function getLastFrame():Int
        return changes.length-1;

    public function getLastAttribute():AttributeNode
        return attributes[attributes.length-1];

    public function getCompiled(_frame:Int):Float {
        var lastFrame = getLastFrame();
        if (_frame <= lastFrame)
            return changes[_frame];
        else
            return changes[lastFrame];
    }

    public function setCompiled(_frame:Int, _value:Float):Void {
        changes[_frame] = _value;
    }

    public function compile():Void {
        if (attributes.length > 0) {
            var lastec = getLastAttribute();

            changes = new Array<Float>();
            var frame = 0;
            var age:Float = 0.0;
            while(age < lastec.frame) {
                setCompiled(frame, interpolate(age));
                ++frame;
                age = frame * effectsLib.lookupFrequency;
            }
            setCompiled(frame, lastec.value);
        } else
            changes = [0.0];

        compiled = true;
    }

    public function compileOT(_longestLife:Int = -1) {
        if (attributes.length > 0) {
            var longestLife = _longestLife == -1 ? getLastAttribute().frame : _longestLife;
            var lastec = getLastAttribute();
            
            changes = new Array<Float>();
            var frame = 0;
            var age:Float = 0.0;
            while(age < lastec.frame) {
                setCompiled(frame, interpolateOT(age, longestLife));
                ++frame;
                age = frame * effectsLib.lookupFrequency;
            }
            life = longestLife;
            setCompiled(frame, lastec.value);
        } else
            changes = [0.0];

        compiled = true;
    }

    public function add(_frame:Float, _value:Float):AttributeNode {
        compiled = false;
        var e = new AttributeNode();
        e.frame = _frame;
        e.value = _value;
        attributes.push(e);
        return e;
    }

    public function get(_frame:Int, ?_bezier:Bool = true):Float {
        if (compiled)
            return getCompiled(_frame);
        else
            return interpolate(_frame, _bezier);
    }

    public function getBezierValue(_lastec:AttributeNode, _a:AttributeNode, _t:Float, _yMin:Float, _yMax):Float {
        if (_a.isCurve) {
            var p0x = _lastec.frame;
            var p0y = _lastec.value;

            if (_lastec.isCurve) {
                var p1x = _lastec.c1x;
                var p1y = _lastec.c1y;
                var p2x = _a.c0x;
                var p2y = _a.c0y;
                var p3x = _a.frame;
                var p3y = _a.value;

                return getCubicBezier(p0x, p0y, p1x, p1y, p2x, p2y, p3x, p3y, _t, _yMin, _yMax).y;
            } else {
                var p1x = _a.c0x;
                var p1y = _a.c0y;
                var p2x = _a.frame;
                var p2y = _a.value;

                return getQuadBezier(p0x, p0y, p1x, p1y, p2x, p2y, _t, _yMin, _yMax).y;
            }
        } else if (_lastec.isCurve) {
            var p0x = _lastec.frame;
            var p0y = _lastec.value;
            var p1x = _lastec.c1x;
            var p1y = _lastec.c1y;
            var p2x = _a.frame;
            var p2y = _a.value;

            return getQuadBezier(p0x, p0y, p1x, p1y, p2x, p2y, _t, _yMin, _yMax).y;
        } else 
            return 0;
    }

    public function getQuadBezier(
        _p0x:Float, _p0y:Float, _p1x:Float, _p1y:Float, _p2x:Float, _p2y:Float,
        _t:Float, _yMin:Float, _yMax:Float, ?_clamp:Bool = true):{x:Float, y:Float}
    {
        var x = (1 - _t) * (1 - _t) * _p0x + 2 * _t * (1 - _t) * _p1x + _t * _t * _p2x;
        var y = (1 - _t) * (1 - _t) * _p0y + 2 * _t * (1 - _t) * _p1y + _t * _t * _p2y;
        if (x < _p0x) x = _p0x;
        if (x > _p2x) x = _p2x;
        if (_clamp) {
            if (y < _yMin) y = _yMin;
            if (y > _yMax) y = _yMax;
        }
        return {x:x, y:y};
    }

    public function getCubicBezier(
        _p0x:Float, _p0y:Float, _p1x:Float, _p1y:Float, _p2x:Float, _p2y:Float, _p3x:Float, _p3y:Float, 
        _t:Float, _yMin:Float, _yMax:Float, ?_clamp:Bool = true):{x:Float, y:Float} {
        var x = (1 - _t) * (1 - _t) * (1 - _t) * _p0x + 3 * _t * (1 - _t) * (1 - _t) * _p1x + 3 * _t * _t * (1 - _t) * _p2x + _t * _t * _t * _p3x;
        var y = (1 - _t) * (1 - _t) * (1 - _t) * _p0y + 3 * _t * (1 - _t) * (1 - _t) * _p1y + 3 * _t * _t * (1 - _t) * _p2y + _t * _t * _t * _p3y;
        if (x < _p0x) x = _p0x;
        if (x > _p3x) x = _p3x;
        if (_clamp) {
            if (y < _yMin) y = _yMin;
            if (y > _yMax) y = _yMax;
        }
        return {x:x, y:y};
    }

    public function interpolate(_frame:Float, ?_bezier:Bool = true):Float 
        return interpolateOT(_frame, 1.0, _bezier);

    public function interpolateOT(_age:Float, _lifetime:Float, ?_bezier:Bool = true):Float {
        var lasty:Float = 0.0;
        var lastf:Float = 0.0;
        var lastec:AttributeNode = null;

        for (it in attributes) {
            var frame:Float = it.frame * _lifetime;
            if (_age < frame) {
                var p = (_age - lastf) / (frame - lastf);
                if (_bezier) {
                    var bezierValue = getBezierValue(lastec, it, p, this.min, this.max);
                    if (bezierValue != 0.0)
                        return bezierValue;
                }
                return lasty - p * (lasty - it.value);
            }
            lasty = it.value;
            lastf = frame;
            if (_bezier) lastec = it;
        }
        return lasty;
    }

    public function getOT(_age:Float, _lifetime:Float):Float {
        var frame:Float = 0.0;
        if (_lifetime > 0.0)
            frame = _age / _lifetime * this.life / effectsLib.lookupFrequencyOverTime;
        return this.get(Math.round(frame));
    }

    public function getMaxValue():Float {
        var max:Float = 0.0;
        for (it in attributes) {
            if (it.value > max)
                max = it.value;
        }
        return max;
    }
}