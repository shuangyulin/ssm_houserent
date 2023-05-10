package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.AreaInfo;

import com.chengxusheji.mapper.AreaInfoMapper;
@Service
public class AreaInfoService {

	@Resource AreaInfoMapper areaInfoMapper;
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

    /*添加区域信息记录*/
    public void addAreaInfo(AreaInfo areaInfo) throws Exception {
    	areaInfoMapper.addAreaInfo(areaInfo);
    }

    /*按照查询条件分页查询区域信息记录*/
    public ArrayList<AreaInfo> queryAreaInfo(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return areaInfoMapper.queryAreaInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<AreaInfo> queryAreaInfo() throws Exception  { 
     	String where = "where 1=1";
    	return areaInfoMapper.queryAreaInfoList(where);
    }

    /*查询所有区域信息记录*/
    public ArrayList<AreaInfo> queryAllAreaInfo()  throws Exception {
        return areaInfoMapper.queryAreaInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = areaInfoMapper.queryAreaInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取区域信息记录*/
    public AreaInfo getAreaInfo(int areaId) throws Exception  {
        AreaInfo areaInfo = areaInfoMapper.getAreaInfo(areaId);
        return areaInfo;
    }

    /*更新区域信息记录*/
    public void updateAreaInfo(AreaInfo areaInfo) throws Exception {
        areaInfoMapper.updateAreaInfo(areaInfo);
    }

    /*删除一条区域信息记录*/
    public void deleteAreaInfo (int areaId) throws Exception {
        areaInfoMapper.deleteAreaInfo(areaId);
    }

    /*删除多条区域信息信息*/
    public int deleteAreaInfos (String areaIds) throws Exception {
    	String _areaIds[] = areaIds.split(",");
    	for(String _areaId: _areaIds) {
    		areaInfoMapper.deleteAreaInfo(Integer.parseInt(_areaId));
    	}
    	return _areaIds.length;
    }
}
