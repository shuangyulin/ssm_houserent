$(function () {
	$.ajax({
		url : "Hourse/" + $("#hourse_hourseId_edit").val() + "/update",
		type : "get",
		data : {
			//hourseId : $("#hourse_hourseId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (hourse, response, status) {
			$.messager.progress("close");
			if (hourse) { 
				$("#hourse_hourseId_edit").val(hourse.hourseId);
				$("#hourse_hourseId_edit").validatebox({
					required : true,
					missingMessage : "请输入房屋编号",
					editable: false
				});
				$("#hourse_hourseName_edit").val(hourse.hourseName);
				$("#hourse_hourseName_edit").validatebox({
					required : true,
					missingMessage : "请输入房屋名称",
				});
				$("#hourse_buildingObj_buildingId_edit").combobox({
					url:"BuildingInfo/listAll",
					valueField:"buildingId",
					textField:"buildingName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#hourse_buildingObj_buildingId_edit").combobox("select", hourse.buildingObjPri);
						//var data = $("#hourse_buildingObj_buildingId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#hourse_buildingObj_buildingId_edit").combobox("select", data[0].buildingId);
						//}
					}
				});
				$("#hourse_housePhoto").val(hourse.housePhoto);
				$("#hourse_housePhotoImg").attr("src", hourse.housePhoto);
				$("#hourse_hourseTypeObj_typeId_edit").combobox({
					url:"HourseType/listAll",
					valueField:"typeId",
					textField:"typeName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#hourse_hourseTypeObj_typeId_edit").combobox("select", hourse.hourseTypeObjPri);
						//var data = $("#hourse_hourseTypeObj_typeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#hourse_hourseTypeObj_typeId_edit").combobox("select", data[0].typeId);
						//}
					}
				});
				$("#hourse_priceRangeObj_rangeId_edit").combobox({
					url:"PriceRange/listAll",
					valueField:"rangeId",
					textField:"priceName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#hourse_priceRangeObj_rangeId_edit").combobox("select", hourse.priceRangeObjPri);
						//var data = $("#hourse_priceRangeObj_rangeId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#hourse_priceRangeObj_rangeId_edit").combobox("select", data[0].rangeId);
						//}
					}
				});
				$("#hourse_area_edit").val(hourse.area);
				$("#hourse_area_edit").validatebox({
					required : true,
					missingMessage : "请输入面积",
				});
				$("#hourse_price_edit").val(hourse.price);
				$("#hourse_price_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入租金(元/月)",
					invalidMessage : "租金(元/月)输入不对",
				});
				$("#hourse_louceng_edit").val(hourse.louceng);
				$("#hourse_louceng_edit").validatebox({
					required : true,
					missingMessage : "请输入楼层/总楼层",
				});
				$("#hourse_zhuangxiu_edit").val(hourse.zhuangxiu);
				$("#hourse_zhuangxiu_edit").validatebox({
					required : true,
					missingMessage : "请输入装修",
				});
				$("#hourse_caoxiang_edit").val(hourse.caoxiang);
				$("#hourse_madeYear_edit").val(hourse.madeYear);
				$("#hourse_connectPerson_edit").val(hourse.connectPerson);
				$("#hourse_connectPerson_edit").validatebox({
					required : true,
					missingMessage : "请输入联系人",
				});
				$("#hourse_connectPhone_edit").val(hourse.connectPhone);
				$("#hourse_connectPhone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#hourse_detail_edit").val(hourse.detail);
				$("#hourse_address_edit").val(hourse.address);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#hourseModifyButton").click(function(){ 
		if ($("#hourseEditForm").form("validate")) {
			$("#hourseEditForm").form({
			    url:"Hourse/" +  $("#hourse_hourseId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#hourseEditForm").form("validate"))  {
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
			$("#hourseEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
