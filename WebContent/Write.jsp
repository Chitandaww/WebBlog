<%@ page language="java" import="java.util.*,java.io.*,java.sql.*, java.net.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("utf-8");%>
<%
    if(request.getParameter("submit") != null) {
        
        String content = request.getParameter("test-editormd-markdown-doc");
        try{
        	 content = java.net.URLEncoder.encode(content,"UTF-8");
       	}
        catch (UnsupportedEncodingException e) {
        	 e.printStackTrace();
       	}
        //String[] p = content.split("\r\n");
        /*String path = application.getRealPath("/articles");
        //out.print(path);
        SimpleDateFormat df = new SimpleDateFormat("yyMMddHHmm");
        String time = df.format(new Date());
        String fileName = path + System.getProperty("file.separator") + time + ".html";
        File f = new File(fileName);
        if(!f.exists()){
            f.createNewFile();
        }
        try {
        	BufferedWriter fw = new BufferedWriter(new OutputStreamWriter(
        			new FileOutputStream(f)));
	        
	        fw.write("<!DOCTYPE html>\r\n");
	        fw.write("<html lang=\"zh-cn\">\r\n");
	        fw.write("<head>\r\n");
	        fw.write("    <meta charset=\"utf-8\">\r\n");
	        fw.write("<title>" + title + "</title>\r\n");
	        fw.write("</head>\r\n");
	        fw.write("<body>\r\n");
	        fw.write("<h1>" + title + "</h1>\r\n");
	        for (String i : p) {
	            fw.write("<p>" + i + "</p>\r\n");
	        }
	        fw.write("</body>\r\n");
	        fw.write("</html>\r\n");
	        fw.write(content);
	        fw.close();
        }
        catch(IOException e){
        	out.println(e.getMessage());
        }*/
        String msg = "";
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
            String query = "INSERT INTO test_articles(content)VALUES('" + content + "');";
            int rs = stmt.executeUpdate(query);
           
            stmt.close();
            con.close();
        }
        catch(Exception e)
        {
            msg = e.getMessage();
            out.print(msg);
        }
        //response.sendRedirect("/WebBlog/articles/" + time + ".html");
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
        textarea {
            vertical-align: text-top;
        }
        
    </style>
</head>
<!-- editormd start -->
    <link href="editor_md/css/editormd.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="editor_md/jquery.min.js"></script>
    <script type="text/javascript" src="editor_md/editormd.min.js"></script>
    <script type="text/javascript">
  var testEditor;

  testEditor=$(function() {
      editormd("test-editormd", {
           width   : "100%",
           height  : 900,
           //markdown : md,
           codeFold : true,
           syncScrolling : "single",
           //你的lib目录的路径
           path    : "editor_md/lib/",
           imageUpload: false,//关闭图片上传功能
          /*  theme: "dark",//工具栏主题
           previewTheme: "dark",//预览主题
           editorTheme: "pastel-on-dark",//编辑主题 */
           emoji: false,
           taskList: true, 
           tocm: true,         // Using [TOCM]
           tex: true,                   // 开启科学公式TeX语言支持，默认关闭
           flowChart: true,             // 开启流程图支持，默认关闭
           sequenceDiagram: true,       // 开启时序/序列图支持，默认关闭,
          //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
           saveHTMLToTextarea : true            
      });

  });
	
</script>
  <!-- editormd end -->  
  
<body>
	<div id="header_outer">
	    <div id="header">
			<div id="header_left">
	    		<img src="Image/Blog_48px.png" alt="博客" title="博客" />
	    	</div>
	    </div>
	</div>
    <div id="container">
        <form name="write" action="Write.jsp" method="post">
            <p>
               	 标题：<input type="text" name="title" placeholder="请输入博客标题。">
            </p>
            
            <!-- editormd start -->
		    <div class="editormd" id="test-editormd">
			    <textarea class="editormd-markdown-textarea" name="test-editormd-markdown-doc" id="editormd"></textarea>
			    <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
			    <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
			    <textarea class="editormd-html-textarea" name="editorhtml" id="editorhtml"></textarea>       
		    </div>
		    <!-- editormd end --> 
		              
            
            <p>
                <input name="submit" type="submit" value="发表博客">
            </p>
        </form>
    </div>
</body>

</html>