var convertButton = document.getElementById('convert');
var inputArea = document.getElementById('input');
var outputArea = document.getElementById('output');
function convert() {
	try {
		outputArea.value= p2c2.parse(inputArea.value);
	} catch(err) {
		outputArea.value = err;
	}
}
convertButton.addEventListener('click', convert);

function init() {
	inputArea.value = '>o_/ 22:23:56 #5766f86ae4b00e368dfab8a3 [:bondour] 2016/06/19#10:22:01 les <b>moules<</b> \\_o< https://sauf.ca http://totoz.eu/ ftp://ftp.fr.debian.org/';
	convert();
}
document.readyState === "interactive" || document.readyState === "complete" ? init() : document.addEventListener("DOMContentLoaded", init);

