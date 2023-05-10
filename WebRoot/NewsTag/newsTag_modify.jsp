<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsTag.css" />
<div id="newsTag_editDiv">
	<form id="newsTagEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标记id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_tagId_edit" name="newsTag.tagId" value="<%=request.getParameter("tagId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被标记新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsTag_newsObj_newsId_edit" name="newsTag.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标记的用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsTag_userObj_user_name_edit" name="newsTag.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">新闻状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_newsState_edit" name="newsTag.newsState" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">标记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsTag_tagTime_edit" name="newsTag.tagTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsTagModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsTag/js/newsTag_modify.js"></script> 
