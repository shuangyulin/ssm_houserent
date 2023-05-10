package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.WantHourseInfo;

public interface WantHourseInfoMapper {
	/*添加求租信息信息*/
	public void addWantHourseInfo(WantHourseInfo wantHourseInfo) throws Exception;

	/*按照查询条件分页查询求租信息记录*/
	public ArrayList<WantHourseInfo> queryWantHourseInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有求租信息记录*/
	public ArrayList<WantHourseInfo> queryWantHourseInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的求租信息记录数*/
	public int queryWantHourseInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条求租信息记录*/
	public WantHourseInfo getWantHourseInfo(int wantHourseId) throws Exception;

	/*更新求租信息记录*/
	public void updateWantHourseInfo(WantHourseInfo wantHourseInfo) throws Exception;

	/*删除求租信息记录*/
	public void deleteWantHourseInfo(int wantHourseId) throws Exception;

}
