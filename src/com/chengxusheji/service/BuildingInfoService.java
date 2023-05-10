package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.AreaInfo;
import com.chengxusheji.po.BuildingInfo;

import com.chengxusheji.mapper.BuildingInfoMapper;
@Service
public class BuildingInfoService {

	@Resource BuildingInfoMapper buildingInfoMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加楼盘信息记录*/
    public void addBuildingInfo(BuildingInfo buildingInfo) throws Exception {
    	buildingInfoMapper.addBuildingInfo(buildingInfo);
    }

    /*按照查询条件分页查询楼盘信息记录*/
    public ArrayList<BuildingInfo> queryBuildingInfo(AreaInfo areaObj,String buildingName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_buildingInfo.areaObj=" + areaObj.getAreaId();
    	if(!buildingName.equals("")) where = where + " and t_buildingInfo.buildingName like '%" + buildingName + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return buildingInfoMapper.queryBuildingInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BuildingInfo> queryBuildingInfo(AreaInfo areaObj,String buildingName) throws Exception  { 
     	String where = "where 1=1";
    	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_buildingInfo.areaObj=" + areaObj.getAreaId();
    	if(!buildingName.equals("")) where = where + " and t_buildingInfo.buildingName like '%" + buildingName + "%'";
    	return buildingInfoMapper.queryBuildingInfoList(where);
    }

    /*查询所有楼盘信息记录*/
    public ArrayList<BuildingInfo> queryAllBuildingInfo()  throws Exception {
        return buildingInfoMapper.queryBuildingInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(AreaInfo areaObj,String buildingName) throws Exception {
     	String where = "where 1=1";
    	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_buildingInfo.areaObj=" + areaObj.getAreaId();
    	if(!buildingName.equals("")) where = where + " and t_buildingInfo.buildingName like '%" + buildingName + "%'";
        recordNumber = buildingInfoMapper.queryBuildingInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取楼盘信息记录*/
    public BuildingInfo getBuildingInfo(int buildingId) throws Exception  {
        BuildingInfo buildingInfo = buildingInfoMapper.getBuildingInfo(buildingId);
        return buildingInfo;
    }

    /*更新楼盘信息记录*/
    public void updateBuildingInfo(BuildingInfo buildingInfo) throws Exception {
        buildingInfoMapper.updateBuildingInfo(buildingInfo);
    }

    /*删除一条楼盘信息记录*/
    public void deleteBuildingInfo (int buildingId) throws Exception {
        buildingInfoMapper.deleteBuildingInfo(buildingId);
    }

    /*删除多条楼盘信息信息*/
    public int deleteBuildingInfos (String buildingIds) throws Exception {
    	String _buildingIds[] = buildingIds.split(",");
    	for(String _buildingId: _buildingIds) {
    		buildingInfoMapper.deleteBuildingInfo(Integer.parseInt(_buildingId));
    	}
    	return _buildingIds.length;
    }
}
