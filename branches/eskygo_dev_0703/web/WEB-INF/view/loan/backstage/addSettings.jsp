<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
    <form action="addSettings.ht" method="post">
        <table>
            <tbody>
                <tr>
                    <td>参数类型</td>
                    <td><input type="text" name="typeId"></td>
                </tr>
                <tr>
                    <td>参数别名</td>
                    <td><input type="text" name="SetCode"></td>
                </tr>
                <tr>
                    <td>参数值</td>
                    <td><input type="text" name="SetValue"></td>
                </tr>
                <tr>
                    <td>参数描述</td>
                    <td><input type="text" name="SetDesc"></td>
                </tr>
            </tbody>
        </table>
        <input type="submit" value="添加">
    </form>

</body>
</html>