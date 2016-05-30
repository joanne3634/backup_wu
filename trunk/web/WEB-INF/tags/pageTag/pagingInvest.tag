<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ attribute name="form" type="java.lang.String"%>
<%@ attribute name="align" type="java.lang.String" %>
<style type="text/css">
     .paging-index-box {
        padding-top: 0px;
        padding-bottom: 0px;
        color: #555;
        text-align: center;
        margin: 0px 0px 0px 0px;
      }
      .paging-index-box a {
        display: inline-block;
        height: 22px;
        margin-left: 3px;
        margin-right: 3px;
        padding-left: 8px;
        padding-right: 8px;
        line-height: 22px;
        color: #999;
        border: 1px solid #999;
      }
      .paging-index-box a:hover {
        text-decoration: none;
        color: #fff;
        background-color: #ff5200;
        border-color: #ff5200;
      }
      .paging-index-box .page-num {
        color: #ff5200;
      }
   
</style>
<script type="text/javascript">
	function goPage(n,form){
		document.getElementById("current_page").value=n;
		form.submit();
		
	}
	
	function first(form){
		<c:if test="${page_bean.currentPage==1 or page_bean.totalPage==0}">
		return false;
		</c:if>
		goPage(1,form);
	}
	
	function last(form){
		<c:if test="${page_bean.currentPage==page_bean.totalPage or page_bean.totalPage==0}">
			return false;
		</c:if>
		goPage(${page_bean.totalPage},form);
	}
	
	function next(form){
		<c:if test="${page_bean.currentPage>=page_bean.totalPage or page_bean.totalPage==0}">
			return false;
		</c:if>
		var current_page=document.getElementById("current_page").value;
		goPage(parseInt(current_page)+1,form);
	}
	
	function previous(form){
		<c:if test="${page_bean.currentPage==1 or page_bean.totalPage==0}">
		return false;
		</c:if>
		var current_page=document.getElementById("current_page").value;
		goPage(current_page-1,form);
	}
	function pageChange(form){ 
		form.submit(); 
	}
</script>

<%	 
	com.deelon.core.page.PageBean pb=(com.deelon.core.page.PageBean)request.getAttribute("page_bean");
	if(form==null||"".equals(form)){
		form="this.form";
	}
	request.setAttribute("form",form);
	int min=1;
	int max=1;
	int totalPages=pb.getTotalPage();
	int curPageNo=pb.getCurrentPage();
	
	if(totalPages - curPageNo >= 4){
        if(curPageNo >= 5)
        	min=curPageNo - 4; 
        else
        	min=1;
	}else{          
         if(curPageNo >= (5 + 4 - totalPages + curPageNo))
         {
           	min=curPageNo - 8 + totalPages - curPageNo;
         }
         else 
         {
           	min=1;
         }  		
	}
	
	max = min + 4 > totalPages ? totalPages : min +4;
	request.setAttribute("min",String.valueOf(min));
	request.setAttribute("max",String.valueOf(max));
%>
	<c:if test="${not empty page_bean}" >
		<div class="paging-index-box">
			<input type="hidden" id="current_page" name="current_page" value="${page_bean.currentPage}" />
	      <a href="javascript:;" onclick="first(${form});return false;"    <c:if test="${page_bean.currentPage==1 or page_bean.totalPage==0}">disabled="disabled"</c:if>><%="\u9996\u9875" %></a> 
	      <a href="javascript:;" onclick="previous(${form});return false;"  <c:if test="${page_bean.currentPage==1 or page_bean.totalPage==0}">disabled="disabled"</c:if>><%="\u4e0a\u4e00\u9875" %></a> 
	      <c:forEach begin="${min}" end="${max}" step="1" var="i"> 
					 <a class="page-num"  <c:if test="${page_bean.currentPage==i }">style="text-decoration: none;color: #fff;background-color: #ff5200;border-color: #ff5200;" </c:if> href="javascript:;"  onclick="goPage(${i},${form});">${i}</a> 
		</c:forEach>
	      <a href="javascript:;" onclick="next(${form});return false;" <c:if test="${page_bean.currentPage>=page_bean.totalPage or page_bean.totalPage==0}">disabled="disabled"</c:if>><%="\u4e0b\u4e00\u9875" %></a> 
	      <a href="javascript:;"  onclick="last(${form});return false;" <c:if test="${page_bean.currentPage==page_bean.totalPage or page_bean.totalPage==0}">disabled="disabled"</c:if>><%="\u5c3e\u9875" %></a>
    	</div>			
	</c:if>

<c:remove var="page_bean" scope="request"/>