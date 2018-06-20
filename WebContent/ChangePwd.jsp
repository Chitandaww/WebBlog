<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>

<%
	boolean wrongPwd = false;
	boolean wrongConf = false;
	//Get Name
	String name = request.getParameter("name");
	//Connect database
	String connectString = "jdbc:mysql://172.18.187.233:53306/proj_user"
	        + "?autoReconnect=true&useUnicode=true"
	        + "&verifyServerCertificate=false&useSSL=false"
	        + "&characterEncoding=UTF-8";
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection(connectString,
	        "user", "123");
	if(request.getMethod().equalsIgnoreCase("post"))
	{
		String oriPwd = request.getParameter("oriPwd");
		Statement stmt = con.createStatement();
		//check origin password
		String getOriPwd = "SELECT password FROM login_info WHERE name='" + name + "' AND password='" + oriPwd + "';";
		ResultSet oriRs = stmt.executeQuery(getOriPwd);
		if(!oriRs.next())
		{
			wrongPwd = true;	
		}
		else
		{
			String confPwd = request.getParameter("confPwd");
			String newPwd = request.getParameter("newPwd");
			if(!confPwd.equals(newPwd))
			{
				wrongConf = true;
			}
			else
			{
				String changePwd = "UPDATE login_info SET password='" + newPwd + "' WHERE name='" + name + "';";
				int ins = stmt.executeUpdate(changePwd);
				session.setAttribute("user", null);
				response.sendRedirect("Login.jsp?name=" + name);
			}
		}
	}
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Profile</title>
	<style></style>
</head>
<body>
	<h1>修改密码</h1>
	<form method="post" id="pwdForm">
		<p>输入原密码：<input type="password" name="oriPwd" id="oriPwd">
		<%
			if(wrongPwd)
			{
				%><span>原密码错误</span><%
			}
		%>
		</p>
		<p>输入新密码：<input type="password" name="newPwd" id="newPwd"></p>
		<p>确认新密码：<input type="password" name="confPwd" id="confPwd">
		<%
			if(wrongConf)
			{
				%><span>两次密码不一致</span><%
			}
		%>
		</p>
		<p><input type="submit" name="submit" id="submit" value="修改"></p>
		<p><a href="Profile.jsp?name=<%=name%>">返回</a></p>
	</form>
</body>
</html>