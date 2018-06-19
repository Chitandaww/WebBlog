<%@ page language="java" import="java.util.*,java.io.*,java.sql.*, java.net.*"
         contentType="text/html; charset=utf-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="java.util.Date" %>
<html>
	<head>
	</head>
	<body>
		<p><%request.setCharacterEncoding("utf-8");%>
		<%
			out.print("upload");
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			String fName = "";
			String fileName = "";
			if(isMultipart) {
				out.print("upload");
				FileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				List items = upload.parseRequest(request);
				//String id = "";
				for(int i = 0; i < items.size(); i ++){
					FileItem fi = (FileItem)items.get(i);
					if(fi.isFormField()) {
		    		/*if(fi.getFieldName().equals("id")) {
		        		id = fi.getString("utf-8");
		    		}*/
					}
					else {
			    		DiskFileItem dfi = (DiskFileItem)fi;
			    		if(!dfi.getName().trim().equals("")) {
			        		//out.print("文件被上传到服务上的实际位置： ");
			        		out.print(application.getRealPath("/UploadFile"));
			        		fName = FilenameUtils.getName(dfi.getName());
			        		fileName = application.getRealPath("/UploadFile") + System.getProperty("file.separator") + fName;
			        		
			        		dfi.write(new File(fileName));
			    		}
					}
				}
			}
		%></p>
	</body>
</html>