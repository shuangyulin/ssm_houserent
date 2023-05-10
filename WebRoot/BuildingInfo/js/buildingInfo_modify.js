$(function () {
	$.ajax({
		url : "BuildingInfo/" + $("#buildingInfo_buildingId_edit").val() + "/update",
		type : "get",
		data : {
			//buildingId : $("#buildingInfo_buildingId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (buildingInfo, response, status) {
			$.messager.progress("close");
			if (buildingInfo) { 
				$("#buildingInfo_buildingId_edit").val(buildingInfo.buildingId);
				$("#buildingInfo_buildingId_edit").validatebox({
					required : true,
					missingMessage : "请输入楼盘编号",
					editable: false
				});
				$("#buildingInfo_areaObj_areaId_edit").combobox({
					url:"AreaInfo/listAll",
					valueField:"areaId",
					textField:"areaName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#buildingInfo_areaObj_areaId_edit").combobox("select", buildingInfo.areaObjPri);
						//var data = $("#buildingInfo_areaObj_areaId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#buildingInfo_areaObj_areaId_edit").combobox("select", data[0].areaId);
						//}
					}
				});
				$("#buildingInfo_buildingName_edit").val(buildingInfo.buildingName);
				$("#buildingInfo_buildingName_edit").validatebox({
					required : true,
					missingMessage : "请输入楼盘名称",
				});
				$("#buildingInfo_buildingPhoto").val(buildingInfo.buildingPhoto);
				$("#buildingInfo_buildingPhotoImg").attr("src", buildingInfo.buildingPhoto);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#buildingInfoModifyButton").click(function(){ 
		if ($("#buildingInfoEditForm").form("validate")) {
			$("#buildingInfoEditForm").form({
			    url:"BuildingInfo/" +  $("#buildingInfo_buildingId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#buildingInfoEditForm").form("validate"))  {
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
			$("#buildingInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
