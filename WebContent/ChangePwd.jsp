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
	<style>
	 body{
           background-image:url(Image/bg1.jpg);
        }
        h1{
           text-align:center;
        }
         form {
            width:400px;
            margin:20px auto;
            padding:20px;
            text-align:center;
            background-color:rgb(43,43,54);
        }
         span{
            font-size:18px;
            color:white;
        }
         input[type="password"]{
	         padding: 1em 2em 1em 3em;
	         color: #dd3e3e;
	         font-size: 18px;
	         outline: none;
	         background:no-repeat 10px 23px;
	         border: none;
	         font-weight: 100;
	         border-bottom: 1px solid #484856;
	      
       }
       input[type="submit"]{
             font-size: 20px;
             color: #fff;
             outline: none;
             border: none;
             background: #3ea751;
             width: 60px;
             margin-bottom:20px;
             margin-top:20px;
	         cursor: pointer;
	         
       }
        a{
             color:white;
            
       }
	</style>
</head>
<body>
	<h1>修改密码</h1>
	<form method="post" id="pwdForm">
		<p><span>输入原密码：</span><input type="password" name="oriPwd" id="oriPwd">
		<%
			if(wrongPwd)
			{
				%><span>原密码错误</span><%
			}
		%>
		</p>
		<p><span>输入新密码：</span><input type="password" name="newPwd" id="newPwd"></p>
		<p><span>确认新密码：</span><input type="password" name="confPwd" id="confPwd">
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