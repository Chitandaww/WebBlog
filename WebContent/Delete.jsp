<%@ page language="java" import="java.util.*,java.io.*,java.sql.*, java.net.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%request.setCharacterEncoding("utf-8");%>
<%
	String user = (String)session.getAttribute("user");
	String msg = "";
	String filename = "";
	if(user == null) {
	    response.sendRedirect("Login.jsp");
	}
	if(request.getParameter("id") != null && request.getParameter("id") != ""){
		int id = Integer.parseInt(request.getParameter("id"));
		
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
	    	String query_f = "SELECT * FROM b_article WHERE id=" + id + ";";
	        ResultSet rs = stmt.executeQuery(query_f);
	        rs.next();
	        filename = rs.getString("filename");
	        
	        if(filename != null && filename != ""){
	        	String path =  application.getRealPath("/UploadFile");
	        	String url = path + System.getProperty("file.separator") + filename;
	        	File f = new File(url);
	        	if(f.exists()){
	        		f.delete();
	        	}
	        }
	        
	        String query = "DELETE FROM b_article WHERE id=" + id + ";";
	        int rs1 = stmt.executeUpdate(query);

	        /*try{
	       	 	content = java.net.URLDecoder.decode(content,"UTF-8");
	      	}
	       	catch (UnsupportedEncodingException e) {
	       	 	e.printStackTrace();
	      	}*/
	        stmt.close();
	        con.close();
	        response.sendRedirect("MyBlog.jsp");
	    }
	    catch(Exception e)
	    {
	        msg = e.getMessage();
	        out.print(msg);
	    }
	}
	else{
		response.sendRedirect("index.jsp");
	}
%>