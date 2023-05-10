$(function () {
	$.ajax({
		url : "Zambia/" + $("#zambia_zambiaId_edit").val() + "/update",
		type : "get",
		data : {
			//zambiaId : $("#zambia_zambiaId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (zambia, response, status) {
			$.messager.progress("close");
			if (zambia) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#zambiaModifyButton").click(function(){ 
		if ($("#zambiaEditForm").form("validate")) {
			$("#zambiaEditForm").form({
			    url:"Zambia/" +  $("#zambia_zambiaId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#zambiaEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
