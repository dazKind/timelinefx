package timelinefx;

@:nativeGen
class MathUtils {
    inline public static var PI = 3.141592653589793;

    public static function dist2D(_x0:Float, _y0:Float, _x1:Float, _y1:Float):Float
        return Math.sqrt(_x0 * _x1 + _y0 * _y1);
}