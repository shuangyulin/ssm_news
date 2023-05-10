var newsComment_manage_tool = null; 
$(function () { 
	initNewsCommentManageTool(); //建立NewsComment管理对象
	newsComment_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#newsComment_manage").datagrid({
		url : 'NewsComment/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "commentId",
		sortOrder : "desc",
		toolbar : "#newsComment_manage_tool",
		columns : [[
			{
				field : "commentId",
				title : "评论id",
				width : 70,
			},
			{
				field : "newsObj",
				title : "被评新闻",
				width : 140,
			},
			{
				field : "userObj",
				title : "评论人",
				width : 140,
			},
			{
				field : "content",
				title : "评论内容",
				width : 140,
			},
			{
				field : "commentTime",
				title : "评论时间",
				width : 140,
			},
		]],
	});

	$("#newsCommentEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#newsCommentEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsCommentEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsCommentEditForm").form({
						    url:"NewsComment/" + $("#newsComment_commentId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsCommentEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#newsCommentEditDiv").dialog("close");
			                        newsComment_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsCommentEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsCommentEditDiv").dialog("close");
				$("#newsCommentEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsCommentManageTool() {
	newsComment_manage_tool = {
		init: function() {
			$.ajax({
				url : "News/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#newsObj_newsId_query").combobox({ 
					    valueField:"newsId",
					    textField:"newsTitle",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{newsId:0,newsTitle:"不限制"});
					$("#newsObj_newsId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#newsComment_manage").datagrid("reload");
		},
		redo : function () {
			$("#newsComment_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#newsComment_manage").datagrid("options").queryParams;
			queryParams["newsObj.newsId"] = $("#newsObj_newsId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#newsComment_manage").datagrid("options").queryParams=queryParams; 
			$("#newsComment_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsCommentQueryForm").form({
			    url:"NewsComment/OutToExcel",
			});
			//提交表单
			$("#newsCommentQueryForm").submit();
		},
		remove : function () {
			var rows = $("#newsComment_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var commentIds = [];
						for (var i = 0; i < rows.length; i ++) {
							commentIds.push(rows[i].commentId);
						}
						$.ajax({
							type : "POST",
							url : "NewsComment/deletes",
							data : {
								commentIds : commentIds.join(","),
							},
							beforeSend : function () {
								$("#newsComment_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#newsComment_manage").datagrid("loaded");
									$("#newsComment_manage").datagrid("load");
									$("#newsComment_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#newsComment_manage").datagrid("loaded");
									$("#newsComment_manage").datagrid("load");
									$("#newsComment_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#newsComment_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "NewsComment/" + rows[0].commentId +  "/update",
					type : "get",
					data : {
						//commentId : rows[0].commentId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (newsComment, response, status) {
						$.messager.progress("close");
						if (newsComment) { 
							$("#newsCommentEditDiv").dialog("open");
							$("#newsComment_commentId_edit").val(newsComment.commentId);
							$("#newsComment_commentId_edit").validatebox({
								required : true,
								missingMessage : "请输入评论id",
								editable: false
							});
							$("#newsComment_newsObj_newsId_edit").combobox({
								url:"News/listAll",
							    valueField:"newsId",
							    textField:"newsTitle",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsComment_newsObj_newsId_edit").combobox("select", newsComment.newsObjPri);
									//var data = $("#newsComment_newsObj_newsId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsComment_newsObj_newsId_edit").combobox("select", data[0].newsId);
						            //}
								}
							});
							$("#newsComment_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsComment_userObj_user_name_edit").combobox("select", newsComment.userObjPri);
									//var data = $("#newsComment_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsComment_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#newsComment_content_edit").val(newsComment.content);
							$("#newsComment_content_edit").validatebox({
								required : true,
								missingMessage : "请输入评论内容",
							});
							$("#newsComment_commentTime_edit").val(newsComment.commentTime);
							$("#newsComment_commentTime_edit").validatebox({
								required : true,
								missingMessage : "请输入评论时间",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
