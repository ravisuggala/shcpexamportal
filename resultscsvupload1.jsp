<%@page import="org.apache.commons.fileupload.*,java.util.*,java.io.*"%>

<%
   // JSP to handle  uploading
   
   
   // Create a new file upload handler 
   DiskFileUpload upload = new DiskFileUpload();
   
   // parse request
   List items = upload.parseRequest(request);
   
   // get uploaded file 
   FileItem  file = (FileItem) items.get(0);
   
   
   String source = file.getName();
   String fileName = new File(source).getName();
   
   // get taget filename
   //FileItem  name = (FileItem) items.get(1);
   //String  target = name.getString();
     
    out.println(fileName);
    ServletContext servletContext = request.getSession().getServletContext();
    String relativeWebPath = "excelfiles/"+fileName;
    String absoluteDiskPath = servletContext.getRealPath(relativeWebPath);
   File outfile = new File(absoluteDiskPath);
   file.write(outfile);
   
   session.setAttribute("option","cgpacompare");
   session.setAttribute("filename",fileName);
   session.setAttribute("absfile",absoluteDiskPath);
   response.sendRedirect("./ActionServlet");
   
%>
