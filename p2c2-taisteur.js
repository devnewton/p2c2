var convertButton = document.getElementById('convert');

convertButton.addEventListener('click', function() {
	var inputArea = document.getElementById('input');
	var outputArea = document.getElementById('output');
try {
	outputArea.value= p2c2.parse(inputArea.value);
} catch(err) {
outputArea.value = err;
}
});
