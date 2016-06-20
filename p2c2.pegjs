post
 = items:postItem*
 { return items.join(""); }
 
postItem
 = url
 / totoz
 / canard
 / bigorno
 / norloge
 / atag
 / opentag
 / closetag
 / .
 
url
 = url:$((("http" "s"?) / "ftp") "://" [^ \t\r\n]+)
 {return '<url>' + url + '</url>'}
 
canard
= ("\\_" teteCanard "<" / ">" teteCanard "_/")
 {return '<canard/>';}
 
teteCanard
 = [o0ô°øòó@]

opentag
 = $("<" validFormatTag ">")
 / invalidOpenTag

validFormatTag
 = ("b" / "i" / "s" / "u" / "tt")
 
closetag
 = $("</" validFormatTag ">")
 / invalidCloseTag
 
invalidOpenTag
 = "<" invalidTag ">"
 { return ""; }

invalidCloseTag
 = "</" invalidTag ">"
 { return ""; }
 
invalidTag
 = [A-Za-z] [^>]*

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
 = bigorno:[a-zA-Z0-9-_]+ "<" &(whitespaces / [<[])
 { return [].concat('<bigorno>', bigorno,'</bigorno>').join("")}

totoz
  = first:"[:" totoz:[^\]]+ third:"]"
  { var totozId = totoz.join(""); 
  return '<totoz>' + totozId + '</totoz>'; }
  
whitespaces
 = [ \t\r\n] / !.