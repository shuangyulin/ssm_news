$(function () {
	$("#newsComment_newsObj_newsId").combobox({
	    url:'News/listAll',
	    valueField: "newsId",
	    textField: "newsTitle",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#newsComment_newsObj_newsId").combobox("getData"); 
            if (data.length > 0) {
                $("#newsComment_newsObj_newsId").combobox("select", data[0].newsId);
            }
        }
	});
	$("#newsComment_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#newsComment_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#newsComment_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#newsComment_content").validatebox({
		required : true, 
		missingMessage : '请输入评论内容',
	});

	$("#newsComment_commentTime").validatebox({
		required : true, 
		missingMessage : '请输入评论时间',
	});

	//单击添加按钮
	$("#newsCommentAddButton").click(function () {
		//验证表单 
		if(!$("#newsCommentAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#newsCommentAddForm").form({
			    url:"NewsComment/add",
			    onSubmit: function(){
					if($("#newsCommentAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#newsCommentAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#newsCommentAddForm").submit();
		}
	});

	//单击清空按钮
	$("#newsCommentClearButton").click(function () { 
		$("#newsCommentAddForm").form("clear"); 
	});
});
