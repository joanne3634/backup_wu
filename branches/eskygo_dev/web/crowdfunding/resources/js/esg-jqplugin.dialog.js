/*!
 * Eskygo Dialog
 * http://www.eskygo.com
 * deps: [ink,jquery]
 * author: cnye@eskygo.com
 */
;(function( $, Ink, window, document, undefined ) {

    'use strict';

    var Dialog = function(options) {

    };

    Dialog.alert = function(title, message, callback) {
        var AlertContentMarkup = [
            '<div class="modal-header">',
            //'    <button class="modal-close ink-dismiss"></button>',
            '   <h2>{title}</h2>',
            '</div>',
            '<div class="modal-body">',
            '{content}',
            '</div>',
            '<div class="modal-footer">',
            '<div class="push-center align-center">',
            '<button class="ink-button blue ink-dismiss">确 定</button>',
            '</div>',
            '</div>'].join('');

        AlertContentMarkup = AlertContentMarkup.replace('{title}', title || "").replace('{content}', message || "");
        Ink.requireModules( ['Ink.UI.Modal_1'], function( Modal ){
            var alertModal = new Modal( "", {
                width: '300px',
                height: '180px',
                modalClass: 'EsgDialogAlert',
                markup: AlertContentMarkup,
                onDismiss: function() {
                    callback && callback();
                }
            });
        });
    };

    Dialog.confirm = function (title, message, confirmHandler, cancelHandler) {
        var className = 'EsgDialogConfirm';
        var ConfirmContentMarkup = [
            '<div class="modal-header">',
            //'    <button class="modal-close ink-dismiss"></button>',
            '   <h2>{title}</h2>',
            '</div>',
            '<div class="modal-body">',
            '{content}',
            '</div>',
            '<div class="modal-footer">',
            '<div class="push-center align-center">',
            '<button class="ink-button blue ink-dismiss" data-type="Confirm">确 定</button>',
            '<button class="ink-button white ink-dismiss" data-type="Cancel">取 消</button>',
            '</div>',
            '</div>'].join('');

        ConfirmContentMarkup = ConfirmContentMarkup.replace('{title}', title || "").replace('{content}', message || "");
        Ink.requireModules( ['Ink.UI.Modal_1'], function( Modal ){
            var confirmModal = new Modal( "", {
                width: '300px',
                height: '180px',
                modalClass: className,
                markup: ConfirmContentMarkup
            });

            $(['.',className].join('')).find('.ink-dismiss').on('click', function(e){
                if($(this).data('type') === "Confirm"){
                    confirmHandler && confirmHandler(e);
                } else {
                    cancelHandler && cancelHandler(e);
                }
            });
        });
    };

    Dialog.toast = function(options) {
        var className = 'EsgDialogToast';
        var ToastContentMarkup = [
            '<div class="modal-header">',
            '    <button class="modal-close ink-dismiss"></button>',
            '   <h2>{title}</h2>',
            '</div>',
            '<div class="modal-body">',
            '{content}',
            '</div>'].join('');

        ToastContentMarkup = ToastContentMarkup.replace('{title}', options.title || "提示").replace('{content}', options.content || "");
        var toastModal = null;
        Ink.requireModules( ['Ink.UI.Modal_1'], function( Modal ){
            toastModal = new Modal( "", {
                width: options.width || '300px',
                height: options.height || '180px',
                modalClass: className,
                markup: ToastContentMarkup,
                onDismiss: options.onDismiss
            });
        });
        return toastModal;
    };

    Dialog.modal = function(options) {

    };

    Dialog.modalIframe = function(options) {
        var className = 'EsgDialogIframe';
        var iframeContentMarkup = [
            '<div class="modal-header">',
            '    <button class="modal-close ink-dismiss"></button>',
            '   <h2>{title}</h2>',
            '</div>',
            '<div class="modal-body" style="overflow-x: hidden;overflow-y: {overflowY}">',
            '<iframe frameborder="0" width="100%" height="100%" src="{url}" onload="iFrameHeight();"></iframe>',
            '</div>'].join('');
        iframeContentMarkup = iframeContentMarkup.replace('{title}', options.title || "").replace('{url}', options.url || "").replace('{overflowY}', options.overflowY || "auto");
        var resultModal = null;
        Ink.requireModules( ['Ink.UI.Modal_1'], function( Modal ){
            resultModal = new Modal( "", {
                width: options.width || '500px',
                height: options.height || '300px',
                responsive: true,
                modalClass: className,
                markup: iframeContentMarkup,
                onDismiss: options.onDismiss
            });
        });
        return resultModal;
    };

    $.extend(Dialog.prototype, {

    });

    $.fn.Dialog = function(options) {

    };

    $.Dialog = Dialog;

}( jQuery, Ink, window, document ));