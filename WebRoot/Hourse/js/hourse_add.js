$(function () {
	$("#hourse_hourseName").validatebox({
		required : true, 
		missingMessage : '请输入房屋名称',
	});

	$("#hourse_buildingObj_buildingId").combobox({
	    url:'BuildingInfo/listAll',
	    valueField: "buildingId",
	    textField: "buildingName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#hourse_buildingObj_buildingId").combobox("getData"); 
            if (data.length > 0) {
                $("#hourse_buildingObj_buildingId").combobox("select", data[0].buildingId);
            }
        }
	});
	$("#hourse_hourseTypeObj_typeId").combobox({
	    url:'HourseType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#hourse_hourseTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#hourse_hourseTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#hourse_priceRangeObj_rangeId").combobox({
	    url:'PriceRange/listAll',
	    valueField: "rangeId",
	    textField: "priceName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#hourse_priceRangeObj_rangeId").combobox("getData"); 
            if (data.length > 0) {
                $("#hourse_priceRangeObj_rangeId").combobox("select", data[0].rangeId);
            }
        }
	});
	$("#hourse_area").validatebox({
		required : true, 
		missingMessage : '请输入面积',
	});

	$("#hourse_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入租金(元/月)',
		invalidMessage : '租金(元/月)输入不对',
	});

	$("#hourse_louceng").validatebox({
		required : true, 
		missingMessage : '请输入楼层/总楼层',
	});

	$("#hourse_zhuangxiu").validatebox({
		required : true, 
		missingMessage : '请输入装修',
	});

	$("#hourse_connectPerson").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	$("#hourse_connectPhone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#hourseAddButton").click(function () {
		//验证表单 
		if(!$("#hourseAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#hourseAddForm").form({
			    url:"Hourse/add",
			    onSubmit: function(){
					if($("#hourseAddForm").form("validate"))  { 
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
                        $("#hourseAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#hourseAddForm").submit();
		}
	});

	//单击清空按钮
	$("#hourseClearButton").click(function () { 
		$("#hourseAddForm").form("clear"); 
	});
});
