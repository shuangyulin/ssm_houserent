package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BuildingInfo;

public interface BuildingInfoMapper {
	/*添加楼盘信息信息*/
	public void addBuildingInfo(BuildingInfo buildingInfo) throws Exception;

	/*按照查询条件分页查询楼盘信息记录*/
	public ArrayList<BuildingInfo> queryBuildingInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有楼盘信息记录*/
	public ArrayList<BuildingInfo> queryBuildingInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的楼盘信息记录数*/
	public int queryBuildingInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条楼盘信息记录*/
	public BuildingInfo getBuildingInfo(int buildingId) throws Exception;

	/*更新楼盘信息记录*/
	public void updateBuildingInfo(BuildingInfo buildingInfo) throws Exception;

	/*删除楼盘信息记录*/
	public void deleteBuildingInfo(int buildingId) throws Exception;

}
