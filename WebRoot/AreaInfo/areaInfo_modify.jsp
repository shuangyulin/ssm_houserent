<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/areaInfo.css" />
<div id="areaInfo_editDiv">
	<form id="areaInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="areaInfo_areaId_edit" name="areaInfo.areaId" value="<%=request.getParameter("areaId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">区域名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="areaInfo_areaName_edit" name="areaInfo.areaName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="areaInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/AreaInfo/js/areaInfo_modify.js"></script> 
