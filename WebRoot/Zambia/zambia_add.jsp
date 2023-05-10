<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zambia.css" />
<div id="zambiaAddDiv">
	<form id="zambiaAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被赞新闻:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zambia_newsObj_newsId" name="zambia.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zambia_userObj_user_name" name="zambia.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">被赞时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="zambia_zambiaTime" name="zambia.zambiaTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="zambiaAddButton" class="easyui-linkbutton">添加</a>
			<a id="zambiaClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Zambia/js/zambia_add.js"></script> 
