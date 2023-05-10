<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/newsCollection.css" />
<div id="newsCollection_editDiv">
	<form id="newsCollectionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">收藏id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_collectionId_edit" name="newsCollection.collectionId" value="<%=request.getParameter("collectionId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被收藏新闻:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsCollection_newsObj_newsId_edit" name="newsCollection.newsObj.newsId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收藏人:</span>
			<span class="inputControl">
				<input class="textbox"  id="newsCollection_userObj_user_name_edit" name="newsCollection.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收藏时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="newsCollection_collectTime_edit" name="newsCollection.collectTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="newsCollectionModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/NewsCollection/js/newsCollection_modify.js"></script> 
