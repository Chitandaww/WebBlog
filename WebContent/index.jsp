<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>

<!DOCTYPE  html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="Image/Blog_64px.png" />
    <title>Blog</title>
    <style type="text/css">
    	body {
    		margin: 0;
    		padding: 0;
    	}
    	#header_outer {
    		margin: 0;
    		padding: 0;
    		width: 100%;
    		height: 50px;
    		background: #33669933;
    	}
    	#header {
    		width: 700px;
    		margin: auto;
    	}
    	#header_left {
    		float: left;
    	}
        #header_right {
            float: right;
            height: 50px;
            padding: 13px;
        }
        a {
        	text-decoration: none;
        }
    </style>
</head>
<body>
	<div id="header_outer">
	    <div id="header">
	    	<div id="header_left">
	    		<img src="Image/Blog_48px.png" alt="博客" title="博客" />
	    	</div>
	    	<div id="header_right">
		        <% String user = (String)session.getAttribute("user"); %>
		        <% if(user == null) { %>
		            <a href="Login.jsp">登录 </a>
		            <a href="Login.jsp">注册&nbsp; &nbsp;</a>
		        <% } else { %>
		            <a href="index.jsp"><%=user%></a>
		        <% } %>
			</div>
	    </div>
    </div>
</body>

</html>
