function VarsWindow(d){if(!d){d={};}var c=__ctx+"/platform/bpm/bpmDefVar/edit.ht?defId="+d.defId+"&varId="+d.varId;var f=500;var b=300;d=$.extend({},{dialogWidth:f,dialogHeight:b,help:0,status:0,scroll:0,center:1},d);var a="dialogWidth="+d.dialogWidth+"px;dialogHeight="+d.dialogHeight+"px;help="+d.help+";status="+d.status+";scroll="+d.scroll+";center="+d.center;c=c.getNewUrl();var e=window.showModalDialog(c,"",a);if(d){location.reload();}}