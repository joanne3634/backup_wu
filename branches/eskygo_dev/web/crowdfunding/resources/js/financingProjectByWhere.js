function loadPages(m,n) {
    var orderBy = $("#orderBy").val();
    var url=_ctx+"/crowdfunding/front/tofinancingProList.ht?pflag=1&orderBy="+orderBy;
    $("#a"+n).val(m);
    var a1=$("#a1").val();
    var a2=$("#a2").val();
    var a3=$("#a3").val();
    if(a1!=''){
        url+=a1;
    }
    if(a2!=''){
        url+=a2;
    }
    if(a3!=''){
        url+=a3;
    }
    $("#iframepage").attr("src", url);
}

function iFrameHeight() {
    var ifm= document.getElementById("iframepage");
    var subWeb = document.frames ? document.frames["iframepage"].document :
        ifm.contentDocument;
    if(ifm != null && subWeb != null) {
        ifm.height = subWeb.body.scrollHeight;
    }
}

$("#filtering a").click(function(){
    $(this).addClass('active').siblings().removeClass('active');
});

$("#sorting li").click(function(){
    $(this).addClass('active').siblings().removeClass('active');
    var orderBy = $("#orderBy").val();
    orderBy = orderBy==0 ? 1 : 0;
    $("#orderBy").val(orderBy);
    var url=_ctx+"/crowdfunding/front/tofinancingProList.ht?DescList="+$(this).index()+"&orderBy="+orderBy;
    var a1=$("#a1").val();
    var a2=$("#a2").val();
    var a3=$("#a3").val();
    if(a1!=''){
        url+=a1;
    }
    if(a2!=''){
        url+=a2;
    }
    if(a3!=''){
        url+=a3;
    }
    $("#iframepage").attr("src", url);
});