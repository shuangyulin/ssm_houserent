$(function () {
	$.ajax({
		url : "WantHourseInfo/" + $("#wantHourseInfo_wantHourseId_edit").val() + "/update",
		type : "get",
		data : {
			//wantHourseId : $("#wantHourseInfo_wantHourseId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (wantHourseInfo, response, status) {
			$.messager.progress("close");
			if (wantHourseInfo) { 
				$("#wantHourseInfo_wantHourseId_edit").val(wantHourseInfo.wantHourseId);
				$("#wantHourseInfo_wantHourseId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#wantHourseInfo_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"realName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wantHourseInfo_userObj_user_name_edit").combobox("select", wantHourseInfo.userObjPri);
						//var data = $("#wantHourseInfo_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wantHourseInfo_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#wantHourseInfo_title_edit").val(wantHourseInfo.title);
				$("#wantHourseInfo_title_edit").validatebox({
					required : true,
					missingMessage : "请输入标题",
				});
				$("#wantHourseInfo_position_areaId_edit").combobox({
					url:"AreaInfo/listAll",
					valueField:"areaId",
					textField:"areaName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wantHourseInfo_position_areaId_edit").combobox("select", wantHourseInfo.positionPri);
						//var data = $("#wantHourseInfo_position_areaId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wantHourseInfo_position_areaId_edit").combobox("select", data[0].areaId);
						//}
					}
				});
				$("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox({
					url:"HourseType/listAll",
					valueField:"typeId",
					textField:"typeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox("select", wantHourseInfo.hourseTypeObjPri);
						//var data = $("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wantHourseInfo_hourseTypeObj_typeId_edit").combobox("select", data[0].typeId);
						//}
					}
				});
				$("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox({
					url:"PriceRange/listAll",
					valueField:"rangeId",
					textField:"priceName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox("select", wantHourseInfo.priceRangeObjPri);
						//var data = $("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wantHourseInfo_priceRangeObj_rangeId_edit").combobox("select", data[0].rangeId);
						//}
					}
				});
				$("#wantHourseInfo_price_edit").val(wantHourseInfo.price);
				$("#wantHourseInfo_price_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入最高能出租金",
					invalidMessage : "最高能出租金输入不对",
				});
				$("#wantHourseInfo_lianxiren_edit").val(wantHourseInfo.lianxiren);
				$("#wantHourseInfo_lianxiren_edit").validatebox({
					required : true,
					missingMessage : "请输入联系人",
				});
				$("#wantHourseInfo_telephone_edit").val(wantHourseInfo.telephone);
				$("#wantHourseInfo_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#wantHourseInfoModifyButton").click(function(){ 
		if ($("#wantHourseInfoEditForm").form("validate")) {
			$("#wantHourseInfoEditForm").form({
			    url:"WantHourseInfo/" +  $("#wantHourseInfo_wantHourseId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#wantHourseInfoEditForm").form("validate"))  {
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
			$("#wantHourseInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
