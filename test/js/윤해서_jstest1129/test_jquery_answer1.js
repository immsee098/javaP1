// 윤해서


function numCheck01() {
    var a = document.getElementsByName("num")[0].value;

    if(isNaN(a)){
        alert("숫자가 아닙니다");
    } else {
        alert("숫자입니다");
    }
}


function searchStr02() {
    var b = document.getElementById("word").value;
    var contStr = document.getElementById("content").innerHTML;
    var incl = contStr.indexOf(b);

    if(incl !== -1){
        alert("검색어 존재함");
    } else {
        alert("검색어 존재하지 않음");
    }
}


function popupWin03(siteName) {
    window.open(siteName);
}


function allchk04(isChecked) {
    var ck = document.getElementsByName("subject");
    if(isChecked){
        for(var i = 0; i < ck.length; i++){
            ck[i].checked = true;
        }
    }else{
        for(var i = 0; i < ck.length; i++){
            ck[i].checked = false;
        }
    }
}


function randomNum05() {
    var result = Math.floor(Math.random() * 20) + 1;
    document.getElementById("rdmNum").value = result;
}


function selPage06() {
    // var a = document.getElementsByName("selsite").value;
    var a = document.getElementsByName("selsite")[0].value;
    window.open(a);
}