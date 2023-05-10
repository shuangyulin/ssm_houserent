<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.WantHourseInfo" %>
<%@ page import="com.chengxusheji.po.AreaInfo" %>
<%@ page import="com.chengxusheji.po.HourseType" %>
<%@ page import="com.chengxusheji.po.PriceRange" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的position信息
    List<AreaInfo> areaInfoList = (List<AreaInfo>)request.getAttribute("areaInfoList");
    //获取所有的hourseTypeObj信息
    List<HourseType> hourseTypeList = (List<HourseType>)request.getAttribute("hourseTypeList");
    //获取所有的priceRangeObj信息
    List<PriceRange> priceRangeList = (List<PriceRange>)request.getAttribute("priceRangeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    WantHourseInfo wantHourseInfo = (WantHourseInfo)request.getAttribute("wantHourseInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改求租信息信息</TITLE>
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
  		<li class="active">求租信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="wantHourseInfoEditForm" id="wantHourseInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="wantHourseInfo_wantHourseId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="wantHourseInfo_wantHourseId_edit" name="wantHourseInfo.wantHourseId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="wantHourseInfo_userObj_user_name_edit" class="col-md-3 text-right">求租用户:</label>
		  	 <div class="col-md-9">
			    <select id="wantHourseInfo_userObj_user_name_edit" name="wantHourseInfo.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_title_edit" class="col-md-3 text-right">标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wantHourseInfo_title_edit" name="wantHourseInfo.title" class="form-control" placeholder="请输入标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_position_areaId_edit" class="col-md-3 text-right">求租区域:</label>
		  	 <div class="col-md-9">
			    <select id="wantHourseInfo_position_areaId_edit" name="wantHourseInfo.position.areaId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_hourseTypeObj_typeId_edit" class="col-md-3 text-right">房屋类型:</label>
		  	 <div class="col-md-9">
			    <select id="wantHourseInfo_hourseTypeObj_typeId_edit" name="wantHourseInfo.hourseTypeObj.typeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_priceRangeObj_rangeId_edit" class="col-md-3 text-right">价格范围:</label>
		  	 <div class="col-md-9">
			    <select id="wantHourseInfo_priceRangeObj_rangeId_edit" name="wantHourseInfo.priceRangeObj.rangeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_price_edit" class="col-md-3 text-right">最高能出租金:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wantHourseInfo_price_edit" name="wantHourseInfo.price" class="form-control" placeholder="请输入最高能出租金">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_lianxiren_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wantHourseInfo_lianxiren_edit" name="wantHourseInfo.lianxiren" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wantHourseInfo_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wantHourseInfo_telephone_edit" name="wantHourseInfo.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxWantHourseInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#wantHourseInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改求租信息界面并初始化数据*/
function wantHourseInfoEdit(wantHourseId) {
	$.ajax({
		url :  basePath + "WantHourseInfo/" + wantHourseId + "/update",
		type : "get",
		dataType: "json",
		success : function (wantHourseInfo, response, status) {
			if (wantHourseInfo) {
				$("#wantHourseInfo_wantHourseId_edit").val(wantHourseInfo.wantHourseId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#wantHourseInfo_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.realName + "</option>";
		        		});
		        		$("#wantHourseInfo_userObj_user_name_edit").html(html);
		        		$("#wantHourseInfo_userObj_user_name_edit").val(wantHourseInfo.userObjPri);
					}
				});
				$("#wantHourseInfo_title_edit").val(wantHourseInfo.title);
				$.ajax({
					url: basePath + "AreaInfo/listAll",
					type: "get",
					success: function(areaInfos,response,status) { 
						$("#wantHourseInfo_position_areaId_edit").empty();
						var html="";
		        		$(areaInfos).each(function(i,areaInfo){
		        			html += "<option value='" + areaInfo.areaId + "'>" + areaInfo.areaName + "</option>";
		        		});
		        		$("#wantHourseInfo_position_areaId_edit").html(html);
		        		$("#wantHourseInfo_position_areaId_edit").val(wantHourseInfo.positionPri);
					}
				});
				$.ajax({
					url: basePath + "HourseType/listAll",
					type: "get",
					success: function(hourseTypes,response,status) { 
						$("#wantHourseInfo_hourseTypeObj_typeId_edit").empty();
						var html="";
		        		$(hourseTypes).each(function(i,hourseType){
		        			html += "<option value='" + hourseType.typeId + "'>" + hourseType.typeName + "</option>";
		        		});
		        		$("#wantHourseInfo_hourseTypeObj_typeId_edit").html(html);
		        		$("#wantHourseInfo_hourseTypeObj_typeId_edit").val(wantHourseInfo.hourseTypeObjPri);
					}
				});
				$.ajax({
					url: basePath + "PriceRange/listAll",
					type: "get",
					success: function(priceRanges,response,status) { 
						$("#wantHourseInfo_priceRangeObj_rangeId_edit").empty();
						var html="";
		        		$(priceRanges).each(function(i,priceRange){
		        			html += "<option value='" + priceRange.rangeId + "'>" + priceRange.priceName + "</option>";
		        		});
		        		$("#wantHourseInfo_priceRangeObj_rangeId_edit").html(html);
		        		$("#wantHourseInfo_priceRangeObj_rangeId_edit").val(wantHourseInfo.priceRangeObjPri);
					}
				});
				$("#wantHourseInfo_price_edit").val(wantHourseInfo.price);
				$("#wantHourseInfo_lianxiren_edit").val(wantHourseInfo.lianxiren);
				$("#wantHourseInfo_telephone_edit").val(wantHourseInfo.telephone);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交求租信息信息表单给服务器端修改*/
function ajaxWantHourseInfoModify() {
	$.ajax({
		url :  basePath + "WantHourseInfo/" + $("#wantHourseInfo_wantHourseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#wantHourseInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#wantHourseInfoQueryForm").submit();
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
    wantHourseInfoEdit("<%=request.getParameter("wantHourseId")%>");
 })
 </script> 
</body>
</html>

