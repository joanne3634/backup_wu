function FlexUploadDialog(e) {
	if (!e) {
		e = {};
	}
	var d = e.isSingle ? 1 : 0;
	var a = __ctx + "/platform/system/sysFile/dialog.ht?isSingle=" + d;
	var b = "dialogWidth:800px;dialogHeight:500px;help:0;status:0;scroll:1;center:1";
	if (!e.isSingle) {
		e.isSingle = false;
	}
	a = a.getNewUrl();
	var f = window.showModalDialog(a, "", b);
	if (f != undefined) {
		if (e.callback) {
			var h = f.fileIds;
			var c = f.fileNames;
			var g = f.filePaths;
			var i = f.extPath;
			e.callback.call(this, h, c, g, i);
		}
	}
}
function DirectUploadDialog(b,t) {
	if (!b) {
		b = {};
	}
	var a = __ctx + "/user/file/uploadDialog.ht?materialsId=" + t;
	a = a.getNewUrl();
	var c = window;
	if (b != undefined && b != null) {
		if (b.callback) {
			c.returnValue = b.callback;
		}
		if (b.uploadType != undefined && b.uploadType != null
				&& b.uploadType == "pictureShow") {
			a += "&uploadType=pictureShow";
		}
		if (b.fileFormates != undefined && b.fileFormates != null
				&& b.fileFormates != "") {
			a += "&fileFormates=" + b.fileFormates;
		}
	}
	openwindow(a, "图片上传", "500", "300");
}
function openwindow(b, a, c, f) {
	var b;
	var a;
	var c;
	var f;
	var e = (window.screen.availHeight - 30 - f) / 2;
	var d = (window.screen.availWidth - 10 - c) / 2;
	window
			.open(
					b,
					"fileUpload",
					"height="
							+ f
							+ ",,innerHeight="
							+ f
							+ ",width="
							+ c
							+ ",innerWidth="
							+ c
							+ ",top="
							+ e
							+ ",left="
							+ d
							+ ",toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no");
}
function UploadDialog(c) {
	if (!c) {
		c = {};
	}
	var b = __ctx + "/user/file/uploadDialog.ht";
	var a = "dialogWidth:450px;dialogHeight:300px;help:0;status:0;scroll:1;center:1";
	b = b.getNewUrl();
	var d = window.showModalDialog(b, "", a);
	if (d != undefined) {
		if (c.callback) {
			c.callback.call(this, d);
		}
	}
}