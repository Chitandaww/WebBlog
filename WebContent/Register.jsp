<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>

<%
	String name = "";
	String pwd = "";
	//String pwd_conf = "";
	String existUser = "";
	boolean isExist = false;
	//Connect to database
	String connectString = "jdbc:mysql://172.18.187.233:53306/proj_user"
	        + "?autoReconnect=true&useUnicode=true"
	        + "&verifyServerCertificate=false&useSSL=false"
	        + "&characterEncoding=UTF-8";
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection(connectString,
	        "user", "123");
	//Get element
	if(request.getMethod().equalsIgnoreCase("post"))
	{
		name = request.getParameter("name");
		pwd = request.getParameter("pwd");
		//pwd_conf = request.getParameter("pwd_conf");
		Statement stmt = con.createStatement();
		String query = "SELECT * FROM login_info WHERE name='" + name + "';";
		ResultSet rs = stmt.executeQuery(query);
		if(rs.next())
		{
			isExist = true;
		}
		else
		{
			String ins = "INSERT INTO login_info(name, password)VALUES('" + name + "','" + pwd + "');";
			int temp = stmt.executeUpdate(ins);
			session.setAttribute("user", name);
			response.sendRedirect("RegistSuccess.html");
		}
		stmt.close();
		con.close();
	}
%>


<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
    <title>Register</title>
    <style>
    	*{font-family:宋体}
        body{
           background-image:url(Image/bg1.jpg);
        }
        .avtar{
           margin-top:2em;
           text-align:center;
        }
        fieldset {
            width:400px;
            margin:20px auto;
            padding:20px;
            background-color:rgb(43,43,54);
        }
        h1 {
            text-align: center;
            margin-top:100px;
        }
        form {
            font-size: 20px;
            text-align:center;
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
   
        input[type="button"]{
             font-size: 20px;
             color: #fff;
             outline: none;
             border: none;
             background: #3ea751;
             width: 100%;
             margin-bottom:20px;
             margin-top:20px;
             padding: 18px 0;
             border-bottom-left-radius: 15px;
             -webkit-border-bottom-left-radius: 15px;
             -moz-border-bottom-left-radius: 15px;
             -o-border-bottom-left-radius: 15px;
             border-bottom-right-radius: 15px;
             -webkit-border-bottom-right-radius: 15px;
             -moz-border-bottom-right-radius: 15px;
             -o-border-bottom-right-radius: 15px;
	         cursor: pointer;
       }
       .ps{
             padding-left:20px;
       }
       .dps{
             margin-top:20px;
             float:left;
       }
       
    </style>
</head>
<body>
	<h1>Blog</h1>
	<form action="Register.jsp" method="post" id="regisForm">
		<fieldset>
		    <div class="avtar">
		    <img src="Image/avtar.png" />
	        </div>   
			<p><span class="user">用户名：</span><input type="text" id="name" name="name" value=<%=name %>></p>
			<p><span class="ps">密码：</span><input type="password" id="pwd" name="pwd"></p>
			<p><span class="dps">确认密码：</span><input type="password" id="pwd_conf" name="pwd_conf"></p>
			<p><input type="button" id="regist" value="注册" onclick="CheckNSub()"></p>
		</fieldset>
	</form>
	<%if(isExist)
		{
			%><p id="existUser">用户名已存在！</p><%
		}%>
</body>
<script>
	function CheckNSub()
	{
		var pwd1 = document.getElementById("pwd");
		var pwd2 = document.getElementById("pwd_conf");
		var name = document.getElementById("name");
		if(name.value == "")
			alert("用户名不能为空！")
		else
		{
			if(pwd1.value != pwd2.value)
			{
				alert("两次密码输入不同！")	
			}
			else
			{
				document.getElementById("regisForm").submit();
			}
		}
	}
</script>

</html>
