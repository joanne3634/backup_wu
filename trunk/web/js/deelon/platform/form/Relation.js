Namespace.register("com.deelon.platform.form");com.deelon.platform.form.Relation=function(){this.relations=new Array();this.pk="";this.addRelation=function(c,a,e){var d=new Object();d.tableName=a;d.fk=e;var b=this.isExists(a);if(b){return 1;}if(this.pk==""||this.pk==c){this.pk=c;this.relations.push(d);return 0;}return 2;};this.isExists=function(a){for(var b=0;b<this.relations.length;b++){var c=this.relations[b];if(c.tableName==a){return true;}}return false;};this.remove=function(a){for(var b=0;b<this.relations.length;b++){var c=this.relations[b];if(c.tableName==a){this.relations.splice(b,1);}}if(this.relations.length==0){this.pk="";}};this.getRelation=function(){var a=this.relations.length;if(a==0){return"";}var d=new StringBuffer();d.append("<relation pk='"+this.pk+"'>");for(var c=0;c<a;c++){var b=this.relations[c];d.append("<table name='"+b.tableName+"'  fk='"+b.fk+"' />");}d.append("</relation>");return d.toString();};};