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
<title>新闻收藏添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>NewsCollection/frontlist">新闻收藏列表</a></li>
			    	<li role="presentation" class="active"><a href="#newsCollectionAdd" aria-controls="newsCollectionAdd" role="tab" data-toggle="tab">添加新闻收藏</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="newsCollectionList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="newsCollectionAdd"> 
				      	<form class="form-horizontal" name="newsCollectionAddForm" id="newsCollectionAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="newsCollection_newsObj_newsId" class="col-md-2 text-right">被收藏新闻:</label>
						  	 <div class="col-md-8">
							    <select id="newsCollection_newsObj_newsId" name="newsCollection.newsObj.newsId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsCollection_userObj_user_name" class="col-md-2 text-right">收藏人:</label>
						  	 <div class="col-md-8">
							    <select id="newsCollection_userObj_user_name" name="newsCollection.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="newsCollection_collectTime" class="col-md-2 text-right">收藏时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="newsCollection_collectTime" name="newsCollection.collectTime" class="form-control" placeholder="请输入收藏时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxNewsCollectionAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#newsCollectionAddForm .form-group {margin:10px;}  </style>
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
	//提交添加新闻收藏信息
	function ajaxNewsCollectionAdd() { 
		//提交之前先验证表单
		$("#newsCollectionAddForm").data('bootstrapValidator').validate();
		if(!$("#newsCollectionAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "NewsCollection/add",
			dataType : "json" , 
			data: new FormData($("#newsCollectionAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#newsCollectionAddForm").find("input").val("");
					$("#newsCollectionAddForm").find("textarea").val("");
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
	//验证新闻收藏添加表单字段
	$('#newsCollectionAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"newsCollection.collectTime": {
				validators: {
					notEmpty: {
						message: "收藏时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化被收藏新闻下拉框值 
	$.ajax({
		url: basePath + "News/listAll",
		type: "get",
		success: function(newss,response,status) { 
			$("#newsCollection_newsObj_newsId").empty();
			var html="";
    		$(newss).each(function(i,news){
    			html += "<option value='" + news.newsId + "'>" + news.newsTitle + "</option>";
    		});
    		$("#newsCollection_newsObj_newsId").html(html);
    	}
	});
	//初始化收藏人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#newsCollection_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#newsCollection_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
