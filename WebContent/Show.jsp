<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("utf-8");%>
<%
        
    String msg = "";
	String content = "";
	String title = "";
	String time = "";
	String author = "";
	if(request.getParameter("id") == null || request.getParameter("id") == ""){
		response.sendRedirect("index.jsp");
	}
	else{
		int id = Integer.parseInt(request.getParameter("id"));
		content = "";
	    //Connect to database
	    String connectString = "jdbc:mysql://172.18.187.233:53306/proj_user"
	            + "?autoReconnect=true&useUnicode=true"
	            + "&verifyServerCertificate=false&useSSL=false"
	            + "&characterEncoding=UTF-8";
	
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con=DriverManager.getConnection(connectString,
	            "user", "123");
	    
	    
	    try
	    {
	    	Statement stmt = con.createStatement();
	        String query = "SELECT * FROM b_article WHERE id=" + id + ";";
	        ResultSet rs = stmt.executeQuery(query);
	        rs.next();
	        content = rs.getString("content");
	        title = rs.getString("title");
	        time = rs.getString("time");
	        author = rs.getString("author");
	        /*try{
	       	 	content = java.net.URLDecoder.decode(content,"UTF-8");
	      	}
	       	catch (UnsupportedEncodingException e) {
	       	 	e.printStackTrace();
	      	}*/
	        stmt.close();
	        con.close();
	    }
	    catch(Exception e)
	    {
	        msg = e.getMessage();
	        out.print(msg);
	    }
	}
    //response.sendRedirect("/WebBlog/articles/" + time + ".html");
    
%>

<!DOCTYPE  html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="Image/Blog_64px.png" />
    <title><%=title%></title>
    <style type="text/css">
        body {
    		margin: 0;
    		padding: 0;
    	    background-image: url("Image/head_image.jpg");
    	    z-index:0;
    		
    	}
    	#header_outer {
    		margin: 0;
    		padding: 0;
    		width: 100%;
    		height: 200px;
    		background: #33669933;
    	}
    	#header {
    		width: 900px;
    		margin: auto;
    	}
    	#header_left {
    		float: left;
    	}
        #header_right {
            float: right;
            width: 130px;
            
        }
       	#login {
       		margin-top: 15px;
       	}
        a {
        	text-decoration: none;
        }
        #header_image{
            background-image: url("Image/banner_top.jpg");
            width:100%;
            height:200px;
            z-index:-1;
            text-align: center;
            font-size: 40px;
        }
        #title2 {
        	text-align: center;
            font: 35px "微软雅黑", Arial, Helvetica, sans-serif;
        }
        #detail {
        	text-align: center;
            font: 15px "微软雅黑", Arial, Helvetica, sans-serif;
        }
        #article {
            width: 900px;
    		margin: 10px auto;
    		background: #fff5;
    		padding: 30px;
    		border-radius: 40px;
        }
 
        li {
			list-style-type:none;
			margin: 0px;
			padding: 0px;
		}
		
		#header_right>li {
			width:130px;
			text-align: center;
			position: relative;
			
		}
		#header_right>li:hover .subnav{
            display: block;
        }
		.subnav {
			width:130px;
			position: absolute;
			top: 20px;
			padding: 10px 0;
			display: none;
		}
		.subnav>li {
			line-height: 30px;
		}
		.subnav span{
            display: none;
        }
        #avtar, #avtar>img {
        	width: 48px;
        	height: 48px;
        	border-radius: 24px;
        	margin: auto;
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
		        	<div id="login">
			            <a href="Login.jsp">登录 </a>
			            <a href="Register.jsp">注册&nbsp; &nbsp;</a>
		            </div>
		        <% } else { %>
		            <li>
		            	<div id="avtar"><img src="Image/avtar.png" /></div>
		            	<ul class="subnav">
		            		<li><%=user%></li>
		            		<li><HR></li>
		                    <li><a href="Write.jsp">写博客</a></li>
		                    <li><span>|</span></li>
		                    <li><a href="#">我的博客</a></li>
		                    <li><span>|</span></li>
		                    <li><a href="Exit.jsp">退出</a></li>
	                	</ul>
	                </li>
		        <% } %>
					
			</div>
	    </div>
	    <div id = "header_image">
			<br><span id="title2"><%=title%></span><br>
			<span id="detail"><%=time%>&nbsp; &nbsp; &nbsp; &nbsp;<%=author%></span>
    	</div>
	    
    </div>
	<div id ="article">
       	<%=content%>
 	</div> 
</body>


