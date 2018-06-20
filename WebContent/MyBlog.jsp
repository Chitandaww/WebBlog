<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%
    String user = (String)session.getAttribute("user");  
	if(user == null) {
	    response.sendRedirect("Login.jsp");
	}
    String msg = "";
	String[] id = new String[5];
	String[] time = new String[5];
	String[] author = new String[5];
	String[] title = new String[5];
	String[] content = new String[5];
	int num = 0;
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
        String fmt = "SELECT * FROM b_article where author = '%s' ORDER BY time ASC;";
        String sql = String.format(fmt, user);
        ResultSet rs = stmt.executeQuery(sql);
        while(rs.next() && num < 5){
        	id[num] = rs.getString("id");
        	time[num] = rs.getString("time");
        	author[num] = rs.getString("author");
        	title[num] = rs.getString("title");
        	content[num] = rs.getString("content");
        	content[num] = content[num].replaceAll("</?[^>]+>", "");
        	num = num + 1;
        }
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
    //response.sendRedirect("/WebBlog/articles/" + time + ".html");
    
%>




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
    		width: 700px;
    		margin: auto;
    	}
    	#header_left {
    		float: left;
    	}
        #header_right {
            float: right;
            width: 130px;
            
        }
       
        a {
        	text-decoration: none;
        }
        #header_image{
            background-image: url("Image/banner_top.jpg");
            width:100%;
            height:200px;
            z-index:-1;
            
        }
        #article {
            width: 700px;
    		margin: auto;
        }
        h2.title_tj { 
            font: 18px "微软雅黑", Arial, Helvetica, sans-serif;
            color: #444; 
            font-weight: bold; 
            background: url(Image/h_line.jpg) repeat-x 20px center; }
        h2.title_tj span { 
            color: #FE5187 
        }
        h2.title_tj p { 
            background: #fff; 
            width: 90px 
        }
        .bloglist { 
            width: 740px; 
            overflow: hidden; 
            background: url(Images/r_line.jpg) repeat-y right; 
        }
        .bloglist h3 { 
            margin: 20px 0 10px 0; 
            color: #333 
        }
        .bloglist ul { 
             float: left; 
             width: 520px; 
             margin: 10px 0px 0 15px; 
             line-height: 20px; 
        }
        .dateview { 
             width: 650px; 
             overflow: hidden; 
             clear: both; 
             margin: 10px 0 0 0;
             display: inline-block; 
             background: #f6f6f6;       
             line-height: 26px; 
             height: 26px;             
        }
        .dateview span { 
             margin: 0 10px; 
        }
        .dateview span a { 
             color: #099B43; 
        }
        a.readmore { 
             background: #fd8a61; 
             color: #fff;
             padding: 5px 10px; 
             float: right; 
             margin: 20px 0 0 0 ;
             margin-left:20px;
        }
        a.delete{
             background: #fd8a61; 
             color: #fff;
             padding: 5px 10px; 
             float: right; 
             margin: 20px 0 0 0;
             margin-left:10px;
        }
        a.write{
             background: #fd8a61; 
             color: #fff;
             padding: 5px 10px; 
             float: right; 
             margin: 20px 0 0 0;
             margin-left:10px;
        }
        .text{
              border:1px solid rgb(244,244,244);
              width: 650px;
    		  margin: auto;
    		  margin-bottom:10px; 
        }
        #content {
        	max-height: 70px;
        	overflow: hidden;
        	white-space:nowrap;
        	text-overflow:ellipsis;
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
	    		<a href="index.jsp"><img src="Image/Blog_48px.png" alt="博客" title="博客" /></a>
	    	</div>
	    	<div id="header_right">
		        
		            <li>
		            	<div id="avtar"><img src="Image/avtar.png" /></div>
		            	<ul class="subnav">
		            		<li><%=user%></li>
		            		<li><HR></li>
		                    <li><a href="Write.jsp">写博客</a></li>
		                    <li><span>|</span></li>
		                 
		                    <li><span>|</span></li>
		                    <li><a href="Exit.jsp" >退出</a></li>
	                	</ul>
	                </li>
					
			</div>
	    </div>
	    <div id = "header_image">
	
    	</div>
	    
    </div>
   
   <div id ="article">
       	<h2 class="title_tj">
           <p>文章<span>推荐</span></p>
        </h2>
        <div class="bloglist left">
           
        	<%
        		for(int i = 0; i < num; i++){
        			out.write("<div class='text'>");
        			out.write("<h3>" + title[i] + "</h3>");
        			
        			out.write("<ul><div id='content'>" + content[i] + "</div>" 
        				+"<a href='Delete.jsp?id=" + id[i] + "' class='delete'>删除</a>"+"<a href='Write.jsp?id="+ id[i] + "' class='write'>编辑</a>"+"<a title='阅读全文' href='Show.jsp?id=" + id[i] 
        				+ "' target='_blank' class='readmore'>阅读全文>></a></ul>");
        			
        			out.write("<p class='dateview'><span>" + time[i]
        					+ "</span><span>作者：" + author[i] + "</span></p>");
        			
        		}
        	%>
  		</div>
 	</div>   
</body>

</html>
