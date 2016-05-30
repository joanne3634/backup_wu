/**
 * Created by Iccy on 15/6/1.
 */
$().ready(function() {
    //$("#tuserMsgremindform").validate({
    //    rules: {
    //        content: {
    //            required: true
    //        },
    //        code: {
    //            required: true
    //        }
    //    },
    //    messages: {
    //        content: {
    //            required: "必填"
    //        },
    //        code: {
    //            required: "必填"
    //        }
    //    }
    //});


    $("#FProvincesId").change(function(){
        loadPages('FProvincesId',3);
        $("#FCityId").html("<option value=''>请选择市</option>");
        if($(this).val() =="请选择省"){return;}

        $.ajax({
            url : _ctx + "/user/ajaxGetJilian.ht",
            type : 'post',
            data : "areaId=" + $(this).val(),
            dataType : 'json',
            success : function(data) {
                var html = "<option value='请选择市'>请选择市</option>";
                if(data.length > 0){
                    for ( var i = 0; i < data.length; i++) {
                        html += "<option value='" + data[i].areaId + "'>" + data[i].areaName + "</option>";
                    }
                }
                $("#FCityId").html(html);

            },
            error : function(xhr, textStatus, errorThrown) {
                alert('异步获取数据出现异常');
            }
        });
    });
});

function loadPages(p,m) {
    var url= _ctx + "/crowdfunding/tcuserInvestor/tcuserInvestorPageList.ht?pflag=1";

    if(p == "FProvincesId"){
        if($("#" + p).val() !="请选择省"){
            var a1 = "&provincesId=" + $("#" + p).val();
            $("#a" + m).val(a1);
            $("#a2").val('');

        }else{
            $("#a" + m).val('');
            $("#a" + (m+1)).val('');
        }
    }else if(p == "FCityId"){
        if($("#FProvincesId").val()!="请选择省"){
            if($("#" + p).val() !="请选择市"){
                var a1 = "&cityId=" + $("#" + p).val();
                $("#a" + m).val(a1);
                $("#a2").val('');

            }
        }else{
            $("#a" + m).val('');
        }
    }else if(p == "isCompanyAndLeader"){
        var a1 = "&isCompanyAndLeader=isCompanyAndLeader";
        $("#a" + m).val(a1);

    }else if(p == "isLeader_yes"){
        var a1 = "&isLeader=1";
        $("#a" + m).val(a1);
    }else if(p == "isLeader_no"){
        var a1 = "&isLeader=0";
        $("#a" + m).val(a1);
    }else if(p == "quanbu"){
        var a1 = "";
        $("#a" + m).val(a1);
    }else{
        var a1 = "&cityIds=" + p;
        $("#a" + m).val(a1);
        $("#a3").val('');
        $("#a4").val('');
    }
    for(var i = 1; i < 5; i++){
        url += $("#a" + i).val();
    }
    //var url="${ctx}/project/getTenderProjectsListPage.ht";
    //alert(url);
    $("#iframepage").attr("src", url);
}


function xuanzeCity(obj,p){
    $(obj).addClass("Ahover");
    loadPages(p,2);
}
//显示投资人详情显示层
function loadPagesDetails(p,d){
    if(p ==""){
        return;
    }
    $.Dialog.modalIframe({
        url: _ctx + '/crowdfunding/tcuserInvestor/tcuserInvestorPageDetails.ht?userId='+p,
        title: d + '详细资料',
        width: '500px',
        height: '420px'
    });
}

//私信详情显示层
function loadPagesSendMsgremind(p){

    $.ajax({
        url : _ctx + "/user/valiLoginTimeout.ht",
        type : 'post',
        dataType : 'json',
        success : function(data) {
            if(data){
                if(p ==""){
                    return;
                }
                $.Dialog.modalIframe({
                    url: _ctx + '/crowdfunding/front/openSendInfoWin.ht?receiverId=' + p + '&type_id=1',
                    title: "发私信",
                    width: '650px',
                    height: '420px'
                });
            }else{
                window.parent.location.href = _ctx+'/loginWeb.jsp';
            }
        }
    });

}

//自荐项目显示层
function loadPageszijianMyProject(p){

    $.ajax({
        url : _ctx + "/user/valiLoginTimeout.ht",
        type : 'post',
        dataType : 'json',
        success : function(data) {
            if(!data){
                window.parent.location.href = _ctx + '/loginWeb.jsp';
            }else{
                if(p ==""){
                    return;
                }
                $.Dialog.modalIframe({
                    url: _ctx+'/crowdfunding/tcuserInvestor/zijianMyProjectPage.ht?receiverId='+p,
                    title: "推荐我的项目",
                    width: '620px',
                    height: '500px'
                });
            }
        }
    });

}

//关闭窗口（关闭所有弹出窗口）
function closediv(){
    $("#faqbg").css("display","none");
    $("#faqdiv").css("display","none");
    $("#faqdiv2").css("display","none");
}


$(function(){
    $(".incestorLeftlist a").click(function(){
        $(this).addClass('Ahover').siblings().removeClass('Ahover');
    });
})