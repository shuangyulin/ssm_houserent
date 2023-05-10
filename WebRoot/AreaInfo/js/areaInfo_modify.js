$(function () {
	$.ajax({
		url : "AreaInfo/" + $("#areaInfo_areaId_edit").val() + "/update",
		type : "get",
		data : {
			//areaId : $("#areaInfo_areaId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (areaInfo, response, status) {
			$.messager.progress("close");
			if (areaInfo) { 
				$("#areaInfo_areaId_edit").val(areaInfo.areaId);
				$("#areaInfo_areaId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#areaInfo_areaName_edit").val(areaInfo.areaName);
				$("#areaInfo_areaName_edit").validatebox({
					required : true,
					missingMessage : "请输入区域名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#areaInfoModifyButton").click(function(){ 
		if ($("#areaInfoEditForm").form("validate")) {
			$("#areaInfoEditForm").form({
			    url:"AreaInfo/" +  $("#areaInfo_areaId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#areaInfoEditForm").form("validate"))  {
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
			$("#areaInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
