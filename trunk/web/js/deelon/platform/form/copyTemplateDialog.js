function CopyTemplateDialog(g){if(!g){g={};}var c=g.templateId;var j=g.templateName;var f=g.alias;var a="copy.ht?templateId="+c;var d=450;var i=250;$.extend(g,{dialogWidth:d,dialogHeight:i,help:0,status:0,scroll:0,center:1});var e={templateId:g.templateId,templateName:g.templateName,alias:g.alias};var b="dialogWidth="+g.dialogWidth+"px;dialogHeight="+g.dialogHeight+"px;help="+g.help+";status="+g.status+";scroll="+g.scroll+";center="+g.center;a=a.getNewUrl();var h=window.showModalDialog(a,e,b);if(g){location.reload();}}