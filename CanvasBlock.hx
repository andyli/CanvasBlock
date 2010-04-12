import js.Dom.Document;
import js.Dom.Event;
import js.Dom.HtmlCollection;
import js.Dom.HtmlDom;

using HtmlCollectionTools;

class CanvasBlock {
	static private var replacedElements:IntHash<HtmlDom> = new IntHash<HtmlDom>();
	static private var nextId:Int = 0;
	
	static public var replacementTitlePrefix:String = "CanvasBlock";

	static public function replace(list:Array<HtmlDom>):Void {
		for (i in list) {
			var id = nextId++; //it will be the key of i in replacedElements
			var replacement = js.Lib.document.createElement("div");
			var replacementText = js.Lib.document.createElement("div");
			var computedStyle = untyped js.Lib.window.getComputedStyle(i,null);
			
			replacementText.innerHTML = "Click to show the " + i.nodeName;
			replacementText.style.margin = 0;
			replacementText.style.display = "block";
			replacementText.style.height = computedStyle.getPropertyValue("height");
			replacementText.style.width = computedStyle.getPropertyValue("width");
			replacement.style.cssFloat = "none";
			replacement.style.styleFloat = "none";
			replacement.appendChild(replacementText);
			
			replacement.className = i.className;
			replacement.id = i.id;
			replacement.style.padding = 0;
			replacement.style.margin = computedStyle.getPropertyValue("margin");
			replacement.style.border = computedStyle.getPropertyValue("border");
			replacement.style.cssFloat = computedStyle.getPropertyValue("cssFloat");
			replacement.style.styleFloat = computedStyle.getPropertyValue("styleFloat");
			if (computedStyle.getPropertyValue("display") != "none")
				replacement.style.display = computedStyle.getPropertyValue("display");
			
			//greasemonkey has to use addEventListener...
			untyped replacementText.addEventListener("click",replacementClicked,true);
			
			i.parentNode.replaceChild(replacement,i);
			
			replacement.title = replacementTitlePrefix+id; //key is saved here
			replacedElements.set(id, i); //save it so that we can get it later
		}
	}
	
	static public function find(doc:Document):Array<HtmlDom> {
		var ary = [];
		ary = ary.concat(doc.getElementsByTagName("canvas").toArray());
		ary = ary.concat(doc.getElementsByTagName("video").toArray());
		ary = ary.concat(doc.getElementsByTagName("audio").toArray());
		return ary;
	}
	
	static private function replacementClicked(evt:Event):Void {
		var replacement = evt.target.parentNode;
		var id = Std.parseInt(replacement.title.substr(replacementTitlePrefix.length));
		replacement.parentNode.replaceChild(replacedElements.get(id),replacement); //get back the item and place it back
	}
	
	static public function main() {
		replace(find(js.Lib.document));
	}
}
