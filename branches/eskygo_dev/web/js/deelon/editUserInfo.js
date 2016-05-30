//前端用户个人资料编辑，验证字段JS
$().ready(function() {
	//我的基本信息字段验证
	$("#editBaseInfoForm").validate({
		rules : {
			realName : {
				required : true,
				//realName : true,
				minlength : 1,
				maxlength : 12,
				chinese:true
			},
			school : {
				required : true
			},
			mobile : {
				required : true,
				mobile : true
			},
			qqNo : {
				required : true,
				qq : true
			},
			edu : {
				required : true
			},
			idNo : {
				required : true,
				idNo : true
			}
		},
		messages : {
			realName : {
				required : "必填",
				//realName : "必填!且不能包含 ?\/:\'*\"<>|\\",
				minlength : $.validator.format("用户名不能小于{0}个字 符"),
				maxlength : $.validator.format("用户名不能大于{0}个字 符"),
				chinese : "只能输入中文"
			},
			school : {
				required : "必填"
			},
			mobile : {
				required : "必填",
				mobile : "请输入正确的手机号"
			},
			qqNo : {
				required : "必填",
				qq : "请输入正确的QQ"
			},
			edu : {
				required : "必填"
			},
			idNo : {
				required : "必填",
				idNo : "请输入正确的身份证号"
			}
		}
	});
	
	//我的家庭情况字段验证
	$("#editBaseFamilyForm").validate({
		rules : {
			marriage : {
				required : true
			},
			fHouse : {
				required : true
			},
			FAreaId : {
				required : true
			},
			FAddress : {
				required : true
			},
			phone : {
				required : true,
				m_phone: true
			},
			liveYears : {
				required : true
			}
		},
		messages : {
			marriage : {
				required : "必选"
			},
			fHouse : {
				required : "必选"
			},
			FAreaId : {
				required : "必选"
			},
			FAddress : {
				required : "必填"
			},
			phone : {
				required : "必填",
				m_phone : "电话号码输入错误"
			},
			liveYears : {
				required : "必填"
			}
		}
	});
	
	//我的单位情况字段验证
	$("#editBaseCompanyForm").validate({
		rules : {
			jobsStatus : {
				required : true
			},
			nature : {
				required : true
			},
			workYears : {
				required : true
			},
			companyName : {
				required : true
			},
			deptName : {
				required : true
			},
			companyAddress : {
				required : true
			},
			companyPhone : {
				required : true,
				phone : true
			},
			CPost : {
				required : true
			},
			CIncomeScope : {
				required : true,
				number:true
				
			},
			cSize : {
				required : true
			},
			CIndustry : {
				required : true
			},
			CAreaid : {
				required : true
			}
		},
		messages : {
			jobsStatus : {
				required : "必填"
			},
			nature : {
				required : "必填"
			},
			workYears : {
				required : "必填"
			},
			companyName : {
				required : "必填"
			},
			deptName : {
				required : "必填"
			},
			companyAddress : {
				required : "必填"
			},
			companyPhone : {
				required : "必填",
				phone : "请输入正确的电话号码"
			},
			CPost : {
				required : "必填"
			},
			CIncomeScope : {
				required : "必填",
				number :"必须输入合法的数字(负数，小数)"
			},
			cSize : {
				required : "必填"
			},
			CIndustry : {
				required : "必填"
			},
			CAreaid : {
				required : "必填"
			}
		}
	});
	
	//我的联系方式字段验证
	$("#editBaseContactForm").validate({
		rules : {
			cName : {
				required : true,
				chinese : true
			},
			cRelation : {
				required : true
			},
			cMobile : {
				required : true,
				mobile : true
			},
			cOtherName : {
				required : true,
				chinese : true
			},
			cOtherRelation : {
				required : true
			},
			cOtherMobile : {
				required : true,
				mobile : true
			}
		},
		messages : {
			cName : {
				required : "必填",
				chinese : "只能输入中文"
			},
			cRelation : {
				required : "必选"
			},
			cMobile : {
				required : "必填",
				mobile : "请输入正确的手机号"
			},
			cOtherName : {
				required : "必填",
				chinese : "只能输入中文"
			},
			cOtherRelation : {
				required : "必选"
			},
			cOtherMobile : {
				required : "必填",
				mobile : "请输入正确的手机号"
			}
		}
	});
});
