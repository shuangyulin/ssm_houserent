$(function () {
	$.ajax({
		url : "PriceRange/" + $("#priceRange_rangeId_edit").val() + "/update",
		type : "get",
		data : {
			//rangeId : $("#priceRange_rangeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (priceRange, response, status) {
			$.messager.progress("close");
			if (priceRange) { 
				$("#priceRange_rangeId_edit").val(priceRange.rangeId);
				$("#priceRange_rangeId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#priceRange_priceName_edit").val(priceRange.priceName);
				$("#priceRange_priceName_edit").validatebox({
					required : true,
					missingMessage : "请输入价格区间",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#priceRangeModifyButton").click(function(){ 
		if ($("#priceRangeEditForm").form("validate")) {
			$("#priceRangeEditForm").form({
			    url:"PriceRange/" +  $("#priceRange_rangeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#priceRangeEditForm").form("validate"))  {
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
			$("#priceRangeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
