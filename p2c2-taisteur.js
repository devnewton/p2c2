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
	inputArea.value = '10:11:03 [:bondour] les <b>moules<</b>';
	convert();
}
document.readyState === "interactive" || document.readyState === "complete" ? init() : document.addEventListener("DOMContentLoaded", init);

