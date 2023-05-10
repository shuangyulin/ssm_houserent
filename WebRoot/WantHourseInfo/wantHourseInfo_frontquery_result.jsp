<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.WantHourseInfo" %>
<%@ page import="com.chengxusheji.po.AreaInfo" %>
<%@ page import="com.chengxusheji.po.HourseType" %>
<%@ page import="com.chengxusheji.po.PriceRange" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<WantHourseInfo> wantHourseInfoList = (List<WantHourseInfo>)request.getAttribute("wantHourseInfoList");
    //获取所有的position信息
    List<AreaInfo> areaInfoList = (List<AreaInfo>)request.getAttribute("areaInfoList");
    //获取所有的hourseTypeObj信息
    List<HourseType> hourseTypeList = (List<HourseType>)request.getAttribute("hourseTypeList");
    //获取所有的priceRangeObj信息
    List<PriceRange> priceRangeList = (List<PriceRange>)request.getAttribute("priceRangeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String title = (String)request.getAttribute("title"); //标题查询关键字
    AreaInfo position = (AreaInfo)request.getAttribute("position");
    HourseType hourseTypeObj = (HourseType)request.getAttribute("hourseTypeObj");
    PriceRange priceRangeObj = (PriceRange)request.getAttribute("priceRangeObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>求租信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#wantHourseInfoListPanel" aria-controls="wantHourseInfoListPanel" role="tab" data-toggle="tab">求租信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>WantHourseInfo/wantHourseInfo_frontAdd.jsp" style="display:none;">添加求租信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="wantHourseInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>求租用户</td><td>标题</td><td>求租区域</td><td>房屋类型</td><td>价格范围</td><td>最高能出租金</td><td>联系人</td><td>联系电话</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<wantHourseInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		WantHourseInfo wantHourseInfo = wantHourseInfoList.get(i); //获取到求租信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=wantHourseInfo.getUserObj().getRealName() %></td>
 											<td><%=wantHourseInfo.getTitle() %></td>
 											<td><%=wantHourseInfo.getPosition().getAreaName() %></td>
 											<td><%=wantHourseInfo.getHourseTypeObj().getTypeName() %></td>
 											<td><%=wantHourseInfo.getPriceRangeObj().getPriceName() %></td>
 											<td><%=wantHourseInfo.getPrice() %></td>
 											<td><%=wantHourseInfo.getLianxiren() %></td>
 											<td><%=wantHourseInfo.getTelephone() %></td>
 											<td>
 												<a href="<%=basePath  %>WantHourseInfo/<%=wantHourseInfo.getWantHourseId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="wantHourseInfoEdit('<%=wantHourseInfo.getWantHourseId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="wantHourseInfoDelete('<%=wantHourseInfo.getWantHourseId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>求租信息查询</h1>
		</div>
		<form name="wantHourseInfoQueryForm" id="wantHourseInfoQueryForm" action="<%=basePath %>WantHourseInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="userObj_user_name">求租用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getRealName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="title">标题:</label>
				<input type="text" id="title" name="title" value="<%=title %>" class="form-control" placeholder="请输入标题">
			</div>






            <div class="form-group">
            	<label for="position_areaId">求租区域：</label>
                <select id="position_areaId" name="position.areaId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(AreaInfo areaInfoTemp:areaInfoList) {
	 					String selected = "";
 					if(position!=null && position.getAreaId()!=null && position.getAreaId().intValue()==areaInfoTemp.getAreaId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=areaInfoTemp.getAreaId() %>" <%=selected %>><%=areaInfoTemp.getAreaName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="hourseTypeObj_typeId">房屋类型：</label>
                <select id="hourseTypeObj_typeId" name="hourseTypeObj.typeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(HourseType hourseTypeTemp:hourseTypeList) {
	 					String selected = "";
 					if(hourseTypeObj!=null && hourseTypeObj.getTypeId()!=null && hourseTypeObj.getTypeId().intValue()==hourseTypeTemp.getTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=hourseTypeTemp.getTypeId() %>" <%=selected %>><%=hourseTypeTemp.getTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="priceRangeObj_rangeId">价格范围：</label>
                <select id="priceRangeObj_rangeId" name="priceRangeObj.rangeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(PriceRange priceRangeTemp:priceRangeList) {
	 					String selected = "";
 					if(priceRangeObj!=null && priceRangeObj.getRangeId()!=null && priceRangeObj.getRangeId().intValue()==priceRangeTemp.getRangeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=priceRangeTemp.getRangeId() %>" <%=selected %>><%=priceRangeTemp.getPriceName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="wantHourseInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;求租信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#wantHourseInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxWantHourseInfoModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.wantHourseInfoQueryForm.currentPage.value = currentPage;
    document.wantHourseInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.wantHourseInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.wantHourseInfoQueryForm.currentPage.value = pageValue;
    documentwantHourseInfoQueryForm.submit();
}

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
				$('#wantHourseInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除求租信息信息*/
function wantHourseInfoDelete(wantHourseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "WantHourseInfo/deletes",
			data : {
				wantHourseIds : wantHourseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#wantHourseInfoQueryForm").submit();
					//location.href= basePath + "WantHourseInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

