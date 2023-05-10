package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BuildingInfo;
import com.chengxusheji.po.HourseType;
import com.chengxusheji.po.PriceRange;
import com.chengxusheji.po.Hourse;

import com.chengxusheji.mapper.HourseMapper;
@Service
public class HourseService {

	@Resource HourseMapper hourseMapper;
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

    /*添加房屋信息记录*/
    public void addHourse(Hourse hourse) throws Exception {
    	hourseMapper.addHourse(hourse);
    }

    /*按照查询条件分页查询房屋信息记录*/
    public ArrayList<Hourse> queryHourse(String hourseName,BuildingInfo buildingObj,HourseType hourseTypeObj,PriceRange priceRangeObj,String madeYear,String connectPerson,String connectPhone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!hourseName.equals("")) where = where + " and t_hourse.hourseName like '%" + hourseName + "%'";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_hourse.buildingObj=" + buildingObj.getBuildingId();
    	if(null != hourseTypeObj && hourseTypeObj.getTypeId()!= null && hourseTypeObj.getTypeId()!= 0)  where += " and t_hourse.hourseTypeObj=" + hourseTypeObj.getTypeId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_hourse.priceRangeObj=" + priceRangeObj.getRangeId();
    	if(!madeYear.equals("")) where = where + " and t_hourse.madeYear like '%" + madeYear + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_hourse.connectPerson like '%" + connectPerson + "%'";
    	if(!connectPhone.equals("")) where = where + " and t_hourse.connectPhone like '%" + connectPhone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return hourseMapper.queryHourse(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Hourse> queryHourse(String hourseName,BuildingInfo buildingObj,HourseType hourseTypeObj,PriceRange priceRangeObj,String madeYear,String connectPerson,String connectPhone) throws Exception  { 
     	String where = "where 1=1";
    	if(!hourseName.equals("")) where = where + " and t_hourse.hourseName like '%" + hourseName + "%'";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_hourse.buildingObj=" + buildingObj.getBuildingId();
    	if(null != hourseTypeObj && hourseTypeObj.getTypeId()!= null && hourseTypeObj.getTypeId()!= 0)  where += " and t_hourse.hourseTypeObj=" + hourseTypeObj.getTypeId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_hourse.priceRangeObj=" + priceRangeObj.getRangeId();
    	if(!madeYear.equals("")) where = where + " and t_hourse.madeYear like '%" + madeYear + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_hourse.connectPerson like '%" + connectPerson + "%'";
    	if(!connectPhone.equals("")) where = where + " and t_hourse.connectPhone like '%" + connectPhone + "%'";
    	return hourseMapper.queryHourseList(where);
    }

    /*查询所有房屋信息记录*/
    public ArrayList<Hourse> queryAllHourse()  throws Exception {
        return hourseMapper.queryHourseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String hourseName,BuildingInfo buildingObj,HourseType hourseTypeObj,PriceRange priceRangeObj,String madeYear,String connectPerson,String connectPhone) throws Exception {
     	String where = "where 1=1";
    	if(!hourseName.equals("")) where = where + " and t_hourse.hourseName like '%" + hourseName + "%'";
    	if(null != buildingObj && buildingObj.getBuildingId()!= null && buildingObj.getBuildingId()!= 0)  where += " and t_hourse.buildingObj=" + buildingObj.getBuildingId();
    	if(null != hourseTypeObj && hourseTypeObj.getTypeId()!= null && hourseTypeObj.getTypeId()!= 0)  where += " and t_hourse.hourseTypeObj=" + hourseTypeObj.getTypeId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_hourse.priceRangeObj=" + priceRangeObj.getRangeId();
    	if(!madeYear.equals("")) where = where + " and t_hourse.madeYear like '%" + madeYear + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_hourse.connectPerson like '%" + connectPerson + "%'";
    	if(!connectPhone.equals("")) where = where + " and t_hourse.connectPhone like '%" + connectPhone + "%'";
        recordNumber = hourseMapper.queryHourseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取房屋信息记录*/
    public Hourse getHourse(int hourseId) throws Exception  {
        Hourse hourse = hourseMapper.getHourse(hourseId);
        return hourse;
    }

    /*更新房屋信息记录*/
    public void updateHourse(Hourse hourse) throws Exception {
        hourseMapper.updateHourse(hourse);
    }

    /*删除一条房屋信息记录*/
    public void deleteHourse (int hourseId) throws Exception {
        hourseMapper.deleteHourse(hourseId);
    }

    /*删除多条房屋信息信息*/
    public int deleteHourses (String hourseIds) throws Exception {
    	String _hourseIds[] = hourseIds.split(",");
    	for(String _hourseId: _hourseIds) {
    		hourseMapper.deleteHourse(Integer.parseInt(_hourseId));
    	}
    	return _hourseIds.length;
    }
}
