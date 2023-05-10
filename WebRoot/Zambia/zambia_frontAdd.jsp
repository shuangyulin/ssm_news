<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.News" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>新闻赞添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Zambia/frontlist">新闻赞列表</a></li>
			    	<li role="presentation" class="active"><a href="#zambiaAdd" aria-controls="zambiaAdd" role="tab" data-toggle="tab">添加新闻赞</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="zambiaList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="zambiaAdd"> 
				      	<form class="form-horizontal" name="zambiaAddForm" id="zambiaAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="zambia_newsObj_newsId" class="col-md-2 text-right">被赞新闻:</label>
						  	 <div class="col-md-8">
							    <select id="zambia_newsObj_newsId" name="zambia.newsObj.newsId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="zambia_userObj_user_name" class="col-md-2 text-right">用户:</label>
						  	 <div class="col-md-8">
							    <select id="zambia_userObj_user_name" name="zambia.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="zambia_zambiaTime" class="col-md-2 text-right">被赞时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="zambia_zambiaTime" name="zambia.zambiaTime" class="form-control" placeholder="请输入被赞时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxZambiaAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#zambiaAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加新闻赞信息
	function ajaxZambiaAdd() { 
		//提交之前先验证表单
		$("#zambiaAddForm").data('bootstrapValidator').validate();
		if(!$("#zambiaAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Zambia/add",
			dataType : "json" , 
			data: new FormData($("#zambiaAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#zambiaAddForm").find("input").val("");
					$("#zambiaAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证新闻赞添加表单字段
	$('#zambiaAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"zambia.zambiaTime": {
				validators: {
					notEmpty: {
						message: "被赞时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化被赞新闻下拉框值 
	$.ajax({
		url: basePath + "News/listAll",
		type: "get",
		success: function(newss,response,status) { 
			$("#zambia_newsObj_newsId").empty();
			var html="";
    		$(newss).each(function(i,news){
    			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
    		});
    		$("#zambia_newsObj_newsId").html(html);
    	}
	});
	//初始化用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#zambia_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#zambia_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
