OfficeControl=function(){var b={};var c=navigator.userAgent.toLowerCase();var d;(d=c.match(/msie ([\d.]+)/))?b.ie=d[1]:(d=c.match(/firefox\/([\d.]+)/))?b.firefox=d[1]:(d=c.match(/chrome\/([\d.]+)/))?b.chrome=d[1]:(d=c.match(/opera.([\d.]+)/))?b.opera=d[1]:(d=c.match(/version\/([\d.]+).*safari/))?b.safari=d[1]:0;this.controlId="";this.controlObj=null;this.height="100%";this.width="100%";var a=this;this.isFileOpen=false;this.templatetype=1;this.params={Caption:"广州帝隆科技有限公司",MakerCaption:"广州帝隆科技有限公司",MakerKey:"CF4960BFDB79D36ADDC5493B116D39D6A4E335D9",ProductCaption:"广州帝隆科技有限公司",ProductKey:"32B10860DB12537FF0003CC2BFD0FA190CB0407E",TitlebarColor:"14402205",IsCheckEkey:"0"};this.config={doctype:"doc",fileId:"",controlId:"officeObj",myNum:"0"};this.itemclick=function(f){var e=f.text;switch(e){case"新建":a.newDoc();break;case"打开":a.controlObj.showDialog(1);break;case"另存为":if(!a.isFileOpen){return;}a.controlObj.showDialog(3);break;case"关闭":if(!a.isFileOpen){return;}a.closeDoc();break;case"打印设置":if(!a.isFileOpen){return;}a.controlObj.showdialog(5);break;case"打印预览":if(!a.isFileOpen){return;}a.controlObj.PrintPreview();break;case"打印":if(!a.isFileOpen){return;}a.controlObj.printout(true);break;}},this.getDocType=function(){var f="Word.Document";var e=this.config.doctype;switch(e){case"doc":f="Word.Document";break;case"xls":f="Excel.Sheet";break;case"ppt":f="PowerPoint.Show";break;}return f;},this.memuItems={width:120,items:[{text:"新建",click:this.itemclick},{text:"打开",click:this.itemclick},{text:"另存为",click:this.itemclick},{text:"关闭",click:this.itemclick},{line:true},{text:"打印设置",click:this.itemclick},{text:"打印预览",click:this.itemclick},{text:"打印",click:this.itemclick}]};this.buttonClick=function(g){var e=g.text;switch(e){case"留痕":a.controlObj.ActiveDocument.TrackRevisions=true;break;case"不留痕":a.controlObj.ActiveDocument.TrackRevisions=false;break;case"清除痕迹":a.controlObj.ActiveDocument.AcceptAllRevisions();break;case"模版套红":a.insertContentTemplate();break;case"选择模版":a.insertTemplate();break;case"手写签名":try{a.controlObj.DoHandSign2("ntko","ntko",0,0,1,100);}catch(f){}break;case"盖章":a.signature();break;case"全屏":a.controlObj.FullScreenMode=true;break;case"转成PDF":a.officeToPdf();break;case"Ekey盖章":a.signatureFromEkey();break;case"PDF盖章":a.signaturePdfFromEkey();break;}},this.getTemplate=function(){var f=__ctx+"/platform/system/sysOfficeTemplate/dialog.ht?type="+this.templatetype;var e="dialogWidth=600px;dialogHeight=400px;help=0;status=0;scroll=1;center=1";f=f.getNewUrl();var g=window.showModalDialog(f,"",e);return g;},this.insertContentTemplate=function(){try{this.templatetype=2;var j=a.getTemplate();this.templatetype=1;if(j==undefined||j==null){return false;}var k=__ctx+"/platform/system/sysOfficeTemplate/getTemplateById.ht?templateId="+j.templateId;var g=a.controlObj.ActiveDocument.Application.Selection;g.WholeStory();g.Cut();if(!(b.firefox)&&!(b.chrome)){a.controlObj.AddTemplateFromURL(k);var h="content";if(!a.controlObj.ActiveDocument.BookMarks.Exists(h)){alert('Word 模板中不存在名称为："'+h+'"的书签！');return false;}var f=a.controlObj.ActiveDocument.BookMarks(h);var e=f.Range;e.Paste();a.controlObj.ActiveDocument.Bookmarks.Add(h,e);}else{a.controlObj.AddTemplateFromURL(k);}}catch(i){$.ligerDialog.error("insertTemplate:"+i.name+": "+i.message);}},this.insertTemplate=function(){try{var g=a.getTemplate();if(g==undefined||g==null){return;}var e=__ctx+"/platform/system/sysOfficeTemplate/getTemplateById.ht?templateId="+g.templateId;a.controlObj.ActiveDocument.Application.Selection.HomeKey(6,0);a.controlObj.OpenFromURL(e);}catch(f){$.ligerDialog.error("insertTemplate:"+f.name+": "+f.message);}},this.getControlHtml=function(f){var g=__ctx+"/media/office/OfficeControl.cab#version=5,0,2,1";var h="";if(b.ie){h='<object  id="'+f+'" codeBase="'+g+'" height="'+this.height+'" width="'+this.width+'" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" style="z-index:-1;">';h+='<param name="IsUseUTF8URL" value="-1">   ';h+='<param name="IsUseUTF8Data" value="-1">   ';h+='<param name="BorderStyle" value="1">   ';h+='<param name="BorderColor" value="14402205">   ';h+='<param name="TitlebarTextColor" value="0">   ';h+='<param name="MenubarColor" value="14402205">   ';h+='<param name="MenuButtonColor" VALUE="16180947">   ';h+='<param name="MenuBarStyle" value="3">   ';h+='<param name="MenuButtonStyle" value="7">   ';for(var e in this.params){h+='<param name="'+e+'" value="'+this.params[e]+'">';}h+='<param name="WebUserName" value="帝隆科技">   ';h+="</object>";}else{if(b.firefox){h='<object id="'+f+'" codeBase="'+g+'" height="'+this.height+'" width="'+this.width+'"  type="application/ntko-plug" ForOnSaveToURL="saveMethodOnComplete"  ForOnAddTemplateFromURL="addTemplateOnComplete'+this.config.myNum+'" ';h+='ForOnpublishAshtmltourl="publishashtml"	';h+='ForOnpublishAspdftourl="publishaspdf"	';h+='ForOnSaveAsOtherFormatToUrl="saveasotherurl"	 ';h+='ForOnDoWebGet="dowebget"	';h+='ForOnDoWebExecute="webExecute"	';h+='ForOnDoWebExecute2="webExecute2"	';h+='ForOnFileCommand="FileCommand"	';h+='ForOnCustomMenuCmd2="CustomMenuCmd"	';h+='_IsUseUTF8URL="-1"  ';h+='_IsUseUTF8Data="-1"  ';h+='_BorderStyle="1"   ';h+='_BorderColor="14402205"   ';h+='_MenubarColor="14402205"   ';h+='_MenuButtonColor="16180947"   ';h+='_MenuBarStyle="3"  ';h+='_MenuButtonStyle="7"   ';for(var e in this.params){h+="_"+e+'="'+this.params[e]+'"	';}h+='_WebUserName="帝隆科技"   ';h+='clsid="{C9BC4DFF-4248-4a3c-8A49-63A7D317F404}" >';h+="</object>  ";}else{if(b.chrome){h='<object id="'+f+'" clsid="{C9BC4DFF-4248-4a3c-8A49-63A7D317F404}"  ForOnSaveToURL="saveMethodOnComplete" ForOnAddTemplateFromURL="addTemplateOnComplete'+this.config.myNum+'" ';h+='ForOnpublishAshtmltourl="publishashtml"	';h+='ForOnpublishAspdftourl="publishaspdf"	';h+='ForOnSaveAsOtherFormatToUrl="saveasotherurl"	';h+='ForOnDoWebGet="dowebget"	';h+='ForOnDoWebExecute="webExecute"	';h+='ForOnDoWebExecute2="webExecute2"	';h+='ForOnFileCommand="FileCommand"	';h+='ForOnCustomMenuCmd2="CustomMenuCmd"	';h+='codeBase="'+g+'" height="'+this.height+'" width="'+this.width+'" type="application/ntko-plug" ';h+='_IsUseUTF8URL="-1"   ';h+='_IsUseUTF8Data="-1"   ';h+='_BorderStyle="1"   ';h+='_BorderColor="14402205"   ';h+='_MenubarColor="14402205"   ';h+='_MenuButtonColor="16180947"   ';h+='_MenuBarStyle="3"  ';h+='_MenuButtonStyle="7"   ';for(var e in this.params){h+="_"+e+'="'+this.params[e]+'"	';}h+='_WebUserName="帝隆科技" >   ';h+="</object>";}}}if(b.firefox||b.chrome){h+=' <script type="text/javascript" > ';h+="		function addTemplateOnComplete"+this.config.myNum+"(){ ";h+='			addTemplateOnComplete("'+this.config.myNum+'"); ';h+="		} ";h+=" <\/script> ";}return h;},this.renderTo=function(i,f){this.config=$.extend({},this.config,f);this.controlId="office_"+i;var h=this.getControlHtml(this.controlId);$("#"+i).html("");$("#"+i).append('<div name="menuBar"></div>');$("#"+i).append(h);var j=document.getElementById(this.controlId);this.controlObj=j;this.controlObj.MenuBar=false;this.controlObj.Titlebar=false;this.controlObj.IsShowToolMenu=true;this.controlObj.ToolBars=true;var g=$(this.controlObj);g.height(g.parent().height()-26);var k=this.config.doctype;var e=[];if(k=="pdf"){e.push({text:"PDF盖章",click:this.buttonClick});}else{e.push({text:"文件",menu:this.memuItems});if(k=="doc"){e.push({text:"留痕",click:this.buttonClick});e.push({text:"不留痕",click:this.buttonClick});e.push({text:"清除痕迹",click:this.buttonClick});}e.push({text:"模版套红",click:this.buttonClick});e.push({text:"选择模版",click:this.buttonClick});e.push({text:"手写签名",click:this.buttonClick});e.push({text:"盖章",click:this.buttonClick});e.push({text:"转成PDF",click:this.buttonClick});e.push({text:"Ekey盖章",click:this.buttonClick});}e.push({text:"全屏",click:this.buttonClick});$("#"+i+" div[name='menuBar']").ligerMenuBar({items:e});if(b.ie||b.firefox||b.chrome){if(k=="pdf"){this.addPDFSupport();this.isFileOpen=true;}else{this.initDoc();}}else{$.ligerDialog.warn("office控件只支持IE、Firefox和Chrome 32位版的浏览器!");}};this.initDoc=function(){if(this.config.fileId!=""&&this.config.fileId>0){var f=__ctx+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+this.config.fileId;try{this.controlObj.OpenFromURL(f);this.isFileOpen=true;}catch(e){try{this.addPDFSupport();this.isFileOpen=true;}catch(e){this.newDoc();}}}else{this.newDoc();}};this.closeDoc=function(){if(b.ie||b.firefox||b.chrome){this.initDoc();}else{$.ligerDialog.warn("office控件只支持IE、Firefox和Chrome 32位版的浏览器!");}try{this.controlObj.close();this.isFileOpen=false;}catch(e){$.ligerDialog.error("closeDoc:"+e.name+": "+e.message);}};this.newDoc=function(){try{var f=this.getDocType();this.controlObj.CreateNew(f);this.isFileOpen=true;}catch(e){$.ligerDialog.error("newDoc:"+e.name+": "+e.message);}};this.saveRemote=function(i){var l=__ctx+"/platform/system/sysFile/saveFile.ht";var k=this.controlId+"_name";var h="fileId="+this.config.fileId+"&uploadName="+k;try{var f=new Date();var e=Math.random()*f.getMilliseconds()*10000;if(this.config.doctype==""||this.config.doctype==null||"undefined"==typeof(this.config.doctype)){var j=this.controlObj.DocType;if(j==2){this.config.doctype="xls";}else{if(j==3){this.config.doctype="ppt";}else{if(j==51){this.config.doctype="pdf";}else{this.config.doctype="doc";}}}}var m;if(b.firefox||b.chrome){if(typeof(i)!=undefined&&i!=null){h+="&inputObjNum="+i;}this.controlObj.SaveToURL(l,k,h,e+"."+this.config.doctype,0);m=-11;}else{m=this.controlObj.SaveToURL(l,k,h,e+"."+this.config.doctype,0);this.config.fileId=m;}return m;}catch(g){alert("saveRemote:"+g.name+": "+g.message);return -1;}};this.signature=function(){var f=__ctx+"/platform/system/seal/dialog.ht";var e="dialogWidth=800px;dialogHeight=600px;help=0;status=0;scroll=1;center=0;resizable=1;";f=f.getNewUrl();var h=window.showModalDialog(f,"",e);if(typeof(h)==undefined||h==null){return false;}if(h.fileId.isEmpty()){return false;}var i=__ctx+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+h.fileId;try{this.controlObj.AddSecSignFromURL(h.sealName,i,0,0,1,2,false,false);}catch(g){alert("signature:"+g.name+": "+g.message);return -1;}};this.signatureFromEkey=function(){if(this.controlObj!=null){this.controlObj.AddSecSignFromEKEY("广州帝隆科技有限公司",0,0,1,2,false,false,true,false,true,-1,true,true);}};this.signaturePdfFromEkey=function(){if(this.controlObj!=null){this.controlObj.AddPDFSecSignFromEKEY("广州帝隆科技有限公司",null,"111111",null,1,null,null,null,null,true,false,true,false,null);}};this.officeToPdf=function(){if(!confirm("文档转换成PDF后将不可以恢复原有格式文档，确认转换吗？")){return;}try{var h=__ctx+"/platform/system/sysFile/saveFilePdf.ht";var e=this.controlId+"_pdf";var i="fileId="+this.config.fileId+"&uploadName="+e;var f=this.config.fileId+".pdf";this.controlObj.PublishAsPDFToURL(h,e,i,f,0,null,true,true,false,true,true,true);}catch(g){alert("officeToPdf:"+g.name+": "+g.message);}};this.addPDFSupport=function(){if(document.URL.indexOf("file://")>=0){if(!confirm("如果从本地磁盘打开的URL，需要手工运行命令'regsvr32 ntkopdfdoc.dll'注册插件文件.您确认已经注册了吗？")){return;}}var e=__ctx+"/wuyouchou/system/sysFile/getFileById.ht?fileId="+this.config.fileId;this.controlObj.AddDocTypePlugin(".pdf","PDF.NtkoDocument","4.0.0.1",__ctx+"/media/office/ntkopdfdoc.cab",51,true);this.controlObj.OpenFromURL(e);};};function saveMethodOnComplete(b,c,a){var g=a.split("##");var f=g[0];var e=g[1];if(f>=0&&e!=""){OfficePlugin.fileObjs.get(f).setAttribute("value",e);OfficePlugin.officeObjs[f].config.fileId=e;}OfficePlugin.hasSubmitOffices[f]=true;OfficePlugin.submitNewNum=OfficePlugin.submitNewNum+1;if(OfficePlugin.submitNum==OfficePlugin.submitNewNum){var d=CustomForm.getData();$("#formData").val(d);$("#frmWorkFlow").submit();OfficePlugin.submitNewNum=0;}}function addTemplateOnComplete(c){myObj=OfficePlugin.officeObjs[c];var d="content";if(!myObj.controlObj.ActiveDocument.BookMarks.Exists(d)){alert('Word 模板中不存在名称为："'+d+'"的书签！');return false;}var b=myObj.controlObj.ActiveDocument.BookMarks.Item(d);var a=b.Range;a.Paste();myObj.controlObj.ActiveDocument.Bookmarks.Add(d,a);}