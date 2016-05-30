var detailTabs = null;
Ink.requireModules( ['Ink.Dom.Selector_1','Ink.UI.Tabs_1'], function( Selector, Tabs ){
    detailTabs = new Tabs('#detailTabs', {
        onChange: function(){
            setTimeout(window.parent.iFrameHeight, "1000");
        }
    });
});

$.extend($.Dialog, {
    saveVideo : function (content ,confirmHandler) {
        var className = 'EsgDialogSaveVideo';
        var SaveVideoContentMarkup = [
            '<div class="modal-header">',
            '<button class="modal-close ink-dismiss"></button>',
            '   <h2></h2>',
            '</div>',
            '<div class="modal-body">',
            '{content}',
            '</div>',
            '<div class="modal-footer">',
            '<div class="push-center align-center">',
            '<button class="ink-button blue ink-dismiss" data-type="Save">确 定</button>',
            '</div>',
            '</div>'].join('');
        SaveVideoContentMarkup = SaveVideoContentMarkup.replace('{content}', content || "");
        Ink.requireModules( ['Ink.UI.Modal_1'], function( Modal ){
            var saveVideoModal = new Modal( "", {
                width: '450px',
                height: '180px',
                modalClass: className,
                markup: SaveVideoContentMarkup
            });

            $(['.',className].join('')).find('.ink-dismiss').on('click', function(e){
                if($(this).data('type') === "Save"){
                    confirmHandler && confirmHandler(e);
                }
            });
        });
    }
});