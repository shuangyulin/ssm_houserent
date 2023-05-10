$(function () {
	$("#wantHourseInfo_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "realName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wantHourseInfo_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#wantHourseInfo_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#wantHourseInfo_title").validatebox({
		required : true, 
		missingMessage : '请输入标题',
	});

	$("#wantHourseInfo_position_areaId").combobox({
	    url:'AreaInfo/listAll',
	    valueField: "areaId",
	    textField: "areaName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wantHourseInfo_position_areaId").combobox("getData"); 
            if (data.length > 0) {
                $("#wantHourseInfo_position_areaId").combobox("select", data[0].areaId);
            }
        }
	});
	$("#wantHourseInfo_hourseTypeObj_typeId").combobox({
	    url:'HourseType/listAll',
	    valueField: "typeId",
	    textField: "typeName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wantHourseInfo_hourseTypeObj_typeId").combobox("getData"); 
            if (data.length > 0) {
                $("#wantHourseInfo_hourseTypeObj_typeId").combobox("select", data[0].typeId);
            }
        }
	});
	$("#wantHourseInfo_priceRangeObj_rangeId").combobox({
	    url:'PriceRange/listAll',
	    valueField: "rangeId",
	    textField: "priceName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wantHourseInfo_priceRangeObj_rangeId").combobox("getData"); 
            if (data.length > 0) {
                $("#wantHourseInfo_priceRangeObj_rangeId").combobox("select", data[0].rangeId);
            }
        }
	});
	$("#wantHourseInfo_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入最高能出租金',
		invalidMessage : '最高能出租金输入不对',
	});

	$("#wantHourseInfo_lianxiren").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	$("#wantHourseInfo_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#wantHourseInfoAddButton").click(function () {
		//验证表单 
		if(!$("#wantHourseInfoAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#wantHourseInfoAddForm").form({
			    url:"WantHourseInfo/add",
			    onSubmit: function(){
					if($("#wantHourseInfoAddForm").form("validate"))  { 
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
                        $("#wantHourseInfoAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#wantHourseInfoAddForm").submit();
		}
	});

	//单击清空按钮
	$("#wantHourseInfoClearButton").click(function () { 
		$("#wantHourseInfoAddForm").form("clear"); 
	});
});
