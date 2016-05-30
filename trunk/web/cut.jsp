<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.deelon.platform.model.system.GlobalType"%>
<%@page import="com.deelon.core.util.UniqueIdUtil"%>
<%@page import="com.deelon.platform.model.system.SysFile"%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.Public"%>
<%@page import="com.deelon.loan.model.front.TUser"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="javax.imageio.stream.ImageInputStream"%>
<%@page import="java.util.Iterator"%>
<%@page import="javax.imageio.ImageReader"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.imageio.ImageReadParam"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="com.deelon.platform.service.util.ServiceUtil" %>
<%@page import="com.deelon.crowdfunding.common.util.TUserUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.deelon.core.util.FileUtil"%>
<%@page import="com.deelon.loan.service.front.TUserService"%>
<%@page import="com.deelon.core.util.AppUtil" %>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.deelon.core.util.ContextUtil" %>
<%@page import="com.deelon.platform.model.system.SysUser" %>
<%

	TUserService tuserService = (TUserService)AppUtil.getBean(TUserService.class);
	String fileId = request.getParameter("fileId");
	String fileName = request.getParameter("fileName");

	String result = "";
	SysFile sysfile = TUserUtil.getSysFile(fileId);
	String oriphotoname = sysfile.getFilePath().substring(sysfile.getFilePath().lastIndexOf("\\") + 1);
	DecimalFormat formater = new DecimalFormat("0");
	int x1 = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("x1"))));
	int x2 = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("x2"))));
	int y1 = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("y1"))));
	int y2 = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("y2"))));
	int width = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("width"))));
	int height = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("height"))));
	int cutdivWidth = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("cutdivWidth"))));
	int cutdivHeight = Integer.parseInt(formater.format(Double.valueOf(request.getParameter("cutdivHeight"))));
	String newphotoname = "cut-" + oriphotoname;
	TUser user = TUserUtil.getLogUser(request);
	if(user == null){
		return;
	}
	//其实用不到这么多参数，这些参数您可以自己选择使用
	FileInputStream is = null;
	ImageInputStream iis = null;
	try {
		
		String attachPathProp = ServiceUtil.getBasePath().replace("/", "\\");
		//String attachPath = ServiceUtil.getBasePath().replace("/", "\\")  + File.separator + user.getLoginName() + File.separator;
		String attachPath = attachPathProp  + File.separator + user.getLoginName() + File.separator;
		String filePath = "";
		File one = new File(attachPath);
		Calendar cal = Calendar.getInstance();
		Integer year = Integer.valueOf(cal.get(1));
		Integer month = Integer.valueOf(cal.get(2) + 1);
		one = new File(attachPath + "/" + year + "/" + month);
		if (!one.exists()) {
		   one.mkdirs();
		 }
		
		
		//is = new FileInputStream(one.getPath() + File.separator + oriphotoname);
		is = new FileInputStream(attachPathProp + File.separator + sysfile.getFilePath());
		String fileSuffix = oriphotoname.substring(oriphotoname.lastIndexOf(".") + 1);
		Iterator<ImageReader> it = ImageIO.getImageReadersByFormatName(fileSuffix);
		ImageReader reader = it.next();
		iis = ImageIO.createImageInputStream(is);
		reader.setInput(iis, true);
		ImageReadParam param = reader.getDefaultReadParam();
		int widthReal = reader.getWidth(0);
		int heightReal = reader.getHeight(0);
		int x1new = Math.round(x1*widthReal/cutdivWidth);
		int y1new = Math.round(y1*heightReal/cutdivHeight);
		int widthnew = Math.round(width*widthReal/cutdivWidth);
		int heightnew = Math.round(height*heightReal/cutdivHeight);
		Rectangle rect = new Rectangle(x1new, y1new, widthnew, heightnew);
		param.setSourceRegion(rect);
		BufferedImage bi = reader.read(0, param);
		ImageIO.write(bi, fileSuffix, new File(one.getPath() + File.separator + newphotoname));
		
		user = tuserService.getById(user.getUserId());
		user.setMyPhoto(user.getLoginName() + "/" + year + "/" + month + "/" + newphotoname);
		tuserService.update(user);
		result = "保存成功";
		//SysFile sysFile = new SysFile();
		//sysFile.setFileId(UniqueIdUtil.genId());
		//sysFile.setFileName(fileName.substring(0,fileName.lastIndexOf(".")));
		//sysFile.setTypeId((long)6);
		//sysFile.setFilePath(user.getLoginName() + File.separator + year + File.separator + month + File.separator + newphotoname);
		//sysFile.setCreatetime(new Date());
		//sysFile.setExt(newphotoname.substring(newphotoname.lastIndexOf(".") + 1));
		//sysFile.setFileType("-");
		//sysFile.setNote(FileUtil.getFileSize(new File(one.getPath() + File.separator + newphotoname)));
		//sysFile.setCreatorId(user.getUserId());
		//sysFile.setCreator(user.getLoginName());
		//sysFile.setTotalBytes(Long.valueOf(is.available()));
		//sysFile.setDelFlag(SysFile.FILE_NOT_DEL);
		//TUserUtil.saveSysFile(sysFile);
	} catch (Exception ex) {
		result = "保存失败,请退出系统,重新登录后再上传";
		ex.printStackTrace();
	} finally {
		if (is != null) {
			is.close();
			is = null;
		}
		if (iis != null) {
			iis.close();
			iis = null;
		}
	}
%>

<script type="text/javascript">
	window.parent.openDialog('<%=result%>');
	setTimeout("window.parent.location = '${ctx}/loan/myAccount/myaccountPage.ht'",2000);
</script>

