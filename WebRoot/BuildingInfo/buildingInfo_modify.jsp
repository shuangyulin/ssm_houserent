<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/buildingInfo.css" />
<div id="buildingInfo_editDiv">
	<form id="buildingInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">楼盘编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="buildingInfo_buildingId_edit" name="buildingInfo.buildingId" value="<%=request.getParameter("buildingId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">所在区域:</span>
			<span class="inputControl">
				<input class="textbox"  id="buildingInfo_areaObj_areaId_edit" name="buildingInfo.areaObj.areaId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">楼盘名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="buildingInfo_buildingName_edit" name="buildingInfo.buildingName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">楼盘图片:</span>
			<span class="inputControl">
				<img id="buildingInfo_buildingPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="buildingInfo_buildingPhoto" name="buildingInfo.buildingPhoto"/>
				<input id="buildingPhotoFile" name="buildingPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div class="operation">
			<a id="buildingInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BuildingInfo/js/buildingInfo_modify.js"></script> 
