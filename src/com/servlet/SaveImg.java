package com.servlet;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/SaveImg")
public class SaveImg extends HttpServlet {
    private static final long serialVersionUID = 1L;
                                                                                                        
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveImg() {
        super();
        // TODO Auto-generated constructor stub
    }
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doPost(request,response);
    }
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
         response.setContentType("text/xml");//是xml
            response.setHeader("Cache-Control", "no-cache");
            response.setCharacterEncoding("UTF-8");
            ServletContext sc = request.getSession().getServletContext();
            String filepath = sc.getRealPath("/UploadFile/");//文件上传的路径，实际开发中一般用相对路径
            String filename = "";
            String name="";
            ServletInputStream in = request.getInputStream();
            byte[] buf = new byte[4048];
            int len = in.readLine(buf, 0, buf.length);
            String f = new String(buf, 0, len - 1);
            while ((len = in.readLine(buf, 0, buf.length)) != -1) {
                filename = new String(buf, 0, len,"utf-8");//解决汉字乱码问题
                int j = filename.lastIndexOf("\"");
                int s = filename.indexOf("filename");
                name=filename.substring(s+10,j);
                filename = name;//通过上述处理可以得到上传的文件名
                System.out.println("filename="+filename);
                                                                                                                    
                DataOutputStream fileStream = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(filepath+ filename)));
                len = in.readLine(buf, 0, buf.length);
                len = in.readLine(buf, 0, buf.length);
                while ((len = in.readLine(buf, 0, buf.length)) != -1) {
                    String tempf = new String(buf, 0, len - 1);
                    if (tempf.equals(f) || tempf.equals(f + "--")) {
                        break;
                    }
                    else{
                         fileStream.write(buf, 0, len); // 写入
                    }
                }
                fileStream.close();
            }
            PrintWriter out=response.getWriter();
            String result = filename ;
            //out.print(result);
            out.close();
            in.close();                                             
    }
}  