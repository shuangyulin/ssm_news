<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsClass.css" />
<div id="newsClassAddDiv">
	<form id="newsClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">分类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsClass_newsClassName" name="newsClass.newsClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsClass/js/newsClass_add.js"></script> 
