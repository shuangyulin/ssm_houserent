<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wantHourseInfo.css" />
<div id="wantHourseInfo_editDiv">
	<form id="wantHourseInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_wantHourseId_edit" name="wantHourseInfo.wantHourseId" value="<%=request.getParameter("wantHourseId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">求租用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="wantHourseInfo_userObj_user_name_edit" name="wantHourseInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_title_edit" name="wantHourseInfo.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">求租区域:</span>
			<span class="inputControl">
				<input class="textbox"  id="wantHourseInfo_position_areaId_edit" name="wantHourseInfo.position.areaId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房屋类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="wantHourseInfo_hourseTypeObj_typeId_edit" name="wantHourseInfo.hourseTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">价格范围:</span>
			<span class="inputControl">
				<input class="textbox"  id="wantHourseInfo_priceRangeObj_rangeId_edit" name="wantHourseInfo.priceRangeObj.rangeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">最高能出租金:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_price_edit" name="wantHourseInfo.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_lianxiren_edit" name="wantHourseInfo.lianxiren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_telephone_edit" name="wantHourseInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="wantHourseInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/WantHourseInfo/js/wantHourseInfo_modify.js"></script> 
