package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.HourseType;

public interface HourseTypeMapper {
	/*添加房屋类别信息*/
	public void addHourseType(HourseType hourseType) throws Exception;

	/*按照查询条件分页查询房屋类别记录*/
	public ArrayList<HourseType> queryHourseType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房屋类别记录*/
	public ArrayList<HourseType> queryHourseTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的房屋类别记录数*/
	public int queryHourseTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房屋类别记录*/
	public HourseType getHourseType(int typeId) throws Exception;

	/*更新房屋类别记录*/
	public void updateHourseType(HourseType hourseType) throws Exception;

	/*删除房屋类别记录*/
	public void deleteHourseType(int typeId) throws Exception;

}
