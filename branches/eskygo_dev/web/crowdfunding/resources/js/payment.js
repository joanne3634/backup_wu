$('.tabs-nav li a').on('click', function(e) {
    var li = $(this).closest('li');
    if(li.hasClass('active')) {
        e.preventDefault();
        return false;
    }
    $('.tabs-nav li').removeClass('active');
    li.addClass('active');

    $(".tabs-content").css("display","none");
    $(".tabs-content."+li.attr("id")).show();

});

$(function(){

       var parents = $('.control.voRadio label').find('input[type="radio"]');
        parents.each(function(){
        var self = $(this);
        if(self.is(":checked")){
            var div = $(this).closest('div');
            $('#RadioList .voRadio').removeClass('checked');
            div.addClass('checked');
        }
        });

    $('.control.voRadio').on('click', function(e) {
        $('#RadioList .voRadio').removeClass('checked');
        $(this).addClass('checked');
    });
});




Ink.requireModules( [ 'Ink.UI.FormValidator_2', 'Ink.Dom.Selector_1'], function( FormValidator,Selector) {
    FormValidator.setRule('atLeastOne', '请选择一个银行', function( value ){
        return !!Selector.select('input[type="radio"]:checked',this.getElement()).length;
    });
    //手机号码
    var sendForm_Validator = new FormValidator('#sendForm', {});
});



