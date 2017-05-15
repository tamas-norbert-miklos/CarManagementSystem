function autoEnable() {
	var dropdownlist = document.getElementById("manufacturer");
	var selectedIndex = dropdownlist.options[dropdownlist.selectedIndex];
	if (selectedIndex == 0) {
  	  	disable()
  	} else {
   		enable()
    }
}

function disable() {
    document.getElementById("type").disabled=true;
}
function enable() {
    document.getElementById("type").disabled=false;
}
