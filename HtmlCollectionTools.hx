import js.Dom.HtmlCollection;
import js.Dom.HtmlDom;

import haxe.FastList;

class HtmlCollectionTools {
	static public function toArray<T>(hc:HtmlCollection<T>):Array<T> {
		var ary = new Array<T>();
		for (i in 0...hc.length){
			ary.push(hc[i]);
		}
		return ary;
	}
	
	static public function toList<T>(hc:HtmlCollection<T>):List<T> {
		var list = new List<T>();
		for (i in 0...hc.length){
			list.add(hc[i]);
		}
		return list;
	}
	
	static public function toFastList<T>(hc:HtmlCollection<T>):FastList<T> {
		var list = new FastList<T>();
		var i = hc.length;
		while (--i >= 0) {
			list.add(hc[i]);
		}
		return list;
	}
	
	static public function iterator<T>(hc:HtmlCollection<T>):Iterator<T> {
		return new HtmlCollectionIter<T>(hc);
	}
}

class HtmlCollectionIter<T> {
	public var collection(default,null):HtmlCollection<T>;
	
	private var currentIndex:Int;
	
	public function new(hc:HtmlCollection<T>) {
		this.collection = hc;
		currentIndex = 0;
	}
	
	inline public function hasNext():Bool{
		return currentIndex < collection.length;
	}
	
	inline public function next():T {
		return collection[currentIndex++];
	}
}
