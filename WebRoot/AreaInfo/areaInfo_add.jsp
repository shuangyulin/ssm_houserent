<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/areaInfo.css" />
<div id="areaInfoAddDiv">
	<form id="areaInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">区域名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="areaInfo_areaName" name="areaInfo.areaName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="areaInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="areaInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/AreaInfo/js/areaInfo_add.js"></script> 
