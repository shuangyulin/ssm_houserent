package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Hourse;

public interface HourseMapper {
	/*添加房屋信息信息*/
	public void addHourse(Hourse hourse) throws Exception;

	/*按照查询条件分页查询房屋信息记录*/
	public ArrayList<Hourse> queryHourse(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房屋信息记录*/
	public ArrayList<Hourse> queryHourseList(@Param("where") String where) throws Exception;

	/*按照查询条件的房屋信息记录数*/
	public int queryHourseCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房屋信息记录*/
	public Hourse getHourse(int hourseId) throws Exception;

	/*更新房屋信息记录*/
	public void updateHourse(Hourse hourse) throws Exception;

	/*删除房屋信息记录*/
	public void deleteHourse(int hourseId) throws Exception;

}
