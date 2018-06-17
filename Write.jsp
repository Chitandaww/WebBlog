<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("utf-8");%>
<%
    if(request.getParameter("submit") != null) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String[] p = content.split("\r\n");
        String path = application.getRealPath("/articles");
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
                    new FileOutputStream(f), "UTF-8"));

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
            fw.close();
        }
        catch(IOException e){
            out.println(e.getMessage());
        }
        response.sendRedirect("/WebBlog/articles/" + time + ".html");
    }
%>

<!DOCTYPE  html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <title>Write Blog</title>
    <style type="text/css">
        #header {
            margin: 0;
            padding: 0;
            height: 50px;
            width: 100%;
            background: blanchedalmond;
        }
        #container {
            width: 600px;
            margin: 10px auto;
        }
        textarea {
            vertical-align: text-top;
        }
    </style>
</head>
<body>
    <div id="header">

    </div>
    <div id="container">
        <form name="write" action="Write.jsp" method="post">
            <p>
                标题：<input type="text" name="title" placeholder="请输入博客标题。">
            </p>
            <p>
                内容：<textarea rows="30" cols="70" name="content"></textarea>
            </p>
            <p>
                <input name="submit" type="submit" value="发表博客">
            </p>
        </form>
    </div>
</body>

</html>