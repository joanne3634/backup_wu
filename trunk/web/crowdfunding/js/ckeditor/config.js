/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For complete reference see:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	// The toolbar groups arrangement, optimized for two toolbar rows.
	config.toolbarGroups = [
	                        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
	                        { name: 'styles' },
	                		{ name: 'colors' },
	                		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align' ] },
	                		//{ name: 'links' },
	                		{ name: 'insert' },
	                		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
	                		{ name: 'editing',     groups: [ 'find', 'selection' ] } 
	                		//{ name: 'forms' },, 'spellchecker'
	                		//{ name: 'tools' },
	                		//{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
	                		//{ name: 'others' },
	                		//'/',
	                		//{ name: 'about' }
	                	];
	                	config.removePlugins = 'elementspath';

	// Remove some buttons provided by the standard plugins, which are
	// not needed in the Standard(s) toolbar.
	config.removeButtons = 'Underline,Subscript,Superscript';

	// Set the most common block elements.
	config.format_tags = 'p;h1;h2;h3;pre';

	// Simplify the dialog windows.
	config.removeDialogTabs = 'image:advanced;link:advanced';
	
	config.toolbarStartupExpanded = false;
	config.image_previewText="无图片";
	config.filebrowserImageUploadUrl=__ctx+"/platform/system/sysFile/fileUpload.ht;jsessionid="+__jsessionId+"?catKey=ATTACH_TYPE&nodeKey=IMAGE";
	config.filebrowserUploadUrl=__ctx+"/platform/system/sysFile/fileUpload.ht;jsessionid="+__jsessionId+"?catKey=ATTACH_TYPE&nodeKey=FILE";
	config.filebrowserFlashUploadUrl=__ctx+"/platform/system/sysFile/fileUpload.ht;jsessionid="+__jsessionId+"?catKey=ATTACH_TYPE&nodeKey=FLASH";
	config.font_names="宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;微软雅黑/微软雅黑;方正舒体/方正舒体;方正姚体/方正姚体;华文彩云/华文彩云;华文仿宋/华文仿宋;华文行楷/华文行楷;华文琥珀/华文琥珀;华文楷体/华文楷体;华文隶书/华文隶书;华文宋体/华文宋体;华文细黑/华文细黑;华文新魏/华文新魏;华文中宋/华文中宋;新宋/新宋;"+config.font_names;
	//config.en
	//terMode = CKEDITOR.ENTER_BR;
    //config.shiftEnterMode = CKEDITOR.ENTER_BR; 
};
