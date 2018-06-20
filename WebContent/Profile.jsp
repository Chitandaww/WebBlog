<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>

<%
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
	//Get id
	Statement stmt = con.createStatement();
	String id = "";
	String getID = "SELECT id FROM login_info WHERE name='" + name + "';";
	ResultSet idrs = stmt.executeQuery(getID);
	if(idrs.next())
	{
		id = idrs.getString("id");
	}
	//Change username
	boolean isExist = false;
	if(request.getMethod().equalsIgnoreCase("post"))
	{
		name = request.getParameter("username");
		String query = "SELECT * FROM login_info WHERE name='" + name + "';";
		ResultSet rs = stmt.executeQuery(query);
		if(rs.next())	//exist name
		{
			isExist = true;
		}
		else
		{
			String upd = "UPDATE login_info SET name='" + name + "' WHERE id='" + id + "';";
			int ins = stmt.executeUpdate(upd);
			session.setAttribute("user", name);
			response.sendRedirect("index.jsp");
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Profile</title>
	<style>
	   *{font-family:宋体}
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
        input[type="text"] {
	        padding: 1em 2em 1em 3em;
	        color: #9199aa;
	        font-size: 18px;
	        outline: none;
	        background:no-repeat 10px 15px;
	        border: none;
	        font-weight: 100;
	        border-bottom: 1px solid #484856;
        }
        span{
            font-size:18px;
            color:white;
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
	<h1>个人资料</h1>
	<form method="post">
		<p><span>用户名：</span><input type="text" name="username" id="username" value=<%=name %>>
			<%
				if(isExist)
				{
					%><span>用户名已存在</span><%
				}
			%>
		</p>
		<p><input type="submit" name="submit" id="submit" value="保存"></p>
		<p><a href="ChangePwd.jsp?name=<%=name%>">修改密码</a>&nbsp;&nbsp;<a href="index.jsp">返回</a></p>
	</form>
</body>
</html>