package com.deelon.crowdfunding.controller.front;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.deelon.crowdfunding.model.backstage.TcprojectAttachment;
import com.deelon.crowdfunding.service.backstage.TcprojectAttachmentService;

/**
 * 附件下载功能
 * 
 * @author xiaox
 * 
 */
public class DowFileByName extends HttpServlet {
	@Resource
	private TcprojectAttachmentService tcprojectAttachmentService;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fileId = request.getParameter("fileId");

		TcprojectAttachment ta = tcprojectAttachmentService.getById(Long
				.valueOf(fileId));
		String filePath = ta.getPapath();

		String fileName = filePath.substring(filePath.lastIndexOf("/") + 1,
				filePath.length());
		String root = getServletContext().getRealPath("/");
		root = root.replace("\\", "/") + filePath;
		response.setContentType("unknown");
		response.setHeader("Content-Disposition", "attachment; fileName=\""
				+ fileName + "\"");

		try {
			OutputStream os = response.getOutputStream();
			FileInputStream fis = new FileInputStream(root);

			BufferedInputStream bufIn = new BufferedInputStream(fis);
			BufferedOutputStream bufOut = new BufferedOutputStream(os);
			byte[] b = new byte[1024];
			int i = 0;
			while ((i = bufIn.read(b)) > 0) {
				bufOut.write(b, 0, i);
			}
			bufOut.flush();
			bufOut.close();
			bufIn.close();
			fis.close();
			os.flush();
			os.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
