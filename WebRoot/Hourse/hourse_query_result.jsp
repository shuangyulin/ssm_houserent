<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hourse.css" /> 

<div id="hourse_manage"></div>
<div id="hourse_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="hourse_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="hourse_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="hourse_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="hourse_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="hourse_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="hourseQueryForm" method="post">
			房屋名称：<input type="text" class="textbox" id="hourseName" name="hourseName" style="width:110px" />
			所在楼盘：<input class="textbox" type="text" id="buildingObj_buildingId_query" name="buildingObj.buildingId" style="width: auto"/>
			房屋类型：<input class="textbox" type="text" id="hourseTypeObj_typeId_query" name="hourseTypeObj.typeId" style="width: auto"/>
			价格范围：<input class="textbox" type="text" id="priceRangeObj_rangeId_query" name="priceRangeObj.rangeId" style="width: auto"/>
			建筑年代：<input type="text" class="textbox" id="madeYear" name="madeYear" style="width:110px" />
			联系人：<input type="text" class="textbox" id="connectPerson" name="connectPerson" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="connectPhone" name="connectPhone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="hourse_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="hourseEditDiv">
	<form id="hourseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">房屋编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_hourseId_edit" name="hourse.hourseId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">房屋名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_hourseName_edit" name="hourse.hourseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在楼盘:</span>
			<span class="inputControl">
				<input class="textbox"  id="hourse_buildingObj_buildingId_edit" name="hourse.buildingObj.buildingId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">房屋图片:</span>
			<span class="inputControl">
				<img id="hourse_housePhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="hourse_housePhoto" name="hourse.housePhoto"/>
				<input id="housePhotoFile" name="housePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">房屋类型:</span>
			<span class="inputControl">
				<input class="textbox"  id="hourse_hourseTypeObj_typeId_edit" name="hourse.hourseTypeObj.typeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">价格范围:</span>
			<span class="inputControl">
				<input class="textbox"  id="hourse_priceRangeObj_rangeId_edit" name="hourse.priceRangeObj.rangeId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">面积:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_area_edit" name="hourse.area" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">租金(元/月):</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_price_edit" name="hourse.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">楼层/总楼层:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_louceng_edit" name="hourse.louceng" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">装修:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_zhuangxiu_edit" name="hourse.zhuangxiu" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">朝向:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_caoxiang_edit" name="hourse.caoxiang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">建筑年代:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_madeYear_edit" name="hourse.madeYear" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_connectPerson_edit" name="hourse.connectPerson" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_connectPhone_edit" name="hourse.connectPhone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">详细信息:</span>
			<span class="inputControl">
				<textarea id="hourse_detail_edit" name="hourse.detail" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="hourse_address_edit" name="hourse.address" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Hourse/js/hourse_manage.js"></script> 
