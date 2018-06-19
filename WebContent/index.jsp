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
            height: 50px;
            padding: 13px;
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
             margin: 20px 0 0 0 
        }
        .text{
              border:1px solid rgb(244,244,244);
              width: 650px;
    		  margin: auto;
    		  margin-bottom:10px; 
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
	     <div id = "header_image">
        
    </div>
	    
    </div>
   
   <div id ="article">
       <h2 class="title_tj">
           <p>文章<span>推荐</span></p>
        </h2>
        <div class="bloglist left">
           <div class="text one">
               <h3>程序员请放下你的技术情节，与你的同伴一起进步</h3>
               <ul>
                  <p>如果说掌握一门赖以生计的技术是技术人员要学会的第一课的话， 那么我觉得技术人员要真正学会的第二课，不是技术，而是业务、交流与协作，学会关心其他工作伙伴的工作情况和进展...</p>
                  <a title="/" href="/" target="_blank" class="readmore">阅读全文>></a>
               </ul>
               <p class="dateview"><span>2013-11-04</span><span>作者：杨青</span><span>个人博客：[<a href="/news/life/">程序人生</a>]</span></p>
            </div>
            <div class="text two">
                <h3>程序员请放下你的技术情节，与你的同伴一起进步</h3>
                <ul>
                   <p>如果说掌握一门赖以生计的技术是技术人员要学会的第一课的话， 那么我觉得技术人员要真正学会的第二课，不是技术，而是业务、交流与协作，学会关心其他工作伙伴的工作情况和进展...</p>
                   <a title="/" href="/" target="_blank" class="readmore">阅读全文>></a>
                </ul>
                <p class="dateview"><span>2013-11-04</span><span>作者：杨青</span><span>个人博客：[<a href="/news/life/">程序人生</a>]</span></p>
            </div>
            <div class="text three">
                <h3>程序员请放下你的技术情节，与你的同伴一起进步</h3>
                <ul>
                    <p>如果说掌握一门赖以生计的技术是技术人员要学会的第一课的话， 那么我觉得技术人员要真正学会的第二课，不是技术，而是业务、交流与协作，学会关心其他工作伙伴的工作情况和进展...</p>
                    <a title="/" href="/" target="_blank" class="readmore">阅读全文>></a>
                </ul>
                <p class="dateview"><span>2013-11-04</span><span>作者：杨青</span><span>个人博客：[<a href="/news/life/">程序人生</a>]</span></p>
            </div>
            <div class="text four">
                <h3>程序员请放下你的技术情节，与你的同伴一起进步</h3>
                <ul>
                    <p>如果说掌握一门赖以生计的技术是技术人员要学会的第一课的话， 那么我觉得技术人员要真正学会的第二课，不是技术，而是业务、交流与协作，学会关心其他工作伙伴的工作情况和进展...</p>
                    <a title="/" href="/" target="_blank" class="readmore">阅读全文>></a>
                </ul>
                <p class="dateview"><span>2013-11-04</span><span>作者：杨青</span><span>个人博客：[<a href="/news/life/">程序人生</a>]</span></p>
            </div>
            <div class="text five">
                <h3>程序员请放下你的技术情节，与你的同伴一起进步</h3>
                <ul>
                    <p>如果说掌握一门赖以生计的技术是技术人员要学会的第一课的话， 那么我觉得技术人员要真正学会的第二课，不是技术，而是业务、交流与协作，学会关心其他工作伙伴的工作情况和进展...</p>
                    <a title="/" href="/" target="_blank" class="readmore">阅读全文>></a>
                </ul>
                <p class="dateview"><span>2013-11-04</span><span>作者：杨青</span><span>个人博客：[<a href="/news/life/">程序人生</a>]</span></p>
            </div>
  </div>
 </div>   
</body>

</html>
