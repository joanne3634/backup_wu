function search(){
    var url= _ctx + "/crowdfunding/memberCenter/toinvestList.ht?";
    var typeId = $("#zijinleixing").val();
    var timeBucket = $("#createTime_id").val();
    url += "typeId=" + typeId;
    url += "&timeBucket=" + timeBucket;
    window.location = url;
}