package com.deelon.loan.controller.front.view;

public class ProjectDetailView {
	
	private String projectId;
	private String pName;
	private String loan;
	private String rateOut;
	private String complete;
	private String loanReal;
	private String payLoan;
	private String deadline;
	private String repayWay;
	private String canUseLoan;

	private String loginName;
	private String userId;
	private String userName;
	private String school;
	private String age;
	private String edu;
	
	private String marriage;
	private String cpyTrade;
	private String cpySize;
	private String post;
	private String workCity;
	private String workTime;
	
	private String salary;
	private String isBuyCar;
	private String isBuyCarLoan;
	private String isHouse;
	private String isHouseLoan;
	private String successNum;
	private String isbreakNum;
	private String filedId;//用户图像id
	private int creditOut;//借出信用
	private int creditIn;//借入信用
	private String proDesc;//项目描述
	private String pminInvest;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getEdu() {
		return edu;
	}
	public void setEdu(String edu) {
		this.edu = edu;
	}
	public String getMarriage() {
		return marriage;
	}
	public void setMarriage(String marriage) {
		this.marriage = marriage;
	}
	public String getCpyTrade() {
		return cpyTrade;
	}
	public void setCpyTrade(String cpyTrade) {
		this.cpyTrade = cpyTrade;
	}
	public String getCpySize() {
		return cpySize;
	}
	public void setCpySize(String cpySize) {
		this.cpySize = cpySize;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getWorkCity() {
		return workCity;
	}
	public void setWorkCity(String workCity) {
		this.workCity = workCity;
	}
	public String getWorkTime() {
		return workTime;
	}
	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}
	public String getSalary() {
		return salary;
	}
	public void setSalary(String salary) {
		this.salary = salary;
	}
	public String getIsBuyCar() {
		return isBuyCar;
	}
	public void setIsBuyCar(String isBuyCar) {
		this.isBuyCar = isBuyCar;
	}
	public String getIsBuyCarLoan() {
		return isBuyCarLoan;
	}
	public void setIsBuyCarLoan(String isBuyCarLoan) {
		this.isBuyCarLoan = isBuyCarLoan;
	}
	public String getIsHouse() {
		return isHouse;
	}
	public void setIsHouse(String isHouse) {
		this.isHouse = isHouse;
	}
	public String getIsHouseLoan() {
		return isHouseLoan;
	}
	public void setIsHouseLoan(String isHouseLoan) {
		this.isHouseLoan = isHouseLoan;
	}
	public String getLoan() {
		return loan;
	}
	public void setLoan(String loan) {
		this.loan = loan;
	}
	public String getRateOut() {
		return rateOut;
	}
	public void setRateOut(String rateOut) {
		this.rateOut = rateOut;
	}
	public String getComplete() {
		return complete;
	}
	public void setComplete(String complete) {
		this.complete = complete;
	}
	public String getLoanReal() {
		return loanReal;
	}
	public void setLoanReal(String loanReal) {
		this.loanReal = loanReal;
	}
	public String getPayLoan() {
		return payLoan;
	}
	public void setPayLoan(String payLoan) {
		this.payLoan = payLoan;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getRepayWay() {
		return repayWay;
	}
	public void setRepayWay(String repayWay) {
		this.repayWay = repayWay;
	}
	public String getCanUseLoan() {
		return canUseLoan;
	}
	public void setCanUseLoan(String canUseLoan) {
		this.canUseLoan = canUseLoan;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	
	
	public String getSuccessNum() {
		return successNum;
	}
	public void setSuccessNum(String successNum) {
		this.successNum = successNum;
	}
	public String getIsbreakNum() {
		return isbreakNum;
	}
	public void setIsbreakNum(String isbreakNum) {
		this.isbreakNum = isbreakNum;
	}
	
	public String getFiledId() {
		return filedId;
	}
	public void setFiledId(String filedId) {
		this.filedId = filedId;
	}
	
	
	public int getCreditOut() {
		return creditOut;
	}
	public void setCreditOut(int creditOut) {
		this.creditOut = creditOut;
	}
	public int getCreditIn() {
		return creditIn;
	}
	public void setCreditIn(int creditIn) {
		this.creditIn = creditIn;
	}
	
	
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	
	
	public String getPminInvest() {
		return pminInvest;
	}
	public void setPminInvest(String pminInvest) {
		this.pminInvest = pminInvest;
	}
	
	public String getProDesc() {
		return proDesc;
	}
	public void setProDesc(String proDesc) {
		this.proDesc = proDesc;
	}
	@Override
	public String toString() {
		return "ProjectDetailView [projectId=" + projectId + ", pName=" + pName
				+ ", loan=" + loan + ", rateOut=" + rateOut + ", complete="
				+ complete + ", loanReal=" + loanReal + ", payLoan=" + payLoan
				+ ", deadline=" + deadline + ", repayWay=" + repayWay
				+ ", canUseLoan=" + canUseLoan + ", userId=" + userId
				+ ", userName=" + userName + ", school=" + school + ", age="
				+ age + ", edu=" + edu + ", marriage=" + marriage
				+ ", cpyTrade=" + cpyTrade + ", cpySize=" + cpySize + ", post="
				+ post + ", workCity=" + workCity + ", workTime=" + workTime
				+ ", salary=" + salary + ", isBuyCar=" + isBuyCar
				+ ", isBuyCarLoan=" + isBuyCarLoan + ", isHouse=" + isHouse
				+ ", isHouseLoan=" + isHouseLoan + "]";
	}
}
