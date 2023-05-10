<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wantHourseInfo.css" />
<div id="wantHourseInfoAddDiv">
	<form id="wantHourseInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">求租用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_userObj_user_name" name="wantHourseInfo.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_title" name="wantHourseInfo.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">求租区域:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_position_areaId" name="wantHourseInfo.position.areaId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房屋类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_hourseTypeObj_typeId" name="wantHourseInfo.hourseTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">价格范围:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_priceRangeObj_rangeId" name="wantHourseInfo.priceRangeObj.rangeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">最高能出租金:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_price" name="wantHourseInfo.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_lianxiren" name="wantHourseInfo.lianxiren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_telephone" name="wantHourseInfo.telephone" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="wantHourseInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="wantHourseInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/WantHourseInfo/js/wantHourseInfo_add.js"></script> 
