if(typeof ColumnDialogOption=="undefined"){ColumnDialogOption={};}$(function(){$("#option-table>tbody").delegate("tr.noramlTr","mouseover mouseleave",function(a){if(a.type=="mouseover"){$(this).addClass("hover");}else{$(this).removeClass("hover");}});$("#option-table>tbody").delegate("tr.noramlTr","click",function(g){var d=$(this),i=$("#moreInfo"),h=$("#hiddenTable"),c=d.next().attr("id"),b=null;if(c=="moreInfo"){b=d;if(b){ColumnDialogOption.saveData(b,i);}h.append(i);}else{var a=i.prev();if(a.hasClass("noramlTr")){b=a;}var f=d.data("resData");if(b){ColumnDialogOption.saveData(b,i);}ColumnDialogOption.displayData(f,i);i.insertAfter(d);}ColumnDialogOption.stopBubble(g);});$("#option-table>tbody").delegate("a.link.del","click",function(d){ColumnDialogOption.stopBubble(d);if(confirm("确认删除？")){var b=$(this),c=b.parents("tr.noramlTr"),a=c.next().attr("id");if(a=="moreInfo"){$("#hiddenTable").append($("#moreInfo"));}c.remove();}});$("#option-table>tbody").delegate("a.link.moveup","click",function(a){ColumnDialogOption.stopBubble(a);ColumnDialogOption.move($(this),true);});$("#option-table>tbody").delegate("a.link.movedown","click",function(a){ColumnDialogOption.stopBubble(a);ColumnDialogOption.move($(this),false);});$("a.add").click(function(){var c={key:"",value:[]},a=ColumnDialogOption.genDescript(c);var b=$("#option-table>tbody");b.append(a);});});ColumnDialogOption.move=function(d,a){var c=d.parents("tr.noramlTr");if(a){var e=c.prev();if(e.length>0){c.insertBefore(e);}}else{var b=c.next();if(b.length>0){c.insertAfter(b);}}};ColumnDialogOption.stopBubble=function(a){if(a&&a.stopPropagation){a.stopPropagation();}else{window.event.cancelBubble=true;}};ColumnDialogOption.init=function(e){if(!e){return;}var b=$("#option-table>tbody");for(var d=0,f;f=e[d++];){var a=ColumnDialogOption.genDescript(f);b.append(a);}};ColumnDialogOption.displayData=function(c,b){var a=c.value;$("input[name='key']",b).val(c.key);$("input.long",b).each(function(){var f=$(this).val(""),d=f.attr("name");for(var e=0,g;g=a[e++];){if(g.lantype==d){f.val(g.lanres);}}});};ColumnDialogOption.saveData=function(c,e){var b=$("input[name='key']",e).val(),d=[],a=c.data("resData");$("input.long",e).each(function(){var h=$(this),g=h.attr("name"),i=h.val(),f=h.attr("title");d.push({lantype:g,lanres:i,lanmemo:f});});a.key=b;a.value=d;c.data("resData",a);c.before(ColumnDialogOption.genDescript(a));c.remove();return a;};ColumnDialogOption.genDescript=function(c){var b=ColumnDialogOption.getSelectValue(c.value),m=c.key;var g=$("<span></span>").html(b).attr("title",b),j=$('<div style="overflow:hidden;width:400px;"></div>').append(g),e=$("<td></td>").append(j),h=$("<span></span>").html(m).attr("title",m),k=$('<a href="#" class="link moveup"></a><a href="#" class="link movedown"></a><a href="#" class="link del"></a>'),d=$('<div style="width:60px;overflow:hidden;height:20px;float:left;"></div>').append(h),l=$('<div style="width:40px;float:right;"></div>').append(k),a=$('<div style="width:100px;height:20px;"></div>').append(d).append(l),f=$('<td align="right"></td>').append(a),i=$('<tr class="noramlTr"></tr>').append(e).append(f);i.data("resData",c);return i;};ColumnDialogOption.getSelectValue=function(d){if(!d||d.length==0){return"";}var b=[];if(d.length==0){return b;}for(var a=0,e;e=d[a++];){b.push("["+e.lanmemo+"]"+e.lanres);}return b.join("  ");};ColumnDialogOption.reset=function(){$("tr.noramlTr").remove();};ColumnDialogOption.getData=function(){var a=[];$("tr.noramlTr").each(function(){var c=$(this),b=c.next().attr("id"),d={};if(b=="moreInfo"){d=ColumnDialogOption.saveData(c,$("#moreInfo"));}else{d=c.data("resData");}a.push(d);});return a;};