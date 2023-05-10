var zambia_manage_tool = null; 
$(function () { 
	initZambiaManageTool(); //建立Zambia管理对象
	zambia_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#zambia_manage").datagrid({
		url : 'Zambia/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "zambiaId",
		sortOrder : "desc",
		toolbar : "#zambia_manage_tool",
		columns : [[
			{
				field : "zambiaId",
				title : "赞id",
				width : 70,
			},
			{
				field : "newsObj",
				title : "被赞新闻",
				width : 140,
			},
			{
				field : "userObj",
				title : "用户",
				width : 140,
			},
			{
				field : "zambiaTime",
				title : "被赞时间",
				width : 140,
			},
		]],
	});

	$("#zambiaEditDiv").dialog({
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
				if ($("#zambiaEditForm").form("validate")) {
					//验证表单 
					if(!$("#zambiaEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#zambiaEditForm").form({
						    url:"Zambia/" + $("#zambia_zambiaId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#zambiaEditForm").form("validate"))  {
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
			                        $("#zambiaEditDiv").dialog("close");
			                        zambia_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#zambiaEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#zambiaEditDiv").dialog("close");
				$("#zambiaEditForm").form("reset"); 
			},
		}],
	});
});

function initZambiaManageTool() {
	zambia_manage_tool = {
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
			$("#zambia_manage").datagrid("reload");
		},
		redo : function () {
			$("#zambia_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#zambia_manage").datagrid("options").queryParams;
			queryParams["newsObj.newsId"] = $("#newsObj_newsId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			$("#zambia_manage").datagrid("options").queryParams=queryParams; 
			$("#zambia_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#zambiaQueryForm").form({
			    url:"Zambia/OutToExcel",
			});
			//提交表单
			$("#zambiaQueryForm").submit();
		},
		remove : function () {
			var rows = $("#zambia_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var zambiaIds = [];
						for (var i = 0; i < rows.length; i ++) {
							zambiaIds.push(rows[i].zambiaId);
						}
						$.ajax({
							type : "POST",
							url : "Zambia/deletes",
							data : {
								zambiaIds : zambiaIds.join(","),
							},
							beforeSend : function () {
								$("#zambia_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#zambia_manage").datagrid("loaded");
									$("#zambia_manage").datagrid("load");
									$("#zambia_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#zambia_manage").datagrid("loaded");
									$("#zambia_manage").datagrid("load");
									$("#zambia_manage").datagrid("unselectAll");
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
			var rows = $("#zambia_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Zambia/" + rows[0].zambiaId +  "/update",
					type : "get",
					data : {
						//zambiaId : rows[0].zambiaId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (zambia, response, status) {
						$.messager.progress("close");
						if (zambia) { 
							$("#zambiaEditDiv").dialog("open");
							$("#zambia_zambiaId_edit").val(zambia.zambiaId);
							$("#zambia_zambiaId_edit").validatebox({
								required : true,
								missingMessage : "请输入赞id",
								editable: false
							});
							$("#zambia_newsObj_newsId_edit").combobox({
								url:"News/listAll",
							    valueField:"newsId",
							    textField:"newsTitle",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#zambia_newsObj_newsId_edit").combobox("select", zambia.newsObjPri);
									//var data = $("#zambia_newsObj_newsId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#zambia_newsObj_newsId_edit").combobox("select", data[0].newsId);
						            //}
								}
							});
							$("#zambia_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#zambia_userObj_user_name_edit").combobox("select", zambia.userObjPri);
									//var data = $("#zambia_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#zambia_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#zambia_zambiaTime_edit").val(zambia.zambiaTime);
							$("#zambia_zambiaTime_edit").validatebox({
								required : true,
								missingMessage : "请输入被赞时间",
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
