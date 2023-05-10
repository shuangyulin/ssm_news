<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsComment.css" />
<div id="newsComment_editDiv">
	<form id="newsCommentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">评论id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_commentId_edit" name="newsComment.commentId" value="<%=request.getParameter("commentId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被评新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsComment_newsObj_newsId_edit" name="newsComment.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论人:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsComment_userObj_user_name_edit" name="newsComment.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">评论内容:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_content_edit" name="newsComment.content" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">评论时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsComment_commentTime_edit" name="newsComment.commentTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsCommentModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsComment/js/newsComment_modify.js"></script> 
