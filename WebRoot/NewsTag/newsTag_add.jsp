<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsTag.css" />
<div id="newsTagAddDiv">
	<form id="newsTagAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被标记新闻:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_newsObj_newsId" name="newsTag.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标记的用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_userObj_user_name" name="newsTag.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">新闻状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_newsState" name="newsTag.newsState" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">标记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_tagTime" name="newsTag.tagTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsTagAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsTagClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsTag/js/newsTag_add.js"></script> 
