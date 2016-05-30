$('.tabs-nav li a').on('click', function(e) {
    var li = $(this).closest('li');
    if(li.hasClass('active')) {
        e.preventDefault();
        return false;
    }
    $('.tabs-nav li').removeClass('active');
    li.addClass('active');
});
