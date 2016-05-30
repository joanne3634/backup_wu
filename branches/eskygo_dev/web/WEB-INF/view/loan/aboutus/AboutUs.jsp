 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>  
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/reset.css">
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/css/public.css">
   <c:if test="${fileid!=null}">
   <img src="${ctx }/wuyouchou/system/sysFile/getFileById.ht?fileId=${fileid}" alt=""></c:if> 
 <p>${cms.contentText}</p> 