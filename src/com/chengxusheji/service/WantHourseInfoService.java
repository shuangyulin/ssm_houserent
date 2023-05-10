package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.AreaInfo;
import com.chengxusheji.po.HourseType;
import com.chengxusheji.po.PriceRange;
import com.chengxusheji.po.WantHourseInfo;

import com.chengxusheji.mapper.WantHourseInfoMapper;
@Service
public class WantHourseInfoService {

	@Resource WantHourseInfoMapper wantHourseInfoMapper;
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

    /*添加求租信息记录*/
    public void addWantHourseInfo(WantHourseInfo wantHourseInfo) throws Exception {
    	wantHourseInfoMapper.addWantHourseInfo(wantHourseInfo);
    }

    /*按照查询条件分页查询求租信息记录*/
    public ArrayList<WantHourseInfo> queryWantHourseInfo(UserInfo userObj,String title,AreaInfo position,HourseType hourseTypeObj,PriceRange priceRangeObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_wantHourseInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!title.equals("")) where = where + " and t_wantHourseInfo.title like '%" + title + "%'";
    	if(null != position && position.getAreaId()!= null && position.getAreaId()!= 0)  where += " and t_wantHourseInfo.position=" + position.getAreaId();
    	if(null != hourseTypeObj && hourseTypeObj.getTypeId()!= null && hourseTypeObj.getTypeId()!= 0)  where += " and t_wantHourseInfo.hourseTypeObj=" + hourseTypeObj.getTypeId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_wantHourseInfo.priceRangeObj=" + priceRangeObj.getRangeId();
    	int startIndex = (currentPage-1) * this.rows;
    	return wantHourseInfoMapper.queryWantHourseInfo(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<WantHourseInfo> queryWantHourseInfo(UserInfo userObj,String title,AreaInfo position,HourseType hourseTypeObj,PriceRange priceRangeObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_wantHourseInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!title.equals("")) where = where + " and t_wantHourseInfo.title like '%" + title + "%'";
    	if(null != position && position.getAreaId()!= null && position.getAreaId()!= 0)  where += " and t_wantHourseInfo.position=" + position.getAreaId();
    	if(null != hourseTypeObj && hourseTypeObj.getTypeId()!= null && hourseTypeObj.getTypeId()!= 0)  where += " and t_wantHourseInfo.hourseTypeObj=" + hourseTypeObj.getTypeId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_wantHourseInfo.priceRangeObj=" + priceRangeObj.getRangeId();
    	return wantHourseInfoMapper.queryWantHourseInfoList(where);
    }

    /*查询所有求租信息记录*/
    public ArrayList<WantHourseInfo> queryAllWantHourseInfo()  throws Exception {
        return wantHourseInfoMapper.queryWantHourseInfoList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj,String title,AreaInfo position,HourseType hourseTypeObj,PriceRange priceRangeObj) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_wantHourseInfo.userObj='" + userObj.getUser_name() + "'";
    	if(!title.equals("")) where = where + " and t_wantHourseInfo.title like '%" + title + "%'";
    	if(null != position && position.getAreaId()!= null && position.getAreaId()!= 0)  where += " and t_wantHourseInfo.position=" + position.getAreaId();
    	if(null != hourseTypeObj && hourseTypeObj.getTypeId()!= null && hourseTypeObj.getTypeId()!= 0)  where += " and t_wantHourseInfo.hourseTypeObj=" + hourseTypeObj.getTypeId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_wantHourseInfo.priceRangeObj=" + priceRangeObj.getRangeId();
        recordNumber = wantHourseInfoMapper.queryWantHourseInfoCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取求租信息记录*/
    public WantHourseInfo getWantHourseInfo(int wantHourseId) throws Exception  {
        WantHourseInfo wantHourseInfo = wantHourseInfoMapper.getWantHourseInfo(wantHourseId);
        return wantHourseInfo;
    }

    /*更新求租信息记录*/
    public void updateWantHourseInfo(WantHourseInfo wantHourseInfo) throws Exception {
        wantHourseInfoMapper.updateWantHourseInfo(wantHourseInfo);
    }

    /*删除一条求租信息记录*/
    public void deleteWantHourseInfo (int wantHourseId) throws Exception {
        wantHourseInfoMapper.deleteWantHourseInfo(wantHourseId);
    }

    /*删除多条求租信息信息*/
    public int deleteWantHourseInfos (String wantHourseIds) throws Exception {
    	String _wantHourseIds[] = wantHourseIds.split(",");
    	for(String _wantHourseId: _wantHourseIds) {
    		wantHourseInfoMapper.deleteWantHourseInfo(Integer.parseInt(_wantHourseId));
    	}
    	return _wantHourseIds.length;
    }
}
