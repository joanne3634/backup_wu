function addRow(){var b=$("#trContainer");var a=b.children().length;var f=(a%2==0)?"odd":"even";var c="";c+='<tr class="'+f+'">';c+='<td style="text-align: center;">';c+='<input type="text" id="paraName" name="paraName" />';c+="</td>";c+='<td style="text-align: center;">';c+='<select id="paraType" name="paraType">';c+='<option value="int">int</option>';c+='<option value="long">long</option>';c+='<option value="float">float</option>';c+='<option value="string">string</option>';c+='<option value="blooean">blooean</option>';c+="</select>";c+="</td>";c+='<td style="text-align: center;">';c+='<input type="text" id="paraValue" name="paraValue"/>';c+="</td>";c+="<td>";c+='<a href="#" class="link-del" onclick="delRow(this);"><span class="link-btn">删除</span></a>';c+="</td>";c+="</tr>";var d=$(c);var e=$("#trContainer");e.append(d);}function delRow(b){var b=$(b);var a=b.parent().parent();a.remove();}function validClass(){var a=$("#className").val();if(a.length==0){$.ligerDialog.warn("请先输入任务类名再点击验证按钮","提示信息");return;}var b="className="+a;$.post("validClass.ht",b,function(d){var c=new com.deelon.form.ResultMessage(d);if(c.isSuccess()){$.ligerDialog.success(c.getMessage(),"操作成功");}else{$.ligerDialog.error(c.getMessage(),"操作失败");}});}function setParameterXml(){var b=$("#trContainer");var a=b.children().length;var d=b.children();var c="[";d.each(function(f){var e=$(this).find("input[name=paraName]").val();var g=$(this).find("select[name=paraType]").val();var h=$(this).find("input[name=paraValue]").val();if(f<a-1){c+='{"name":"'+e+'","type":"'+g+'","value":"'+h+'"},';}else{c+='{"name":"'+e+'","type":"'+g+'","value":"'+h+'"}';}});c+="]";return c;}