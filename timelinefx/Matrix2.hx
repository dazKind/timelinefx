package timelinefx;

class Matrix2 {
	public var aa:Float = 1.0;
	public var ab:Float = 0.0;
	public var ba:Float = 0.0;
	public var bb:Float = 1.0;

	public function new() {}

	public function set(_aa:Float, _ab:Float, _ba:Float, _bb:Float):Void {
		this.aa = _aa;
		this.ab = _ab;
		this.ba = _ba;
		this.bb = _bb;
	}

	public function transformSelf(_m:Matrix2):Void {
		var r_aa = this.aa * _m.aa + this.ab * _m.ba;
		var r_ab = this.aa * _m.ab + this.ab * _m.bb;
		var r_ba = this.ba * _m.aa + this.bb * _m.ba;
		var r_bb = this.ba * _m.ab + this.bb * _m.bb;
	}

	public function transformVec2(_x:Float, _y:Float):Vec2 {
		return new Vec2(
			_x * this.aa + _y * this.ba,
			_x * this.ab + _y * this.bb
		);
	}
}