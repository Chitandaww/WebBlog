<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%
    String user = (String)session.getAttribute("user");
    if(user != null) {
        response.sendRedirect("index.jsp");
    }
    String msg = "";
    //Connect to database
    String connectString = "jdbc:mysql://172.18.187.233:53306/proj_user"
            + "?autoReconnect=true&useUnicode=true"
            + "&verifyServerCertificate=false&useSSL=false"
            + "&characterEncoding=UTF-8";

    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString,
            "user", "123");
    //Get name and password
    String name = request.getParameter("username");
    String password = request.getParameter("password");
    //Login
    try
    {
        if(request.getParameter("login") != null)
        {
            Statement stmt = con.createStatement();
            String query = "SELECT* FROM login_info WHERE name='" + name + "' AND password='" + password + "';";
            ResultSet rs = stmt.executeQuery(query);
            if(!rs.next())
                out.print("用户名或密码错误！");
            else {
                out.print("登陆成功！");
                session.setAttribute("user", name);
                response.sendRedirect("index.jsp");
            }
            stmt.close();
            con.close();
        }
    }
    catch(Exception e)
    {
        msg = e.getMessage();
    }
%>
<!DOCTYPE  html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>Login</title>
    <style type="text/css">
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
	        background: url(Image/adm.png) no-repeat 10px 15px;
	        border: none;
	        font-weight: 100;
	        border-bottom: 1px solid #484856;
        }
        input[type="password"]{
	         padding: 1em 2em 1em 3em;
	         color: #dd3e3e;
	         font-size: 18px;
	         outline: none;
	         background: url(Image/key.png) no-repeat 10px 23px;
	         border: none;
	         font-weight: 100;
	         border-bottom: 1px solid #484856;
	         margin-bottom: 3em;
       }
        input[type="submit"]{
             font-size: 20px;
             color: #fff;
             outline: none;
             border: none;
             background: #3ea751;
             width: 100%;
             margin-bottom:20px;
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
      
    </style>
</head>
<body>
<h1> Blog </h1>
	
    <form action="Login.jsp" method="post">
    
    <fieldset>
    <div class="avtar">
		<img src="Image/avtar.png" />
	</div>   
        <p>
            <label for="username"></label>
            <input id="username" name="username" type="text">
            <span></span>
        </p>
        <p>
            <label for="password"></label>
            <input id="password" name="password" type="password">
        </p>
        <p>
            <input id="login" name="login" type="submit" value="登陆">
            <a href="Register.jsp">注册</a>
        </p>
    </fieldset>
</form>
</div>
</body>

</html>
