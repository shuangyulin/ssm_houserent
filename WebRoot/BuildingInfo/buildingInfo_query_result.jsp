<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/buildingInfo.css" /> 

<div id="buildingInfo_manage"></div>
<div id="buildingInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="buildingInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="buildingInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="buildingInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="buildingInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="buildingInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="buildingInfoQueryForm" method="post">
			所在区域：<input class="textbox" type="text" id="areaObj_areaId_query" name="areaObj.areaId" style="width: auto"/>
			楼盘名称：<input type="text" class="textbox" id="buildingName" name="buildingName" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="buildingInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="buildingInfoEditDiv">
	<form id="buildingInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">楼盘编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="buildingInfo_buildingId_edit" name="buildingInfo.buildingId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="BuildingInfo/js/buildingInfo_manage.js"></script> 
