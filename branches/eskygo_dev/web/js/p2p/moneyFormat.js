//金额相乘
//money--金额
//proportion--比例
function moneyFormatMUL(money,proportion){
	var needPay = Math.round(parseFloat(money*100 * proportion))/100;
	return needPay;
}

function monDivide(proportion){
	var needPay = Math.round(proportion*10)/1000;//精确到小数点后三位
	return needPay;
}

//金额相加
function moneySum(money,chargeMoney){
	var needPay = Math.round(parseFloat(money*100)+parseFloat(chargeMoney*100))/100;
	return needPay;
}
//金额减法
//money 减数 pamrm被减数
function moneySub(money,pamrm){
	var needPay = Math.round(parseFloat(money*100)-parseFloat(pamrm*100))/100;
	return needPay;
}