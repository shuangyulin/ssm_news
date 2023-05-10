var newsTag_manage_tool = null; 
$(function () { 
	initNewsTagManageTool(); //建立NewsTag管理对象
	newsTag_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#newsTag_manage").datagrid({
		url : 'NewsTag/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "tagId",
		sortOrder : "desc",
		toolbar : "#newsTag_manage_tool",
		columns : [[
			{
				field : "tagId",
				title : "标记id",
				width : 70,
			},
			{
				field : "newsObj",
				title : "被标记新闻",
				width : 140,
			},
			{
				field : "userObj",
				title : "标记的用户",
				width : 140,
			},
			{
				field : "newsState",
				title : "新闻状态",
				width : 70,
			},
			{
				field : "tagTime",
				title : "标记时间",
				width : 140,
			},
		]],
	});

	$("#newsTagEditDiv").dialog({
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
				if ($("#newsTagEditForm").form("validate")) {
					//验证表单 
					if(!$("#newsTagEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#newsTagEditForm").form({
						    url:"NewsTag/" + $("#newsTag_tagId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#newsTagEditForm").form("validate"))  {
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
			                        $("#newsTagEditDiv").dialog("close");
			                        newsTag_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#newsTagEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#newsTagEditDiv").dialog("close");
				$("#newsTagEditForm").form("reset"); 
			},
		}],
	});
});

function initNewsTagManageTool() {
	newsTag_manage_tool = {
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
			$("#newsTag_manage").datagrid("reload");
		},
		redo : function () {
			$("#newsTag_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#newsTag_manage").datagrid("options").queryParams;
			queryParams["newsObj.newsId"] = $("#newsObj_newsId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#newsTag_manage").datagrid("options").queryParams=queryParams; 
			$("#newsTag_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#newsTagQueryForm").form({
			    url:"NewsTag/OutToExcel",
			});
			//提交表单
			$("#newsTagQueryForm").submit();
		},
		remove : function () {
			var rows = $("#newsTag_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var tagIds = [];
						for (var i = 0; i < rows.length; i ++) {
							tagIds.push(rows[i].tagId);
						}
						$.ajax({
							type : "POST",
							url : "NewsTag/deletes",
							data : {
								tagIds : tagIds.join(","),
							},
							beforeSend : function () {
								$("#newsTag_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#newsTag_manage").datagrid("loaded");
									$("#newsTag_manage").datagrid("load");
									$("#newsTag_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#newsTag_manage").datagrid("loaded");
									$("#newsTag_manage").datagrid("load");
									$("#newsTag_manage").datagrid("unselectAll");
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
			var rows = $("#newsTag_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "NewsTag/" + rows[0].tagId +  "/update",
					type : "get",
					data : {
						//tagId : rows[0].tagId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (newsTag, response, status) {
						$.messager.progress("close");
						if (newsTag) { 
							$("#newsTagEditDiv").dialog("open");
							$("#newsTag_tagId_edit").val(newsTag.tagId);
							$("#newsTag_tagId_edit").validatebox({
								required : true,
								missingMessage : "请输入标记id",
								editable: false
							});
							$("#newsTag_newsObj_newsId_edit").combobox({
								url:"News/listAll",
							    valueField:"newsId",
							    textField:"newsTitle",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsTag_newsObj_newsId_edit").combobox("select", newsTag.newsObjPri);
									//var data = $("#newsTag_newsObj_newsId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsTag_newsObj_newsId_edit").combobox("select", data[0].newsId);
						            //}
								}
							});
							$("#newsTag_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#newsTag_userObj_user_name_edit").combobox("select", newsTag.userObjPri);
									//var data = $("#newsTag_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#newsTag_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#newsTag_newsState_edit").val(newsTag.newsState);
							$("#newsTag_newsState_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入新闻状态",
								invalidMessage : "新闻状态输入不对",
							});
							$("#newsTag_tagTime_edit").val(newsTag.tagTime);
							$("#newsTag_tagTime_edit").validatebox({
								required : true,
								missingMessage : "请输入标记时间",
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
