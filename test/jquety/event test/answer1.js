

function target02(){
	$("#target02 span").text("¹Ù²å½À´Ï´Ù.");
}


function target04(){
	$(".target04").eq(1).css("background","orange");
}


function target06(){
	//$(".target06 input:checkbox").removeAttr("checked");
	$(".target06 input:checkbox").prop("checked", false);
}


function target08(){
	$(".target08 select option").eq(1).attr("selected","selected");
}


function target10(){
	//$("#target10 select option:nth-child(odd)").css("background","yellow");
	$("#target10 select option:even").css("background","yellow");
}

function target12(){
	$(".target12").not(":parent").remove();
}


function target14(){
	$("#target14 table tr:eq(0)").appendTo("#target14 table");
}

