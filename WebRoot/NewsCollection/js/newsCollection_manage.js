var newsCollection_manage_tool = null; 
$(function () { 
	initNewsCollectionManageTool(); //建立NewsCollection管理对象
	newsCollection_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#newsCollection_manage").datagrid({
		url : 'NewsCollection/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "collectionId",
		sortOrder : "desc",
		toolbar : "#newsCollection_manage_tool",
		columns : [[
			{
				field : "collectionId",
				title : "收藏id",
				width : 70,
			},
			{
				field : "newsObj",
				title : "被收藏新闻",
				width : 140,
			},
			{
				field : "userObj",
				title : "收藏人",
				width : 140,
			},
			{
				field : "collectTime",
				title : "收藏时间",
				width : 140,
			},
		]],
	});

	$("#newsCollectionEditDiv").dialog({
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
				if ($("#newsCollectionEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsCollectionEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsCollectionEditForm").form({
						    url:"NewsCollection/" + $("#newsCollection_collectionId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsCollectionEditForm").form("validate"))  {
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
			                        $("#newsCollectionEditDiv").dialog("close");
			                        newsCollection_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsCollectionEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsCollectionEditDiv").dialog("close");
				$("#newsCollectionEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsCollectionManageTool() {
	newsCollection_manage_tool = {
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
			$("#newsCollection_manage").datagrid("reload");
		},
		redo : function () {
			$("#newsCollection_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#newsCollection_manage").datagrid("options").queryParams;
			queryParams["newsObj.newsId"] = $("#newsObj_newsId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#newsCollection_manage").datagrid("options").queryParams=queryParams; 
			$("#newsCollection_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsCollectionQueryForm").form({
			    url:"NewsCollection/OutToExcel",
			});
			//提交表单
			$("#newsCollectionQueryForm").submit();
		},
		remove : function () {
			var rows = $("#newsCollection_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var collectionIds = [];
						for (var i = 0; i < rows.length; i ++) {
							collectionIds.push(rows[i].collectionId);
						}
						$.ajax({
							type : "POST",
							url : "NewsCollection/deletes",
							data : {
								collectionIds : collectionIds.join(","),
							},
							beforeSend : function () {
								$("#newsCollection_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#newsCollection_manage").datagrid("loaded");
									$("#newsCollection_manage").datagrid("load");
									$("#newsCollection_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#newsCollection_manage").datagrid("loaded");
									$("#newsCollection_manage").datagrid("load");
									$("#newsCollection_manage").datagrid("unselectAll");
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
			var rows = $("#newsCollection_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "NewsCollection/" + rows[0].collectionId +  "/update",
					type : "get",
					data : {
						//collectionId : rows[0].collectionId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (newsCollection, response, status) {
						$.messager.progress("close");
						if (newsCollection) { 
							$("#newsCollectionEditDiv").dialog("open");
							$("#newsCollection_collectionId_edit").val(newsCollection.collectionId);
							$("#newsCollection_collectionId_edit").validatebox({
								required : true,
								missingMessage : "请输入收藏id",
								editable: false
							});
							$("#newsCollection_newsObj_newsId_edit").combobox({
								url:"News/listAll",
							    valueField:"newsId",
							    textField:"newsTitle",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsCollection_newsObj_newsId_edit").combobox("select", newsCollection.newsObjPri);
									//var data = $("#newsCollection_newsObj_newsId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsCollection_newsObj_newsId_edit").combobox("select", data[0].newsId);
						            //}
								}
							});
							$("#newsCollection_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsCollection_userObj_user_name_edit").combobox("select", newsCollection.userObjPri);
									//var data = $("#newsCollection_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsCollection_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#newsCollection_collectTime_edit").val(newsCollection.collectTime);
							$("#newsCollection_collectTime_edit").validatebox({
								required : true,
								missingMessage : "请输入收藏时间",
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
