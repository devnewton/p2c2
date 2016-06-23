{

var p2c2 = {};
p2c2.tagStack = [];

}

post
 = items:postItem*
 {
 	var result = items.join("");
    while(p2c2.tagStack.length > 0) {
    	result += "</" + p2c2.tagStack.pop() + ">";
    }
    return result;
 }
 
postItem
 = url
 / totoz
 / canard
 / bigorno
 / norloge
 / atag
 / openTag
 / closeTag
 / xmlSpecialChar
 / .
 
xmlSpecialChar
 = (lt / gt / amp / quot / apos)
 
lt
 = "<"
 { return "&lt;"; }
 
gt
 = ">"
 { return "&gt;"; }
 
amp
 = "&"
 { return "&amp;"; }

quot
 = '"'
 { return "&quot;"; }
 
apos
 = "'"
 { return "&apos;"; }
 
url
 = protocol:$((("http" "s"?) / "ftp") "://") url:(xmlSpecialChar / [^ \t\r\n])+
 { return [].concat('<url>', protocol, url.join(""), '</url>').join("");}
 
canard
= ("\\_" teteCanard "<" / ">" teteCanard "_/")
 {return '<canard/>';}
 
teteCanard
 = [oO0ô°øòó@]

openTag
 = "<" tag:validFormatTag ">"
 {
 	p2c2.tagStack.push(tag);
    console.log("push " + tag);
 	return "<" + tag + ">";
 }

closeTag
 = "</" tag:validFormatTag ">"
 {
 	var result = "";
 	for(;;) {
      var poppedTag = p2c2.tagStack.pop();
      if(poppedTag == undefined) {
      	break;
      }
      if( poppedTag == tag) {
      	result += "</" + tag + ">";
        break;
      } else {
      	result += "</" + poppedTag + ">";
      }
    }
    return result;
 }

validFormatTag
 = ("b" / "i" / "s" / "u" / "tt")

invalidOpenTag
 = "<" tag:invalidTag ">"
 { return "&lt" + tag; + "&gt"; }

invalidCloseTag
 = "</" tag:invalidTag ">"
 { return  "&lt/" + tag; + "&gt";; }
 
invalidTag
 = [A-Za-z] (xmlSpecialChar / [^>])*

atag
 = "<a" attributes:tagAttributes ">" [^<]* "</a>"
 { 
   if(attributes.href) {
      return "<url>" + attributes.href + "</url>";
   }
 }
 
tagAttributes
 = attributes:(separator:" " attribute:tagAttribute { return attribute;})*
 {  var result = {};
 	for(var a in attributes) {
    	result[attributes[a].name] = attributes[a].value;
    }
 	return result;
 }

tagAttribute
 = name:$[a-z]+ value:("=\"" value:$[^"]* "\"" {return value;} )?
 {return { name: name, value: value}}

norloge
 = norlogeTime
 / norlogeId
 
norlogeTime
 = norloge:(fullNorloge / longNorloge / normalNorloge / shortNorloge)
 { return '<norloge>' + norloge +'</norloge>'}

fullNorloge
 = y: norlogeYear "/" ln:longNorloge
 { return y + "/" + ln; }
 
norlogeYear
 = digits: [0-9]+
 { return digits.join(""); }

longNorloge
 = m: norlogeMonth "/" d:norlogeDay "#" nn:normalNorloge
 { return m + "/" + d + "#" + nn; }
 
norlogeMonth
 = first: [0-1] last: [0-9]
 { return first + last; }

norlogeDay
 = first: [0-3] last: [0-9]
 { return first + last; }

normalNorloge
 = sn:shortNorloge ":" s:norlogeSeconds
 { return sn + ":" + s; }
 
shortNorloge
 = h:norlogeHours ":" m:norlogeMinutes
 { return h + ":" + m; }

norlogeHours
 = first: [0-2] last: [0-3]
 { return first + last; }
 
norlogeMinutes
 = first: [0-5] last: [0-9]
 { return first + last; }
 
norlogeSeconds
 = first: [0-5] last: [0-9]
 { return first + last; }

norlogeId =
 "#" chars:[a-zA-Z0-9_]+
 { var norlogeId = chars.join("");
   return '<norloge-id>#' + norlogeId + '</norloge-id>';
   }

bigorno
 = whitespaces bigorno:[a-zA-Z0-9-_]+ "<" &(whitespaces / [<[])
 { return [].concat('<bigorno>', bigorno,'</bigorno>').join("")}

totoz
  = first:"[:" totoz:[^\]]+ third:"]"
  { var totozId = totoz.join(""); 
  return '<totoz>' + totozId + '</totoz>'; }
  
whitespaces
 = inputStart / [ \t\r\n] / ! .

inputStart
 = & { return location().start.offset == 0; }