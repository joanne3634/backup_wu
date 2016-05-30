ScriptLoader = function() {
	this.timeout = 10;
	this.scripts = [];
	this.disableCaching = true;
	this.loadMask = null;
};
ScriptLoader.prototype = {
	processSuccess : function(a) {
		if (typeof a.argument.callback == "function") {
			a.argument.callback.call(a.argument.scope, a.responseText,
					a.argument.url, a.argument.index);
		}
	},
	load : function(c, e) {
		var a, d, b;
		if (typeof c == "object") {
			a = c;
			c = a.url;
			b = a.index;
			e = e || a.callback;
			d = a.scope;
			if (typeof a.timeout != "undefined") {
				this.timeout = a.timeout;
			}
			if (typeof a.disableCaching != "undefined") {
				this.disableCaching = a.disableCaching;
			}
		}
		if (this.scripts[c]) {
			if (typeof e == "function") {
				e.call(d || window);
			}
			return null;
		}
		$.ajax({
			url : c,
			dataType : "script",
			cache : !this.disableCaching,
			success : this.processSucess,
			argument : {
				"url" : c,
				"scope" : d || window,
				"callback" : e,
				"options" : a,
				"index" : b
			}
		});
	}
};
ScriptLoaderMgr = function() {
	this.mdCache = [];
	this.loader = new ScriptLoader();
	this.load = function(o) {
		this.loader.scope = o.scope;
		if (!o.scripts instanceof Array) {
			o.scripts = [ o.scripts ];
		}
		o.lfiles = 0;
		this.mdCache.length = 0;
		var mdCache = this.mdCache;
		for ( var i = 0; i < o.scripts.length; i++) {
			o.url = o.scripts[i];
			o.index = i;
			this.loader.load(o, function(rs, url, idx) {
				o.scope = this;
				mdCache[idx] = {
					content : rs
				};
				o.lfiles++;
				if (o.lfiles >= o.scripts.length) {
					for ( var j = 0; j < mdCache.length; j++) {
						try {
							window.execScript ? window
									.execScript(mdCache[j].content) : window
									.eval(mdCache[j].content);
						} catch (ex) {
						}
					}
					if (o.callback != null) {
						o.callback.call(this);
					}
				}
			});
		}
	};
};
ScriptMgr = new ScriptLoaderMgr();