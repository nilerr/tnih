// some wrappers for easy editing
function newName() { return capitalize(randomizer('ixenomevabuzolifygaderolyqe',Math.floor(Math.random()*7+3))); };
function newDesc() { return capitalize(randomSentence('gonanekihuhyteranumovexastrywe', Math.floor(Math.random()*7+1))); };
function newTags() { return randomTags(Math.floor(Math.random()*2.666+1)); };

// json generator
function spawnjson(id) {
	var jsonObj = {};
	jsonObj['id'] = id;
	jsonObj['name'] =  newName();
	jsonObj['desc'] = newDesc();
	jsonObj['color'] = randomColor();
	jsonObj['checked'] = 'N';
	jsonObj['tags'] = newTags();
	jsonObj['edit'] = 'N';
	//jsonObj['highlight'] = 'N'; // deprecated
	return jsonObj;
};

// binds highlighter; live binding as the list elements change constantly
// selectorFrom - read properties from here, selectorTo - apply here
// i tried highlighting through angular and this is SIGNIFICANTLY faster
function bindHighlighter(obj, selectorTo, selectorFrom) {
	obj.delegate(selectorTo, 'mouseenter', function() { itemTypeHighliter($(this), selectorFrom); });
	obj.delegate(selectorTo, 'mouseleave', function() { itemTypeHighliterOff($(this)); });
	// this next one is here to change background live on editing - just as anglar would do
	obj.delegate(selectorTo, 'click', function() { itemTypeHighliterOff($(this)); itemTypeHighliter($(this), selectorFrom); });
};

// highlights on
function itemTypeHighliter(objTo, selectorStr) {
	var str = objTo.find(selectorStr).attr('class');
	if (str==undefined) return;
	switch(str.split(' ')[1]) {
		case 'grey': objTo.addClass('grey'); break;
		case 'red': objTo.addClass('red'); break;
		case 'purple': objTo.addClass('purple'); break;
	}
//	if (objTo.find(selectorStr).hasClass('grey'))  objTo.addClass('grey');
//	if (objTo.find(selectorStr).hasClass('red'))  objTo.addClass('red');
//	if (objTo.find(selectorStr).hasClass('purple'))  objTo.addClass('purple');
};

// highlight off
function itemTypeHighliterOff(obj) {
	obj.removeClass('grey red purple');
};

// i liked this so i reused it
function randomizer(str, no) {
	// no is number of letters
	return no>0 ? str[2*Math.floor(Math.random()*((str.length-no%2)/2))+no%2] + randomizer(str,no-1) : '';
};

// returns a color; hardcoded for now
function randomColor() {
	var pick = Math.floor(Math.random()*2.999);
	switch(pick) {
		case 0: return 'grey';
		case 1: return 'red';
		case 2: return 'purple';
	}
};

// tags from hardcoded list
function randomTags(no) {
	var tags = ['tiny', 'small', 'medium', 'large', 'virtual', 'neat', 'exquisite', 'value', 'ancient',
				'has cracks', 'alien', 'positron', 'jumpdrive', 'duster', 'sungod'];
	var tagr = [];
	for (var i=0; i<no; i++) {
		tagr[i]=tags[Math.floor(Math.random()*4.999+i*5)];
	}
	return tagr;
}

// too much of a good thing
function randomSentence(str, no) {
	// no is number of words
	var sentence = '';
	for (var i=0; i<no; i++) {
		sentence = sentence + randomizer(str, Math.floor(Math.random()*6+2));
		if (i<no-1)
			sentence = sentence + ' ';
	}
	return sentence + '.';
};

// Word
function capitalize(str) {
	return str.charAt(0).toUpperCase()+str.slice(1);
};

// time passed since now and startTime as a string
function writeLoadTime(obj, startTime) {
	obj.append((new Date).getTime() - startTime + 'ms');
};

