$(function(){
    var _pro_type_name= $("#_pro_type_name").val();
    if(_pro_type_name=='2'){
        window.parent.document.getElementById('filtering').style.display='block';
        window.parent.document.getElementById('sorting').style.display='block';
        $('#pro_type_name', window.parent.document).html("实体经营项目");
    } if(_pro_type_name=='1'){
        window.parent.document.getElementById('filtering').style.display='block';
        window.parent.document.getElementById('sorting').style.display='block';
        $('#pro_type_name', window.parent.document).html("科技创新项目 ");
    }if(_pro_type_name=='3'){
        window.parent.document.getElementById('filtering').style.display='block';
        window.parent.document.getElementById('sorting').style.display='block';
        $('#pro_type_name', window.parent.document).html("地产投资项目 ");
    }
});

function toProdetailsPage(url){
    var parent = window.parent;
    parent.window.location.target="_blank";
    parent.window.location = url;
}

function externallinks() {
    if (!document.getElementsByTagName) return;
    var anchors = document.getElementsByTagName("a");
    for (var i=0; i<anchors.length; i++) {
        var anchor = anchors[i];
        if (anchor.getAttribute("href") &&
            anchor.getAttribute("rel") == "external")
            anchor.target = "_blank";
    }
}
window.onload = externallinks;