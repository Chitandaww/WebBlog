<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("utf-8");%>
<%
        
    String msg = "";
	String content = "";
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
        String query = "SELECT * FROM test_articles WHERE id=" + 11 + ";";
        ResultSet rs = stmt.executeQuery(query);
        rs.next();
        content = rs.getString("content");
        try{
       	 	content = java.net.URLDecoder.decode(content,"UTF-8");
      	}
       catch (UnsupportedEncodingException e) {
       	 	e.printStackTrace();
      	}
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
    <title>Write Blog</title>
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
    		width: 900px;
    		margin: auto;
    	}
    	#header_left {
    		float: left;
    	}
        #container {
            width: 900px;
            margin: 10px auto;
        }
        
    </style>
</head>
<!-- preview的css -->
<link rel="stylesheet" href="editor_md/css/style.css" />
 <link rel="stylesheet" href="editor_md/css/editormd.preview.css" />


<script src="editor_md/jquery.min.js"></script>
<script src="editor_md/lib/marked.min.js"></script>
<script src="editor_md/lib/prettify.min.js"></script>
<script src="editor_md/lib/raphael.min.js"></script>
<script src="editor_md/lib/underscore.min.js"></script>
<script src="editor_md/lib/sequence-diagram.min.js"></script>
<script src="editor_md/lib/flowchart.min.js"></script>
<script src="editor_md/lib/jquery.flowchart.min.js"></script>
<script src="editor_md/editormd.js"></script>

<body>
	<div id="header_outer">
	    <div id="header">
			<div id="header_left">
	    		<img src="Image/Blog_48px.png" alt="博客" title="博客" />
	    	</div>
	    </div>
	</div>
	<div id="container">
		<textarea style="display:none;"><%=content%></textarea>
	</div>
</body>

<script type="text/javascript">

		editormd.markdownToHTML("container", {
		  htmlDecode : "style,script,iframe", 
		  emoji : false,
		  tocm: true,
	      taskList: true, 
	      tex: true,                   // 开启科学公式TeX语言支持，默认关闭
	      flowChart: true,             // 开启流程图支持，默认关闭
	      sequenceDiagram: true       // 开启时序/序列图支持，默认关闭
  		});
</script>

