$(function () {
	$.ajax({
		url : "NewsInfo/" + $("#newsInfo_newsId_edit").val() + "/update",
		type : "get",
		data : {
			//newsId : $("#newsInfo_newsId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (newsInfo, response, status) {
			$.messager.progress("close");
			if (newsInfo) { 
				$("#newsInfo_newsId_edit").val(newsInfo.newsId);
				$("#newsInfo_newsId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#newsInfo_newsTitle_edit").val(newsInfo.newsTitle);
				$("#newsInfo_newsTitle_edit").validatebox({
					required : true,
					missingMessage : "请输入标题",
				});
				$("#newsInfo_newsContent_edit").val(newsInfo.newsContent);
				$("#newsInfo_newsContent_edit").validatebox({
					required : true,
					missingMessage : "请输入新闻内容",
				});
				$("#newsInfo_newsDate_edit").datebox({
					value: newsInfo.newsDate,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#newsInfoModifyButton").click(function(){ 
		if ($("#newsInfoEditForm").form("validate")) {
			$("#newsInfoEditForm").form({
			    url:"NewsInfo/" +  $("#newsInfo_newsId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#newsInfoEditForm").form("validate"))  {
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
			$("#newsInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
