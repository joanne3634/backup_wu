<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.deelon.platform.service.util.ServiceUtil" %>
<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page import="com.deelon.crowdfunding.common.util.TUserUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.deelon.core.util.UniqueIdUtil"%>

<%
	TUser user = TUserUtil.getLogUser(request);
	DiskFileItemFactory factory = new DiskFileItemFactory();
	String attachPath = ServiceUtil.getBasePath().replace("/", "\\")  + File.separator + user.getLoginName() + File.separator;
	
	File one = new File(attachPath);
	Calendar cal = Calendar.getInstance();
	Integer year = Integer.valueOf(cal.get(1));
	Integer month = Integer.valueOf(cal.get(2) + 1);
	one = new File(attachPath + "/" + year + "/" + month);
	if (!one.exists()) {
	   one.mkdirs();
	 }
	
	factory.setRepository(new File(attachPath));
	factory.setSizeThreshold(1024 * 1024);
	ServletFileUpload upload = new ServletFileUpload(factory);
	List<FileItem> fileItems = upload.parseRequest(request);
	String newfilename = "";
	Long fileId = UniqueIdUtil.genId(); 
	for(FileItem item : fileItems) {
		if(!item.isFormField()) {
			if("photo".equals(item.getFieldName())) {
				String suffix = item.getName().substring(item.getName().lastIndexOf("."));
				newfilename = fileId + suffix;
				InputStream ins = null;
				OutputStream os = null;
				try {
					ins = item.getInputStream();
					os = new FileOutputStream(new File(one.getPath() + File.separator + newfilename));
					byte[] buffer = new byte[1024];
					int len = 0;
					while((len = ins.read(buffer)) > 0) {
						os.write(buffer, 0, len);
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				} finally {
					if(ins != null) {
						ins.close();
					}
					if(os != null) {
						os.close();
						os.flush();
					}
				}
			}
		}
	}
	request.setAttribute("photoPath", photoPath);
	request.getRequestDispatcher("/photocut.jsp").forward(request, response);
%>


