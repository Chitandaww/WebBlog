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

    //Register
    try
    {
        if(request.getParameter("register") != null)
        {
            Statement stmt = con.createStatement();
            String query = "INSERT INTO login_info(name, password)VALUES('" + name + "','" + password + "');";
            int rs = stmt.executeUpdate(query);
            if(rs != 0)
                out.print("注册成功！");
            stmt.close();
            con.close();
        }
    }
    catch(Exception e)
    {
        msg = e.getMessage();
        out.print("用户名已存在！");
    }
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
        fieldset {width:800px;margin:20px auto;padding:20px;background-color:#FCFCFF;}
        h1 {text-align: center;}
        form {font-size: 20px}
    </style>
</head>
<body>
<h1> Blog </h1>
<form action="Login.jsp" method="post">
    <fieldset>
        <legend>用户登录</legend>
        <p>
            <label for="username">用户名：</label>
            <input id="username" name="username" type="text">
            <span></span>
        </p>
        <p>
            <label for="password">密码：</label>
            <input id="password" name="password" type="password">
        </p>
        <p>
            <input id="login" name="login" type="submit" value="登陆">
            <input id="register" name="register" type="submit" value="注册">
        </p>
    </fieldset>
</form>
</body>

</html>
