<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BuildingInfo" %>
<%@ page import="com.chengxusheji.po.HourseType" %>
<%@ page import="com.chengxusheji.po.PriceRange" %>
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
<title>房屋信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Hourse/frontlist">房屋信息管理</a></li>
  			<li class="active">添加房屋信息</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="hourseAddForm" id="hourseAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="hourse_hourseName" class="col-md-2 text-right">房屋名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_hourseName" name="hourse.hourseName" class="form-control" placeholder="请输入房屋名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_buildingObj_buildingId" class="col-md-2 text-right">所在楼盘:</label>
				  	 <div class="col-md-8">
					    <select id="hourse_buildingObj_buildingId" name="hourse.buildingObj.buildingId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_housePhoto" class="col-md-2 text-right">房屋图片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="hourse_housePhotoImg" border="0px"/><br/>
					    <input type="hidden" id="hourse_housePhoto" name="hourse.housePhoto"/>
					    <input id="housePhotoFile" name="housePhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_hourseTypeObj_typeId" class="col-md-2 text-right">房屋类型:</label>
				  	 <div class="col-md-8">
					    <select id="hourse_hourseTypeObj_typeId" name="hourse.hourseTypeObj.typeId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_priceRangeObj_rangeId" class="col-md-2 text-right">价格范围:</label>
				  	 <div class="col-md-8">
					    <select id="hourse_priceRangeObj_rangeId" name="hourse.priceRangeObj.rangeId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_area" class="col-md-2 text-right">面积:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_area" name="hourse.area" class="form-control" placeholder="请输入面积">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_price" class="col-md-2 text-right">租金(元/月):</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_price" name="hourse.price" class="form-control" placeholder="请输入租金(元/月)">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_louceng" class="col-md-2 text-right">楼层/总楼层:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_louceng" name="hourse.louceng" class="form-control" placeholder="请输入楼层/总楼层">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_zhuangxiu" class="col-md-2 text-right">装修:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_zhuangxiu" name="hourse.zhuangxiu" class="form-control" placeholder="请输入装修">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_caoxiang" class="col-md-2 text-right">朝向:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_caoxiang" name="hourse.caoxiang" class="form-control" placeholder="请输入朝向">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_madeYear" class="col-md-2 text-right">建筑年代:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_madeYear" name="hourse.madeYear" class="form-control" placeholder="请输入建筑年代">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_connectPerson" class="col-md-2 text-right">联系人:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_connectPerson" name="hourse.connectPerson" class="form-control" placeholder="请输入联系人">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_connectPhone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_connectPhone" name="hourse.connectPhone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_detail" class="col-md-2 text-right">详细信息:</label>
				  	 <div class="col-md-8">
					    <textarea id="hourse_detail" name="hourse.detail" rows="8" class="form-control" placeholder="请输入详细信息"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="hourse_address" class="col-md-2 text-right">地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="hourse_address" name="hourse.address" class="form-control" placeholder="请输入地址">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxHourseAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#hourseAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//提交添加房屋信息信息
	function ajaxHourseAdd() { 
		//提交之前先验证表单
		$("#hourseAddForm").data('bootstrapValidator').validate();
		if(!$("#hourseAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Hourse/add",
			dataType : "json" , 
			data: new FormData($("#hourseAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#hourseAddForm").find("input").val("");
					$("#hourseAddForm").find("textarea").val("");
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
	//验证房屋信息添加表单字段
	$('#hourseAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"hourse.hourseName": {
				validators: {
					notEmpty: {
						message: "房屋名称不能为空",
					}
				}
			},
			"hourse.area": {
				validators: {
					notEmpty: {
						message: "面积不能为空",
					}
				}
			},
			"hourse.price": {
				validators: {
					notEmpty: {
						message: "租金(元/月)不能为空",
					},
					numeric: {
						message: "租金(元/月)不正确"
					}
				}
			},
			"hourse.louceng": {
				validators: {
					notEmpty: {
						message: "楼层/总楼层不能为空",
					}
				}
			},
			"hourse.zhuangxiu": {
				validators: {
					notEmpty: {
						message: "装修不能为空",
					}
				}
			},
			"hourse.connectPerson": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
			"hourse.connectPhone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
		}
	}); 
	//初始化所在楼盘下拉框值 
	$.ajax({
		url: basePath + "BuildingInfo/listAll",
		type: "get",
		success: function(buildingInfos,response,status) { 
			$("#hourse_buildingObj_buildingId").empty();
			var html="";
    		$(buildingInfos).each(function(i,buildingInfo){
    			html += "<option value='" + buildingInfo.buildingId + "'>" + buildingInfo.buildingName + "</option>";
    		});
    		$("#hourse_buildingObj_buildingId").html(html);
    	}
	});
	//初始化房屋类型下拉框值 
	$.ajax({
		url: basePath + "HourseType/listAll",
		type: "get",
		success: function(hourseTypes,response,status) { 
			$("#hourse_hourseTypeObj_typeId").empty();
			var html="";
    		$(hourseTypes).each(function(i,hourseType){
    			html += "<option value='" + hourseType.typeId + "'>" + hourseType.typeName + "</option>";
    		});
    		$("#hourse_hourseTypeObj_typeId").html(html);
    	}
	});
	//初始化价格范围下拉框值 
	$.ajax({
		url: basePath + "PriceRange/listAll",
		type: "get",
		success: function(priceRanges,response,status) { 
			$("#hourse_priceRangeObj_rangeId").empty();
			var html="";
    		$(priceRanges).each(function(i,priceRange){
    			html += "<option value='" + priceRange.rangeId + "'>" + priceRange.priceName + "</option>";
    		});
    		$("#hourse_priceRangeObj_rangeId").html(html);
    	}
	});
})
</script>
</body>
</html>
