<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>新用户认证资料</title>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
        <div class="tit-box mb15 element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">新用户认证资料</span></div>
        <div class="overf-h">
          <div id="shoujishiming" class="con-tabname xyhrzzl-tabname bd-b-color-main tab-on" style="width:143px;padding-left:0;padding-right:0;">手机实名认证</div>
          <div class="xyhrzzl-spac10 bd-b-color-main"></div>
          <div id="shipin" class="con-tabname xyhrzzl-tabname bd-b-color-main">视屏认证</div>
          <div class="xyhrzzl-spac10 bd-b-color-main"></div>
          <div id="hukou" class="con-tabname xyhrzzl-tabname bd-b-color-main">户口认证</div>
          <div class="xyhrzzl-spac10 bd-b-color-main"></div>
          <div id="xueli" class="con-tabname xyhrzzl-tabname bd-b-color-main">学历认证</div>
          <div class="xyhrzzl-spac10 bd-b-color-main"></div>
          <div id="xueji" class="con-tabname xyhrzzl-tabname bd-b-color-main">学籍认证</div>
          <div class="xyhrzzl-spac10 bd-b-color-main"></div>
          <div id="wangsahng" class="con-tabname xyhrzzl-tabname bd-b-color-main">网商认证</div>
        </div>
        <div style="height:700px;">
	        <div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-shoujishiming">
	          <table class="xyhrzzl-tips bd-color-main">
	            <tr class="bg-color-s">
	              <td><img src="${ctx}/images/shoujirenzheng.png" alt=""></td>
	              <td class="color-main">温馨提示：1.手机认证目前免费，仅限发布借款用户。<br><span></span>2.需正常使用手机三个月以上。</td>
	            </tr>
	          </table>
	          <dl class="con-table-right xyhrzzl-tab">
	            <dt>手机号码 :</dt>
	            <dd><input id="shoujihao-box" class="text-input" type="text" value="请输入手机号码"></dd>
	            <dt>身份证号码 :</dt>
	            <dd><input id="shenfenzhenghao-box" class="text-input" type="text" value="请输入身份证号码"></dd>
	          </dl>
	          <div style="text-align:center;">
	            <input id="sub-btn-shoujirenzheng" class="sub-btn bg-color-l" type="submit" value="进行验证">
	          </div>
	        </div>
	        <div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-shipin" style="display:none;">
	          <table class="xyhrzzl-tips bd-color-main">
	            <tr class="bg-color-s">
	              <td><img src="${ctx}/images/shipinrenzheng.png" alt=""></td>
	              <td class="color-main">温馨提示：通过视频认证能提高借款成功率高46%；<br><span></span>提高借款成功率和列表受关注度60%；<br>资费标准：免费认证，永久有效；</td>
	            </tr>
	          </table>
	          <div style="margin-left:50px;font-size:16px;color:#ff5200;line-height:40px;margin-top:30px;">视屏认证样本</div>
	          <div style="margin-left:50px;padding-bottom:40px;">
	            <img src="${ctx}/images/shipinrenzheng-pic.png" alt="">
	            <div class="con-shipin"><span style="font-size:20px;">请按如下文字阅读：</span><br>各位亲，我是 张三，我在P2P贷的用户名是 zhangsan123。<br> 我是一个诚信的人，<br> 我了解P2P贷的所有规则，<br> 我向大家提交的所有资料都是真实的，<br>我会对自己的行为负责，<br>也会按时还款，请向我并且支持我吧！<br><span style="display:inline-block;font-size:15px;padding-top:20px;">上传视频文件：</span></div>
	          </div>
	          <div style="margin-left:50px;margin-bottom:30px;line-height:20px;">
	            <span style="font-size:14px;">视频要求：</span><br>
	            1、视频必须为本人真实场景拍摄，视频内不得出现直系亲属外的他人图像；<br> 
	            2、请您确保衣冠整洁，举止文明。图像需要清晰可辨，声音洪亮清楚；<br>
	            3、视频格式需为avi，mpeq，rm，rmvb，3qp，mp4，mov，mtv，wmv，amv类型，文件大小请小于10MB；
	          </div>
	        </div>
	        <div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-hukou" style="display:none;">
	          <table class="xyhrzzl-tips bd-color-main">
	            <tr class="bg-color-s">
	              <td><img src="${ctx}/images/hukourenzheng.png" alt=""></td>
	              <td class="color-main">温馨提示： 1、如果您的户口曾经发生迁移、注销或者您曾经（目前）出国、参<br><span></span>军，需要在新数据更新之后才能认证。<br><span></span>2、一线城市数据更新不超过1个月，二三线城市数据更新不超过三个<br><span></span>月，最长不超过6个月。</td>
	            </tr>
	          </table>
	          <div style="text-align:center;">
	            <input id="sub-btn-hukourenzheng" class="sub-btn bg-color-l" type="submit" value="通过户口认证">
	          </div>
	        </div>
	        <div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-xueli" style="display:none;">
	          <table class="xyhrzzl-tips bd-color-main">
	            <tr class="bg-color-s">
	              <td><img src="${ctx}/images/xuejirenzheng.png" alt=""></td>
	              <td class="color-main">温馨提示： 学历认证适用于已毕业人士。未毕业在校学生，请使用学籍认证。<br>资费标准：免费认证，永久有效。</td>
	            </tr>
	          </table>
	          <div style="margin-left:50px;font-size:14px;margin-top:30px;" class="xuelirenzheng-con">
	            1、2001年及以后毕业的，拥有专科或以上学历，可直接通过ID5查找国家教育部学历学位系统。<br>
	            <input id="sub-btn-xuelirenzheng" class="sub-btn bg-color-l" type="submit" value="马上进行免费学历认证"><br>
	            2、1991年（含）至2001年毕业的，拥有专科或以上学历，可 <a class="color-main" href="#" id="wangshangxuelirenzheng">网上学历查询</a> 获取12位在线验证码，<br> 将《学历证书电子注册备案》中的12位在线验证码输入到文本框，将在一个工作日内完成认证。<br>
	            <input type="text"><input id="sub-btn-xueliqueding" class="sub-btn bg-color-l" type="submit" value="确定">
	          </div>
	        </div>
	        <div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-xueji" style="display:none;">
          <table class="xyhrzzl-tips bd-color-main">
            <tr class="bg-color-s">
              <td><img src="${ctx}/images/xuejirenzheng.png" alt=""></td>
              <td class="color-main">温馨提示： 学籍认证适用于尚未毕业的在校生。如果已经毕业，请使用学历认<br><span></span>证。<br>资费标准：免费认证，永久有效。 </td>
            </tr>
          </table>
          <div style="text-align:center;">
            <input id="sub-btn-xuejirenzheng" class="sub-btn bg-color-l" type="submit" value="马上进行免费学历认证">
          </div>
          <div style="margin-left:50px;margin-bottom:50px;margin-right:50px;font-size:14px;">学籍认证范围是2007年之后入学的，经国家教育部学籍系统认可的研究生、普通本专科学生、港澳台侨及国外来华留学生、成人及网络教育学生（不含自考）。</div>
        </div>
        <div class="con-box bd-b-color-main bd-l-color-main bd-r-color-main con-box-wangsahng" style="display:none;">
          <div class="wangshang-con-tit"><div class="bg-color-m"><span class="bg-color-l" id="taobao">淘宝卖家认证</span></div><div class="bg-color-m" ><span id="ali">阿里巴巴卖家认证</span></div></div>
          <div class="con-box-taobao">
            <dl class="con-table-right xyhrzzl-tab">
              <dt>淘宝旺旺名 :</dt>
              <dd><input id="taobaowangwang-box" class="text-input" type="text" value=""></dd>
              <dt>网店地址 :</dt>
              <dd><input id="taobaowangdian-box" class="text-input" type="text" value="http://"></dd>
            </dl>
            <div style="text-align:center;">
              <input id="sub-btn-taobaowangwang" class="sub-btn bg-color-l" type="submit" value="进行验证">
            </div>
            <div class="wenxintishi">
              <span>温馨提示：</span><br>
              1、阿里巴巴大卖家需要加入诚信通，供应等级大于（含）1钻。<br>
              2、卖家是实物交易且总评价数大于（含）1000笔。<br>
              3、阿里巴巴卖家必须与您在***注册的真实姓名一致。<br>
              4、公司（含个体户）请先上传营业执照，请将营业执照及用户名、姓名发送至邮箱***@**.com。
            </div>
          </div>
          <div class="con-box-ali" style="display:none;">
            <dl class="con-table-right xyhrzzl-tab">
              <dt>店铺名称 :</dt>
              <dd><input id="dianpumingcheng-box" class="text-input" type="text" value=""></dd>
              <dt>店铺地址 :</dt>
              <dd><input id="dianpudizhi-box" class="text-input" type="text" value="http://"></dd>
            </dl>
            <div style="text-align:center;">
              <input id="sub-btn-shitidain" class="sub-btn bg-color-l" type="submit" value="进行验证">
            </div>
            <div class="wenxintishi">
              <span>温馨提示：</span><br>
              1、阿里巴巴大卖家需要加入诚信通，供应等级大于（含）1钻。<br>
              2、卖家是实物交易且总评价数大于（含）1000笔。<br>
              3、阿里巴巴卖家必须与您在***注册的真实姓名一致。<br>
              4、公司（含个体户）请先上传营业执照，请将营业执照及用户名、姓名发送至邮箱***@**.com。
            </div>
          </div>
        </div>
    </div>
  <script>
  $(function(){
    $("#sidebar>ul>li:not(:first)>a").hover(function(){
      $(this).css("background-color","#fd8f59");
      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
      $(this).children("div").css("background-position","-20px " + background_position_y);
    },function(){
      var background_position_y = $(this).children("div").css("background-position").split(" ")[1];
      $(this).css("background-color","#fff9d9");
      $(this).children("div").css("background-position","0px " + background_position_y);
    }).bind("click",function(){
      $(".subsidebar").hide();
      if ($(this).next().css("display")=="none") {
        $(this).next().show();
      }else{
        $(this).next().hide();
      };
    });

//公用js开始
	$(".con-tabname").click(function() {
		$(".con-tabname span").removeClass("color-main");
		$(this).find("span").addClass("color-main");
		$(".con-tabname").removeClass("tab-on");
		$(this).addClass("tab-on");
		$(".con-box").css("display", "none");
		$(".con-box-" + $(this).attr("id")).css("display", "block");
	});
	//公用js结束
	
    $(".wangshang-con-tit span").click(function(){
      $(".wangshang-con-tit span").removeClass("bg-color-l")
      $(this).addClass("bg-color-l");
      $(".con-box-taobao").css("display","none");
      $(".con-box-ali").css("display","none");
      $(".con-box-"+$(this).attr("id")).css("display","block");
    });


    $("#shoujihao-box").focus(function(){
      if ($(this).val()=="请输入手机号码") {
        $(this).attr("value","");
      };
    }).blur(function(){
      if ($(this).val()=="") {
        $(this).attr("value","请输入手机号码");
      };
    })
    $("#shenfenzhenghao-box").focus(function(){
      if ($(this).val()=="请输入身份证号码") {
        $(this).attr("value","");
      };
    }).blur(function(){
      if ($(this).val()=="") {
        $(this).attr("value","请输入身份证号码");
      };
    })
  })
  </script>
</body>
</html>