<%@ page language="java" import="java.util.*,java.io.*,java.sql.*, java.net.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("utf-8");%>
<%
	String user = (String)session.getAttribute("user");
	String msg1 = "";
	String edit_content = "";
	String edit_title = "";
	String edit_time = "";
	String edit_author = "";
	if(user == null) {
	    response.sendRedirect("Login.jsp");
	}
	if(request.getParameter("id") != null && request.getParameter("id") != ""){
		int id = Integer.parseInt(request.getParameter("id"));
		edit_content = "";
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
	        edit_content = rs.getString("content");
	        edit_title = rs.getString("title");
	        edit_time = rs.getString("time");
	        edit_author = rs.getString("author");
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
	        msg1 = e.getMessage();
	        out.print(msg1);
	    }
	}
    if(request.getParameter("submit") != null) {
    	
    	String title = request.getParameter("title");
    	
        String content = request.getParameter("content");
        
        /*try{
        	 content = java.net.URLEncoder.encode(content,"UTF-8");
       	}
        catch (UnsupportedEncodingException e) {
        	 e.printStackTrace();
       	}*/
        
        String msg2 = "";
        String id = "";
        //Connect to database
        String connectString = "jdbc:mysql://172.18.187.233:53306/proj_user"
                + "?autoReconnect=true&useUnicode=true"
                + "&verifyServerCertificate=false&useSSL=false"
                + "&characterEncoding=UTF-8";

        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection(connectString,
                "user", "123");
        
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date());
        
        try
        {
            Statement stmt = con.createStatement();
            String query_i = "INSERT INTO b_article(title,author,time,content)VALUES('" 
            	+ title + "','" + user + "','" + time + "','" + content + "');";
            int rs1 = stmt.executeUpdate(query_i);
           	
            String query_q = "SELECT * FROM b_article WHERE time='" + time
            		+ "' AND author='" + user + "';";
            ResultSet rs2 = stmt.executeQuery(query_q);
            rs2.next();
            id = rs2.getString("id");
            stmt.close();
            con.close();
        }
        catch(Exception e)
        {
            msg2 = e.getMessage();
            out.print(msg2);
        }
        response.sendRedirect("Show.jsp?id="+id);
    }
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
    		background: #d6e0eb;
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
    	#title {
    		width: 700px;
    		height: 30px;
    		margin: 10px auto;
    	}
        #container {
            width: 900px;
            margin: 10px auto;
        }
        #myeditor {
        	width: 900px;
        	margin: 20px auto;
        }
        #toolbar {
        	width: 900px;
        	height: 30px;
        	margin: 10px auto;
        }
        #toolbar>input {
        	width: 24px;
        	height: 24px;
        	margin: 5px;
        }
        #imgfile {
        	display: none;
        }
        #fcolor {
        	width: 50px;
        	height: 30px;
        	background: #000;
        	color: #FFF;
        	vertical-align: top;
        	margin: 5px;
        }
        #sp {
        	width: 5px;
        	height: 30px;
        }
        #richedit {
        	width: 900px;
        	height: 700px;
        	border: solid 2px gray;
        	margin: 10px auto;
        	overflow: auto;
        }
        textarea, #title_cp {
        	display: none;
        }
        #btn {
        	width: 170px;
        	margin: 0 auto;
        }
        #submit {
        	font-size: 20px;
             color: #87CEFA;
             outline: none;
             border: 2px solid #87CEFA;
             background: #fff;
             width: 170px;
             margin-bottom:10px;
             padding: 18px 0;
             border-radius: 15px;
	         cursor: pointer;
        }
        #submit:hover {
        	color: #fff;
        	background: #87CEFA;
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
            z-index:0;
        }
		.subnav {
			width:130px;
			position: absolute;
			top: 30px;
			padding: 10px 0;
			background: #d6e0eb;
			display: none;
			
		}
		.subnav>li {
			line-height: 30px;
		}
		.subnav span{
            display: none;
        }
        a {
        	text-decoration: none;
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
	                    <li><a href="MyBlog.jsp">我的博客</a></li>
	                    <li><span>|</span></li>
	                    <li><a href="Exit.jsp">退出</a></li>
                	</ul>
                </li>
	    	</div>
	    </div>
	</div>
    <div id="container">
        <div>
           <input type="text" id="title" name="title" placeholder="请输入博客标题。" value="<%=edit_title%>">
        </div>
        <div class="editor" id="myeditor">
           	<div class="editor" id="toolbar">
           		<input name="undo" type="image" src="Image/undo_24px.png" title="撤销" onclick="undo()"/>
           		<input name="redo" type="image" src="Image/redo_24px.png" title="恢复" onclick="redo()"/>
           		<img id="sp" src="Image/sp.ico" />
           		<input name="bold" type="image" src="Image/bold_24px.png" title="加粗" onclick="bold()"/>
           		<input name="ul" type="image" src="Image/underline_24px.png" title="下划线" onclick="ul()"/>
           		<input name="italic" type="image" src="Image/Italic_24px.png" title="斜体" onclick="italic()"/>
           		<img id="sp" src="Image/sp.ico" />
           		<img id="color" src="">
           		<select name="fontcolor" id="fcolor" title="字体颜色" onchange="fcolor()">
           			<option value="black" >黑色</option>
           			<option value="red" >红色</option>
           			<option value="green" >绿色</option>
           			<option value="blue" >蓝色</option>
           			<option value="yellow" >黄色</option>
           		</select>
           		<img id="sp" src="Image/sp.ico" />
           		<input name="H1" type="image" src="Image/H1_24px.png" title="H1" onclick="H1()"/>
           		<input name="H2" type="image" src="Image/H2_24px.png" title="H2" onclick="H2()"/>
           		<input name="H3" type="image" src="Image/H3_24px.png" title="H3" onclick="H3()"/>
           		<input name="pgh" type="image" src="Image/paragraph_24px.png" title="段落" onclick="pgh()"/>
           		<img id="sp" src="Image/sp.ico" />
           		<input name="ulist" type="image" src="Image/ulist_24px.png" title="无序列表" onclick="ulist()"/>
           		<input name="olist" type="image" src="Image/olist_24px.png" title="有序列表" onclick="olist()"/>
           		<img id="sp" src="Image/sp.ico" />
           		<input name="addlink" type="image" src="Image/link_24px.png" title="添加链接" onclick="addlink()"/>
           		<input name="addimg" type="image" src="Image/img_24px.png" title="添加图片" onclick="addimg()"/>
           	</div>
           	<input name="imgfile" id="imgfile" type="file">
            <div class="editor" id="richedit" contenteditable="true">
            	<%=edit_content%>
            </div><br>
	    </div>
		<form name="write" action="Write.jsp" method="post">
            <div>
            	<input name="title" id="title_cp" type="text">
            	<textarea name="content" id="content"></textarea>
                <p id="btn">
                	<input name="submit" id="submit" type="submit" value="发布博客" alt="发布博客" >
                </p>
            </div>
        </form>
    </div>
</body>

<script>
	var submitBtn = document.getElementById("submit");
	var title = document.getElementById("title");
	submitBtn.onclick = function(event){
		  if(title.value == ""){
			  alert("请输入博客标题!");
			  //var o = document.getElementById("richedit");
			  //alert(o.innerHTML);
			  return false;
		  }
		  else{
			  document.getElementById("title_cp").value = document.getElementById("title").value
			  var o = document.getElementById("richedit").innerHTML;
			  document.getElementById("content").innerHTML = o;
		  }
	}
	
	function undo() {
		document.execCommand("undo");
	}
	function redo() {
		document.execCommand("redo");
	}
	function bold() {
		document.execCommand("bold");
	}
	function ul() {
		document.execCommand("underline");
	}
	function italic() {
		document.execCommand("italic");
	}
	function fcolor() {
		var selector = document.getElementById("fcolor");
		//alert(selector.value);
		switch(selector.value){
			case "black":
				document.execCommand("forecolor", false, "#000");
				selector.style.background = "#000";
				selector.style.color = "#FFF";
				break;
			case "red":
				document.execCommand("forecolor", false, "#F00");
				selector.style.background = "#F00";
				selector.style.color = "#000";
				break;
			case "green":
				document.execCommand("forecolor", false, "#0F0");
				selector.style.background = "#0F0";
				selector.style.color = "#000";
				break;
			case "blue":
				document.execCommand("forecolor", false, "#00F");
				selector.style.background = "#00F";
				selector.style.color = "#FFF";
				break;
			case "yellow":
				document.execCommand("forecolor", false, "#FF0");
				selector.style.background = "#FF0";
				selector.style.color = "#000";
				break;
		}
	}
	function H1(){
		document.execCommand("formatblock", false, "<h1>");
	}
	function H2(){
		document.execCommand("formatblock", false, "<h2>");
	}
	function H3(){
		document.execCommand("formatblock", false, "<h3>");
	}
	function pgh(){
		document.execCommand("insertparagraph");
	}
	function ulist(){
		document.execCommand("insertunorderedlist");
	}
	function olist(){
		document.execCommand("insertorderedlist");
	}
	function addlink(){
		var l = prompt("请输入指向的网址链接。", "");
		if(l != null && l != ""){
			if(l.startsWith("http://") == false){
				l = "http://" + l;
			}
			document.execCommand("createlink", false, l);
		}
	}
	var imgname;
	function addimg(){
		var imgfile = document.getElementById("imgfile");
		imgfile.click();
		/*var l = prompt("请输入图片链接。", "");
		if(l != null && l != ""){
			document.execCommand("insertimage", false, l);
		}*/
	}
	document.getElementById("imgfile").addEventListener("change",function(){
		var file = document.getElementById("imgfile").files[0];
		imgname = "UploadFile/" + file.name;
		var formdata = new FormData();
		formdata.append("file",file);
		var xhr = new XMLHttpRequest();
		xhr.open("post", "SaveImg", true);
		xhr.setRequestHeader("Content-Type","multipart/form-data");
		xhr.onreadystatechange = function () {
            if (xhr.readyState==4 && xhr.status==200){
            	document.execCommand("insertimage", false, imgname);
            }
        }
		xhr.send(formdata);
		
		
		//document.getElementById("up").click();
	});
</script>

</html>