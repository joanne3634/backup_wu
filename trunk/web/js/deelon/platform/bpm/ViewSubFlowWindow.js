function ViewSubFlowWindow(d){if(!d){d={};}var c=__ctx+"/platform/bpm/bpmDefinition/subFlowImage.ht?defId="+d.defId+"&actDefId="+d.actDefId+"&nodeId="+d.nodeId;var f=800;var b=600;d=$.extend({},{dialogWidth:f,dialogHeight:b,help:0,status:0,scroll:0,center:1},d);var a="dialogWidth="+d.dialogWidth+"px;dialogHeight="+d.dialogHeight+"px;help="+d.help+";status="+d.status+";scroll="+d.scroll+";center="+d.center;c=c.getNewUrl();var e=window.showModalDialog(c,"",a);}