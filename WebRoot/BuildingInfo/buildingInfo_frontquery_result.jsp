<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BuildingInfo" %>
<%@ page import="com.chengxusheji.po.AreaInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<BuildingInfo> buildingInfoList = (List<BuildingInfo>)request.getAttribute("buildingInfoList");
    //获取所有的areaObj信息
    List<AreaInfo> areaInfoList = (List<AreaInfo>)request.getAttribute("areaInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    AreaInfo areaObj = (AreaInfo)request.getAttribute("areaObj");
    String buildingName = (String)request.getAttribute("buildingName"); //楼盘名称查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>楼盘信息查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>BuildingInfo/frontlist">楼盘信息信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>BuildingInfo/buildingInfo_frontAdd.jsp" style="display:none;">添加楼盘信息</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<buildingInfoList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		BuildingInfo buildingInfo = buildingInfoList.get(i); //获取到楼盘信息对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>BuildingInfo/<%=buildingInfo.getBuildingId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=buildingInfo.getBuildingPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		楼盘编号:<%=buildingInfo.getBuildingId() %>
			     	</div>
			     	<div class="field">
	            		所在区域:<%=buildingInfo.getAreaObj().getAreaName() %>
			     	</div>
			     	<div class="field">
	            		楼盘名称:<%=buildingInfo.getBuildingName() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>BuildingInfo/<%=buildingInfo.getBuildingId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="buildingInfoEdit('<%=buildingInfo.getBuildingId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="buildingInfoDelete('<%=buildingInfo.getBuildingId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>楼盘信息查询</h1>
		</div>
		<form name="buildingInfoQueryForm" id="buildingInfoQueryForm" action="<%=basePath %>BuildingInfo/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="areaObj_areaId">所在区域：</label>
                <select id="areaObj_areaId" name="areaObj.areaId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(AreaInfo areaInfoTemp:areaInfoList) {
	 					String selected = "";
 					if(areaObj!=null && areaObj.getAreaId()!=null && areaObj.getAreaId().intValue()==areaInfoTemp.getAreaId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=areaInfoTemp.getAreaId() %>" <%=selected %>><%=areaInfoTemp.getAreaName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="buildingName">楼盘名称:</label>
				<input type="text" id="buildingName" name="buildingName" value="<%=buildingName %>" class="form-control" placeholder="请输入楼盘名称">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="buildingInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;楼盘信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="buildingInfoEditForm" id="buildingInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="buildingInfo_buildingId_edit" class="col-md-3 text-right">楼盘编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="buildingInfo_buildingId_edit" name="buildingInfo.buildingId" class="form-control" placeholder="请输入楼盘编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="buildingInfo_areaObj_areaId_edit" class="col-md-3 text-right">所在区域:</label>
		  	 <div class="col-md-9">
			    <select id="buildingInfo_areaObj_areaId_edit" name="buildingInfo.areaObj.areaId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="buildingInfo_buildingName_edit" class="col-md-3 text-right">楼盘名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="buildingInfo_buildingName_edit" name="buildingInfo.buildingName" class="form-control" placeholder="请输入楼盘名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="buildingInfo_buildingPhoto_edit" class="col-md-3 text-right">楼盘图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="buildingInfo_buildingPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="buildingInfo_buildingPhoto" name="buildingInfo.buildingPhoto"/>
			    <input id="buildingPhotoFile" name="buildingPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		</form> 
	    <style>#buildingInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxBuildingInfoModify();">提交</button>
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
    document.buildingInfoQueryForm.currentPage.value = currentPage;
    document.buildingInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.buildingInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.buildingInfoQueryForm.currentPage.value = pageValue;
    documentbuildingInfoQueryForm.submit();
}

/*弹出修改楼盘信息界面并初始化数据*/
function buildingInfoEdit(buildingId) {
	$.ajax({
		url :  basePath + "BuildingInfo/" + buildingId + "/update",
		type : "get",
		dataType: "json",
		success : function (buildingInfo, response, status) {
			if (buildingInfo) {
				$("#buildingInfo_buildingId_edit").val(buildingInfo.buildingId);
				$.ajax({
					url: basePath + "AreaInfo/listAll",
					type: "get",
					success: function(areaInfos,response,status) { 
						$("#buildingInfo_areaObj_areaId_edit").empty();
						var html="";
		        		$(areaInfos).each(function(i,areaInfo){
		        			html += "<option value='" + areaInfo.areaId + "'>" + areaInfo.areaName + "</option>";
		        		});
		        		$("#buildingInfo_areaObj_areaId_edit").html(html);
		        		$("#buildingInfo_areaObj_areaId_edit").val(buildingInfo.areaObjPri);
					}
				});
				$("#buildingInfo_buildingName_edit").val(buildingInfo.buildingName);
				$("#buildingInfo_buildingPhoto").val(buildingInfo.buildingPhoto);
				$("#buildingInfo_buildingPhotoImg").attr("src", basePath +　buildingInfo.buildingPhoto);
				$('#buildingInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除楼盘信息信息*/
function buildingInfoDelete(buildingId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "BuildingInfo/deletes",
			data : {
				buildingIds : buildingId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#buildingInfoQueryForm").submit();
					//location.href= basePath + "BuildingInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交楼盘信息信息表单给服务器端修改*/
function ajaxBuildingInfoModify() {
	$.ajax({
		url :  basePath + "BuildingInfo/" + $("#buildingInfo_buildingId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#buildingInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#buildingInfoQueryForm").submit();
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

