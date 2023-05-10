<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wantHourseInfo.css" /> 

<div id="wantHourseInfo_manage"></div>
<div id="wantHourseInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="wantHourseInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="wantHourseInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="wantHourseInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="wantHourseInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="wantHourseInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="wantHourseInfoQueryForm" method="post">
			求租用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			求租区域：<input class="textbox" type="text" id="position_areaId_query" name="position.areaId" style="width: auto"/>
			房屋类型：<input class="textbox" type="text" id="hourseTypeObj_typeId_query" name="hourseTypeObj.typeId" style="width: auto"/>
			价格范围：<input class="textbox" type="text" id="priceRangeObj_rangeId_query" name="priceRangeObj.rangeId" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="wantHourseInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="wantHourseInfoEditDiv">
	<form id="wantHourseInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wantHourseInfo_wantHourseId_edit" name="wantHourseInfo.wantHourseId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="WantHourseInfo/js/wantHourseInfo_manage.js"></script> 
