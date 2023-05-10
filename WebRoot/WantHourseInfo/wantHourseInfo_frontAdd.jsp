<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.AreaInfo" %>
<%@ page import="com.chengxusheji.po.HourseType" %>
<%@ page import="com.chengxusheji.po.PriceRange" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>求租信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>WantHourseInfo/frontlist">求租信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#wantHourseInfoAdd" aria-controls="wantHourseInfoAdd" role="tab" data-toggle="tab">添加求租信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="wantHourseInfoList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="wantHourseInfoAdd"> 
				      	<form class="form-horizontal" name="wantHourseInfoAddForm" id="wantHourseInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="wantHourseInfo_userObj_user_name" class="col-md-2 text-right">求租用户:</label>
						  	 <div class="col-md-8">
							    <select id="wantHourseInfo_userObj_user_name" name="wantHourseInfo.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_title" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wantHourseInfo_title" name="wantHourseInfo.title" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_position_areaId" class="col-md-2 text-right">求租区域:</label>
						  	 <div class="col-md-8">
							    <select id="wantHourseInfo_position_areaId" name="wantHourseInfo.position.areaId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_hourseTypeObj_typeId" class="col-md-2 text-right">房屋类型:</label>
						  	 <div class="col-md-8">
							    <select id="wantHourseInfo_hourseTypeObj_typeId" name="wantHourseInfo.hourseTypeObj.typeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_priceRangeObj_rangeId" class="col-md-2 text-right">价格范围:</label>
						  	 <div class="col-md-8">
							    <select id="wantHourseInfo_priceRangeObj_rangeId" name="wantHourseInfo.priceRangeObj.rangeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_price" class="col-md-2 text-right">最高能出租金:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wantHourseInfo_price" name="wantHourseInfo.price" class="form-control" placeholder="请输入最高能出租金">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_lianxiren" class="col-md-2 text-right">联系人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wantHourseInfo_lianxiren" name="wantHourseInfo.lianxiren" class="form-control" placeholder="请输入联系人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wantHourseInfo_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wantHourseInfo_telephone" name="wantHourseInfo.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxWantHourseInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#wantHourseInfoAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加求租信息信息
	function ajaxWantHourseInfoAdd() { 
		//提交之前先验证表单
		$("#wantHourseInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#wantHourseInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "WantHourseInfo/add",
			dataType : "json" , 
			data: new FormData($("#wantHourseInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#wantHourseInfoAddForm").find("input").val("");
					$("#wantHourseInfoAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证求租信息添加表单字段
	$('#wantHourseInfoAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"wantHourseInfo.title": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"wantHourseInfo.price": {
				validators: {
					notEmpty: {
						message: "最高能出租金不能为空",
					},
					numeric: {
						message: "最高能出租金不正确"
					}
				}
			},
			"wantHourseInfo.lianxiren": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
			"wantHourseInfo.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
		}
	}); 
	//初始化求租用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#wantHourseInfo_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.realName + "</option>";
    		});
    		$("#wantHourseInfo_userObj_user_name").html(html);
    	}
	});
	//初始化求租区域下拉框值 
	$.ajax({
		url: basePath + "AreaInfo/listAll",
		type: "get",
		success: function(areaInfos,response,status) { 
			$("#wantHourseInfo_position_areaId").empty();
			var html="";
    		$(areaInfos).each(function(i,areaInfo){
    			html += "<option value='" + areaInfo.areaId + "'>" + areaInfo.areaName + "</option>";
    		});
    		$("#wantHourseInfo_position_areaId").html(html);
    	}
	});
	//初始化房屋类型下拉框值 
	$.ajax({
		url: basePath + "HourseType/listAll",
		type: "get",
		success: function(hourseTypes,response,status) { 
			$("#wantHourseInfo_hourseTypeObj_typeId").empty();
			var html="";
    		$(hourseTypes).each(function(i,hourseType){
    			html += "<option value='" + hourseType.typeId + "'>" + hourseType.typeName + "</option>";
    		});
    		$("#wantHourseInfo_hourseTypeObj_typeId").html(html);
    	}
	});
	//初始化价格范围下拉框值 
	$.ajax({
		url: basePath + "PriceRange/listAll",
		type: "get",
		success: function(priceRanges,response,status) { 
			$("#wantHourseInfo_priceRangeObj_rangeId").empty();
			var html="";
    		$(priceRanges).each(function(i,priceRange){
    			html += "<option value='" + priceRange.rangeId + "'>" + priceRange.priceName + "</option>";
    		});
    		$("#wantHourseInfo_priceRangeObj_rangeId").html(html);
    	}
	});
})
</script>
</body>
</html>
