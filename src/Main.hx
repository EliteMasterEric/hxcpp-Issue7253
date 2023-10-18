package;

interface ISomeInterface {
	function getSomeProperty():Float;
}

class SomeClass {
	var nullPointer:ISomeInterface;

	public var someProperty(get, null):Float;

	public function new() {}

	function get_someProperty():Float {
		return nullPointer.getSomeProperty();
	}
}

class Main {
	public static function main():Void {
		initErrorHandler();

		trace("Begin");

		case2();

		trace("Finish");
	}

	static function initErrorHandler():Void {
		#if cpp
		trace('[LOG] Enabling C++ critical error handler...');
		untyped __global__.__hxcpp_set_critical_error_handler(function(msg:String) {
			trace('[CRITICAL ERROR] ${msg}');
		});
		#end
	}

	public static function case1():Void {
		trace("Begin case 1");
		var inst = new SomeClass();
		try {
			var unexistProperty = Reflect.getProperty(inst, "unexistProperty");
			trace(unexistProperty.some);
		} catch (e:Dynamic) {
			trace(e); // Null Object Reference - works as expected
		}
		trace("End case 1");
	}

	public static function case2():Void {
		trace("Begin case 2");
		var inst = new SomeClass();
		try {
			var val = Reflect.getProperty(inst, "someProperty"); // Just crash
			trace(val);
		} catch (e:Any) {
			trace(e);
		}
		trace("End case 2");
	}
}
