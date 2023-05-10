<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hourseType.css" />
<div id="hourseType_editDiv">
	<form id="hourseTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourseType_typeId_edit" name="hourseType.typeId" value="<%=request.getParameter("typeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">房屋类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourseType_typeName_edit" name="hourseType.typeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="hourseTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/HourseType/js/hourseType_modify.js"></script> 
