<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>

<!DOCTYPE  html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>Blog</title>
    <style type="text/css">
        a {
            float: right;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div id="header">
        <% String user = (String)session.getAttribute("user"); %>
        <% if(user == null) { %>
            <a href="Login.jsp">注册</a>

            <a href="Login.jsp">登录 &nbsp; &nbsp;</a>
        <% } else { %>
            <a href="index.jsp"><%=user%></a>
        <% } %>
    </div>
</body>

</html>
