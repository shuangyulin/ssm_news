$(function () {
	$.ajax({
		url : "NewsCollection/" + $("#newsCollection_collectionId_edit").val() + "/update",
		type : "get",
		data : {
			//collectionId : $("#newsCollection_collectionId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (newsCollection, response, status) {
			$.messager.progress("close");
			if (newsCollection) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsCollectionModifyButton").click(function(){ 
		if ($("#newsCollectionEditForm").form("validate")) {
			$("#newsCollectionEditForm").form({
			    url:"NewsCollection/" +  $("#newsCollection_collectionId_edit").val() + "/update",
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
			$("#newsCollectionEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
