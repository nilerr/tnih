// requires util.js

var itemApp = angular.module('itemApp', []);

// angular controller
itemApp.controller('itemListCtrler', function ($scope) {
	$scope.filterTags = [];
	$scope.newItem = {};

    $scope.items = (function () {
		var jsonArray = [];
		for (var i=0; i<100; i++) {
			jsonArray.push(spawnjson(i));
		}
		//writeLoadTime($('span.footerright'), startTime);
		return jsonArray;
	})();
	
	// function for changing filtered color; qcolor is created at template processing. afaik.
	$scope.setColor = function(color) {
		$scope.qcolor = color;
	};
	
	// checked/unchecked item property
	$scope.checkItem = function(item) {
		if (item.checked=='Y') item.checked='N';
		else item.checked='Y';
	};
	
	// unchecks all
	$scope.clearItems = function() {
		for (var i=0; i<$scope.items.length; i++) {
			$scope.items[i].checked='N';
		}
	};
	
	// adds a new tag to the filterTags list if not already there
	// $event is passed to prevent triggering enclosing element ng-click
	$scope.addTag = function(tag, $event) {
		$event.stopPropagation();
		for (var i=0; i<$scope.filterTags.length; i++) {
			if ($scope.filterTags[i]==tag) return;
		}
		$scope.filterTags.push(tag);
	};
	
	// deletes tag from list
	$scope.deleteTag = function(tag) {
		for (var i=0; i<$scope.filterTags.length; i++) {
			if ($scope.filterTags[i]==tag) $scope.filterTags.splice(i, 1);
		}
	};
	
	// clears all tags
	$scope.clearTags = function() {
		$scope.filterTags.length = 0;
	};
	
	// actual tag filter using the filter filter
	$scope.hasTags = function(item) {
		var matched = 0;
		for (var j=0; j<$scope.filterTags.length; j++) {
			for (var i=0; i<item.tags.length; i++) {
				if (item.tags[i]==$scope.filterTags[j]) { matched++; break; }
			}
		}
		if (matched==$scope.filterTags.length) return true;
		return false;
	};
	
	// add new item
	$scope.addItem = function() {
		// assign random values
		if (!$scope.newItem.name) $scope.newItem.name = newName();
		if (!$scope.newItem.desc) $scope.newItem.desc = newDesc();
		if (!$scope.newItem.color) $scope.newItem.color = randomColor();
		// check for duplicates
		for (var i=0; i<$scope.items.length; i++) {
			if ($scope.items[i].name==$scope.newItem.name) return;
		}
		// assign other default values; increment id only if newItem is good to go
		$scope.newItem.id = $scope.items.length;
		$scope.newItem.tags = newTags();
		$scope.newItem.checked = 'N'
		$scope.newItem.edit = 'N';
		// add at beginning of array
		$scope.items.unshift($scope.newItem);
		// create new object
		$scope.newItem = {};
	};
	
	// edit item
	$scope.editItem = function(item) {
		item.edit = 'Y';
	};
	
	// close editing
	$scope.editItemDone = function(item) {
		item.edit = 'N';
	};
	
	// close editing on enter
	$scope.editItemDoneKey = function(item, $event) {
		if ($event.keyCode==13) item.edit = 'N';
	};
	
	// deprecated
	// // this is here to keep the logic separated
	// // str is the function to be called, obj is its parameter
	// $scope.bounceEdit = function(str, obj, $event) {
		// $event.stopPropagation();
		// var func = window[str];
		// if (typeof func=='function')
			// func(obj);
	// };
	
	// $scope.highlightOn = function(item) {
		// item.highlight = 'Y';
	// };
	
	// $scope.highlightOff = function(item) {
		// item.highlight = 'N';
	// };
	// !deprecated
});

// format filter using the general filter service
itemApp.filter('strikecheck', function() {
	return function(check) {
		if (check == 'Y') return 'checked'
		else return 'notchecked';
	};
});

// deprecated
// class filter
// itemApp.filter('highlight', function() {
	// return function(item) {
		// if (item.highlight == 'Y') return item.color;
		// else return null;
	// };
// });
// !deprecated

