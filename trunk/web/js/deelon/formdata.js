(function(a) {
	a
			.extend(
					a.fn,
					{
						getCheckBoxValue : function(c, b) {
							a(":checkbox,:radio", b).each(function() {
								var d = a(this).attr("name");
								c[d] = "";
							});
							a(":checkbox:checked,:radio:checked", b).each(
									function() {
										var d = a(this).attr("name");
										if (c[d] == "") {
											c[d] = a(this).val();
										} else {
											c[d] += "," + a(this).val();
										}
									});
						},
						sortList : function() {
							form = a(this);
							form
									.find('[type="subtable"]')
									.each(
											function() {
												var d = this.id;
												var c = a(this);
												var b = 0;
												c.find('[type="append"]')
														.remove();
												c
														.find(
																'[type="subdata"]')
														.each(
																function() {
																	a(this)
																			.find(
																					"input,select,textarea")
																			.each(
																					function() {
																						var e = a(
																								this)
																								.attr(
																										"name");
																						var f = d
																								+ "List"
																								+ "["
																								+ b
																								+ "]."
																								+ e;
																						a(
																								this)
																								.attr(
																										"name",
																										f);
																					});
																	b++;
																});
											});
							form
									.find('div[type="sub"]')
									.each(
											function() {
												a(this)
														.find("table")
														.each(
																function() {
																	var d = this.id;
																	var c = a(this);
																	var b = 0;
																	c
																			.find(
																					'tr[type="append"]')
																			.remove();
																	c
																			.find(
																					'tr[type="subdata"]')
																			.each(
																					function() {
																						a(
																								this)
																								.find(
																										"input,select,textarea")
																								.each(
																										function() {
																											var e = a(
																													this)
																													.attr(
																															"name");
																											var f = d
																													+ "List"
																													+ "["
																													+ b
																													+ "]."
																													+ e;
																											a(
																													this)
																													.attr(
																															"name",
																															f);
																										});
																						b++;
																					});
																});
											});
						},
						setData : function() {
							var e = this;
							form = a(this);
							var d = form.find('[type="main"]');
							var b = {};
							d.find("input:text,input:hidden,textarea,select")
									.each(function() {
										var h = a(this).val();
										var g = a(this).attr("name");
										if (h != null && h != "") {
											b[g] = h;
										}
									});
							form.children("input:hidden").each(function() {
								var h = a(this).val();
								var g = a(this).attr("name");
								if (h != null && h != "") {
									b[g] = h;
								}
							});
							this.getCheckBoxValue(b, d);
							form
									.find('[type="sub"]')
									.each(
											function() {
												var i = this.id;
												var h = [];
												var g = a(this);
												g
														.find(
																'[type="subdata"]')
														.each(
																function() {
																	var j = {};
																	a(this)
																			.find(
																					"input:text,input:hidden,textarea,select")
																			.each(
																					function() {
																						var l = a(
																								this)
																								.val();
																						var k = a(
																								this)
																								.attr(
																										"name");
																						if (l != null
																								&& l != "") {
																							j[k] = l;
																						}
																					});
																	e
																			.getCheckBoxValue(
																					j,
																					g);
																	if (j != {}) {
																		h
																				.push(j);
																	}
																});
												b[i + "List"] = h;
											});
							var c = JSON2.stringify(b);
							a('textarea[name="json"]', form).remove();
							var f = "<textarea style='display:none;'  name='json'>"
									+ c + "</textarea>";
							form.append(a(f));
							return form;
						}
					});
})(jQuery);