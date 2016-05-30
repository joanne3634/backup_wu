<%@tag import="com.deelon.loan.model.front.TUserCompany"%>
<%@tag import="com.deelon.loan.service.front.TuserCompanyService"%>
<%@tag import="com.deelon.core.util.AppUtil"%>
<%@tag pageEncoding="utf-8"%>
<%@ attribute name="menupath" required="true" description="帮助中心二级菜单"%>
<%@tag import="java.util.*"%>
<%
	StringBuffer sb = new StringBuffer("");
	TuserCompanyService tuserCompanyService = (TuserCompanyService) AppUtil
			.getBean(TuserCompanyService.class);
	TUserCompany tuserCompany = tuserCompanyService
			.queryTUserCompanyByuserId(menupath.trim());
	if (tuserCompany == null) {
		sb.append("暂时未提供");
	} else {
		if (tuserCompany.getCDeptName() == null
				|| "".equals(tuserCompany.getCDeptName())) {
			sb.append("暂时未提供");
		} else {
			sb.append(tuserCompany.getCDeptName());
		}
	}
	out.print(sb.toString());
%>