$('.tabs-nav li a').on('click', function(e) {
    var li = $(this).closest('li');
    if(li.hasClass('active')) {
        e.preventDefault();
        return false;
    }
    $('.tabs-nav li').removeClass('active');
    li.addClass('active');
});
/**
 *申请认筹资格
 */
function toApplyEnqPage(){
    window.top.$.Dialog.confirm("提示", "您需要先支付项目认筹诚意金，现在就去支付吗?", function () {
        window.parent.target = "_blank";
        window.parent.open(_ctx + '/crowdfunding/memberCenter/toApplyEnqPage.ht');
        window.top.$.Dialog.bankConfirm(function () {
            window.top.location = _ctx + '/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord';
        }, function () {
            window.top.location = _ctx + '/loan/aboutus/HelpCenterList.ht';
        }, function () {
            window.location.reload(false);
        });
    });
}
