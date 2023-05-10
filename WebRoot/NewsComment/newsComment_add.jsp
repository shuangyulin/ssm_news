<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsComment.css" />
<div id="newsCommentAddDiv">
	<form id="newsCommentAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被评新闻:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_newsObj_newsId" name="newsComment.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_userObj_user_name" name="newsComment.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_content" name="newsComment.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">评论时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_commentTime" name="newsComment.commentTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsCommentAddButton" class="easyui-linkbutton">添加</a>
			<a id="newsCommentClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsComment/js/newsComment_add.js"></script> 
