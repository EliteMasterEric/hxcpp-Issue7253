package;

interface ISomeInterface
{
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

class Main
{
 public static function main(): Void
 {
      var inst = new SomeClass();
      trace("Begin");
      trace("Begin case 1");
      try {
        var unexistProperty = Reflect.getProperty(inst, "unexistProperty");
        trace(unexistProperty.some); 
      }
      catch(e:Dynamic) {
        trace(e); //Null Object Reference - works as expected
      }
      trace("End case 1");

      trace("Begin case 2");
      try {
        var val = Reflect.getProperty(inst, "someProperty"); //Just crash
        trace(val);
      }
      catch(e:Any) {
        trace(e);
      }
      trace("End case 2");
      trace("Finish");
 }
}