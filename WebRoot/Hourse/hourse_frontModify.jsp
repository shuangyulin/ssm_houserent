<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Hourse" %>
<%@ page import="com.chengxusheji.po.BuildingInfo" %>
<%@ page import="com.chengxusheji.po.HourseType" %>
<%@ page import="com.chengxusheji.po.PriceRange" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的buildingObj信息
    List<BuildingInfo> buildingInfoList = (List<BuildingInfo>)request.getAttribute("buildingInfoList");
    //获取所有的hourseTypeObj信息
    List<HourseType> hourseTypeList = (List<HourseType>)request.getAttribute("hourseTypeList");
    //获取所有的priceRangeObj信息
    List<PriceRange> priceRangeList = (List<PriceRange>)request.getAttribute("priceRangeList");
    Hourse hourse = (Hourse)request.getAttribute("hourse");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改房屋信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">房屋信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="hourseEditForm" id="hourseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="hourse_hourseId_edit" class="col-md-3 text-right">房屋编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="hourse_hourseId_edit" name="hourse.hourseId" class="form-control" placeholder="请输入房屋编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="hourse_hourseName_edit" class="col-md-3 text-right">房屋名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_hourseName_edit" name="hourse.hourseName" class="form-control" placeholder="请输入房屋名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_buildingObj_buildingId_edit" class="col-md-3 text-right">所在楼盘:</label>
		  	 <div class="col-md-9">
			    <select id="hourse_buildingObj_buildingId_edit" name="hourse.buildingObj.buildingId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_housePhoto_edit" class="col-md-3 text-right">房屋图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="hourse_housePhotoImg" border="0px"/><br/>
			    <input type="hidden" id="hourse_housePhoto" name="hourse.housePhoto"/>
			    <input id="housePhotoFile" name="housePhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_hourseTypeObj_typeId_edit" class="col-md-3 text-right">房屋类型:</label>
		  	 <div class="col-md-9">
			    <select id="hourse_hourseTypeObj_typeId_edit" name="hourse.hourseTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_priceRangeObj_rangeId_edit" class="col-md-3 text-right">价格范围:</label>
		  	 <div class="col-md-9">
			    <select id="hourse_priceRangeObj_rangeId_edit" name="hourse.priceRangeObj.rangeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_area_edit" class="col-md-3 text-right">面积:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_area_edit" name="hourse.area" class="form-control" placeholder="请输入面积">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_price_edit" class="col-md-3 text-right">租金(元/月):</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_price_edit" name="hourse.price" class="form-control" placeholder="请输入租金(元/月)">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_louceng_edit" class="col-md-3 text-right">楼层/总楼层:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_louceng_edit" name="hourse.louceng" class="form-control" placeholder="请输入楼层/总楼层">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_zhuangxiu_edit" class="col-md-3 text-right">装修:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_zhuangxiu_edit" name="hourse.zhuangxiu" class="form-control" placeholder="请输入装修">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_caoxiang_edit" class="col-md-3 text-right">朝向:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_caoxiang_edit" name="hourse.caoxiang" class="form-control" placeholder="请输入朝向">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_madeYear_edit" class="col-md-3 text-right">建筑年代:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_madeYear_edit" name="hourse.madeYear" class="form-control" placeholder="请输入建筑年代">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_connectPerson_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_connectPerson_edit" name="hourse.connectPerson" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_connectPhone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_connectPhone_edit" name="hourse.connectPhone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_detail_edit" class="col-md-3 text-right">详细信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="hourse_detail_edit" name="hourse.detail" rows="8" class="form-control" placeholder="请输入详细信息"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="hourse_address_edit" class="col-md-3 text-right">地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="hourse_address_edit" name="hourse.address" class="form-control" placeholder="请输入地址">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxHourseModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#hourseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改房屋信息界面并初始化数据*/
function hourseEdit(hourseId) {
	$.ajax({
		url :  basePath + "Hourse/" + hourseId + "/update",
		type : "get",
		dataType: "json",
		success : function (hourse, response, status) {
			if (hourse) {
				$("#hourse_hourseId_edit").val(hourse.hourseId);
				$("#hourse_hourseName_edit").val(hourse.hourseName);
				$.ajax({
					url: basePath + "BuildingInfo/listAll",
					type: "get",
					success: function(buildingInfos,response,status) { 
						$("#hourse_buildingObj_buildingId_edit").empty();
						var html="";
		        		$(buildingInfos).each(function(i,buildingInfo){
		        			html += "<option value='" + buildingInfo.buildingId + "'>" + buildingInfo.buildingName + "</option>";
		        		});
		        		$("#hourse_buildingObj_buildingId_edit").html(html);
		        		$("#hourse_buildingObj_buildingId_edit").val(hourse.buildingObjPri);
					}
				});
				$("#hourse_housePhoto").val(hourse.housePhoto);
				$("#hourse_housePhotoImg").attr("src", basePath +　hourse.housePhoto);
				$.ajax({
					url: basePath + "HourseType/listAll",
					type: "get",
					success: function(hourseTypes,response,status) { 
						$("#hourse_hourseTypeObj_typeId_edit").empty();
						var html="";
		        		$(hourseTypes).each(function(i,hourseType){
		        			html += "<option value='" + hourseType.typeId + "'>" + hourseType.typeName + "</option>";
		        		});
		        		$("#hourse_hourseTypeObj_typeId_edit").html(html);
		        		$("#hourse_hourseTypeObj_typeId_edit").val(hourse.hourseTypeObjPri);
					}
				});
				$.ajax({
					url: basePath + "PriceRange/listAll",
					type: "get",
					success: function(priceRanges,response,status) { 
						$("#hourse_priceRangeObj_rangeId_edit").empty();
						var html="";
		        		$(priceRanges).each(function(i,priceRange){
		        			html += "<option value='" + priceRange.rangeId + "'>" + priceRange.priceName + "</option>";
		        		});
		        		$("#hourse_priceRangeObj_rangeId_edit").html(html);
		        		$("#hourse_priceRangeObj_rangeId_edit").val(hourse.priceRangeObjPri);
					}
				});
				$("#hourse_area_edit").val(hourse.area);
				$("#hourse_price_edit").val(hourse.price);
				$("#hourse_louceng_edit").val(hourse.louceng);
				$("#hourse_zhuangxiu_edit").val(hourse.zhuangxiu);
				$("#hourse_caoxiang_edit").val(hourse.caoxiang);
				$("#hourse_madeYear_edit").val(hourse.madeYear);
				$("#hourse_connectPerson_edit").val(hourse.connectPerson);
				$("#hourse_connectPhone_edit").val(hourse.connectPhone);
				$("#hourse_detail_edit").val(hourse.detail);
				$("#hourse_address_edit").val(hourse.address);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交房屋信息信息表单给服务器端修改*/
function ajaxHourseModify() {
	$.ajax({
		url :  basePath + "Hourse/" + $("#hourse_hourseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#hourseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#hourseQueryForm").submit();
            }else{
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
    hourseEdit("<%=request.getParameter("hourseId")%>");
 })
 </script> 
</body>
</html>

