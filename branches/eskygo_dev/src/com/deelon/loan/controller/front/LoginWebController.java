package com.deelon.loan.controller.front;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.deelon.core.web.controller.BaseController;

@Controller
@RequestMapping({"/loginWeb.ht"})
public class LoginWebController extends BaseController {
	

	@RequestMapping
	public void loginPage(HttpServletRequest request, HttpServletResponse response){
		 String ctxPath = request.getContextPath();
		 try {
			response.sendRedirect(ctxPath + "/loginWeb.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
