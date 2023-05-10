$(function () {
	$.ajax({
		url : "HourseType/" + $("#hourseType_typeId_edit").val() + "/update",
		type : "get",
		data : {
			//typeId : $("#hourseType_typeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (hourseType, response, status) {
			$.messager.progress("close");
			if (hourseType) { 
				$("#hourseType_typeId_edit").val(hourseType.typeId);
				$("#hourseType_typeId_edit").validatebox({
					required : true,
					missingMessage : "请输入类别编号",
					editable: false
				});
				$("#hourseType_typeName_edit").val(hourseType.typeName);
				$("#hourseType_typeName_edit").validatebox({
					required : true,
					missingMessage : "请输入房屋类型",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#hourseTypeModifyButton").click(function(){ 
		if ($("#hourseTypeEditForm").form("validate")) {
			$("#hourseTypeEditForm").form({
			    url:"HourseType/" +  $("#hourseType_typeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#hourseTypeEditForm").form("validate"))  {
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
			$("#hourseTypeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
