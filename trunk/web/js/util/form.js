Namespace.register("com.deelon.form");
com.deelon.form.Form = function() {
	this.creatForm = function(a, c) {
		var b = document.getElementById(a);
		if (b == null || b == undefined) {
			b = document.createElement("FORM");
			document.body.appendChild(b);
		}
		this.form = b;
		this.form.method = "post";
		this.parseAction(c);
	};
	this.parseAction = function(d) {
		var b = d.indexOf("?");
		if (b == -1) {
			this.form.action = d;
		} else {
			var a = d.split("?");
			var g = a[0];
			this.form.action = g;
			var h = a[1];
			var f = h.split("&");
			for ( var c = 0; c < f.length; c++) {
				var e = f[c].split("=");
				this.addFormEl(e[0], e[1]);
			}
		}
	};
	this.setMethod = function(a) {
		this.form.method = a;
	};
	this.setTarget = function(a) {
		this.form.target = a;
	};
	this.clearFormEl = function() {
		var c = this.form.childNodes;
		for ( var a = c.length; a >= 0; a--) {
			var b = c[a];
			this.form.removeNode(b);
		}
	};
	this.addFormEl = function(a, c) {
		var b = document.createElement("input");
		b.setAttribute("name", a);
		b.setAttribute("type", "hidden");
		b.setAttribute("value", c);
		this.form.appendChild(b);
	};
	this.submit = function() {
		this.form.submit();
	};
};
com.deelon.form.ResultMessage = function(data) {
	this.data = eval("(" + data + ")");
	this.isSuccess = function() {
		return this.data["result"] == 1;
	};
	this.getMessage = function() {
		return this.data["message"];
	};
	/**
	 * 获取对像主键
	 */
	this.getPkId=function(){
		return this.data['pkId'];
	};
	/**
	 * 获取对像主键的名称
	 */
	this.getPkName=function(){
		return this.data['pkName'];
	};
};