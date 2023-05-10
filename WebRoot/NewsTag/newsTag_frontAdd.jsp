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
<title>新闻标记添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>NewsTag/frontlist">新闻标记列表</a></li>
			    	<li role="presentation" class="active"><a href="#newsTagAdd" aria-controls="newsTagAdd" role="tab" data-toggle="tab">添加新闻标记</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="newsTagList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="newsTagAdd"> 
				      	<form class="form-horizontal" name="newsTagAddForm" id="newsTagAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="newsTag_newsObj_newsId" class="col-md-2 text-right">被标记新闻:</label>
						  	 <div class="col-md-8">
							    <select id="newsTag_newsObj_newsId" name="newsTag.newsObj.newsId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsTag_userObj_user_name" class="col-md-2 text-right">标记的用户:</label>
						  	 <div class="col-md-8">
							    <select id="newsTag_userObj_user_name" name="newsTag.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsTag_newsState" class="col-md-2 text-right">新闻状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="newsTag_newsState" name="newsTag.newsState" class="form-control" placeholder="请输入新闻状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsTag_tagTime" class="col-md-2 text-right">标记时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="newsTag_tagTime" name="newsTag.tagTime" class="form-control" placeholder="请输入标记时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxNewsTagAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#newsTagAddForm .form-group {margin:10px;}  </style>
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
	//提交添加新闻标记信息
	function ajaxNewsTagAdd() { 
		//提交之前先验证表单
		$("#newsTagAddForm").data('bootstrapValidator').validate();
		if(!$("#newsTagAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "NewsTag/add",
			dataType : "json" , 
			data: new FormData($("#newsTagAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#newsTagAddForm").find("input").val("");
					$("#newsTagAddForm").find("textarea").val("");
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
	//验证新闻标记添加表单字段
	$('#newsTagAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"newsTag.newsState": {
				validators: {
					notEmpty: {
						message: "新闻状态不能为空",
					},
					integer: {
						message: "新闻状态不正确"
					}
				}
			},
			"newsTag.tagTime": {
				validators: {
					notEmpty: {
						message: "标记时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化被标记新闻下拉框值 
	$.ajax({
		url: basePath + "News/listAll",
		type: "get",
		success: function(newss,response,status) { 
			$("#newsTag_newsObj_newsId").empty();
			var html="";
    		$(newss).each(function(i,news){
    			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
    		});
    		$("#newsTag_newsObj_newsId").html(html);
    	}
	});
	//初始化标记的用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#newsTag_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#newsTag_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
