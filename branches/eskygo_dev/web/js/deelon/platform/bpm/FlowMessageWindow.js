function FlowMessageWindow(d){if(!d){d={};}var c=__ctx+"/platform/bpm/bpmNodeMessage/edit.ht?actDefId="+d.actDefId+"&nodeId="+d.nodeId;var f=780;var b=580;d=$.extend({},{dialogWidth:f,dialogHeight:b,help:0,status:0,scroll:1,center:1},d);var a="dialogWidth="+d.dialogWidth+"px;dialogHeight="+d.dialogHeight+"px;help="+d.help+";status="+d.status+";scroll="+d.scroll+";center="+d.center;c=c.getNewUrl();var e=window.showModalDialog(c,"",a);}