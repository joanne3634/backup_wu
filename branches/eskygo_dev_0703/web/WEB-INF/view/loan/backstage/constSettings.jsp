<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="submitConstSettings.ht" method="post">
		<a href="addSettingsInit.ht">添加参数</a>
		<input type="file">
		<table>
			<tbody>
				<c:forEach var="setting" items="${constSettings}">
					<tr>
						<td><c:out value="${setting.setDesc}" /></td>
						<td>
						<input type="hidden" name="settingsId" value="${setting.settingsId}">
						<input type="hidden" name="settingName" value="${setting.setCode}">
						<input type="text" name="setting" value="${setting.setValue}"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<input name="submit" type="submit" value="保存 ">
	</form>
</body>
</html>