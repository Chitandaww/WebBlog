<%@ page language="java" import="java.util.*,java.io.*,java.sql.*"
         contentType="text/html; charset=utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%
    String user = (String)session.getAttribute("user");
    if(user != null) {
    	session.removeAttribute("user");
    	session.invalidate();
        response.sendRedirect("index.jsp");
    }
    else{
    	response.sendRedirect("index.jsp");
    }
    
%>