package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.PriceRange;

import com.chengxusheji.mapper.PriceRangeMapper;
@Service
public class PriceRangeService {

	@Resource PriceRangeMapper priceRangeMapper;
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

    /*添加租金范围记录*/
    public void addPriceRange(PriceRange priceRange) throws Exception {
    	priceRangeMapper.addPriceRange(priceRange);
    }

    /*按照查询条件分页查询租金范围记录*/
    public ArrayList<PriceRange> queryPriceRange(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return priceRangeMapper.queryPriceRange(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<PriceRange> queryPriceRange() throws Exception  { 
     	String where = "where 1=1";
    	return priceRangeMapper.queryPriceRangeList(where);
    }

    /*查询所有租金范围记录*/
    public ArrayList<PriceRange> queryAllPriceRange()  throws Exception {
        return priceRangeMapper.queryPriceRangeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = priceRangeMapper.queryPriceRangeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取租金范围记录*/
    public PriceRange getPriceRange(int rangeId) throws Exception  {
        PriceRange priceRange = priceRangeMapper.getPriceRange(rangeId);
        return priceRange;
    }

    /*更新租金范围记录*/
    public void updatePriceRange(PriceRange priceRange) throws Exception {
        priceRangeMapper.updatePriceRange(priceRange);
    }

    /*删除一条租金范围记录*/
    public void deletePriceRange (int rangeId) throws Exception {
        priceRangeMapper.deletePriceRange(rangeId);
    }

    /*删除多条租金范围信息*/
    public int deletePriceRanges (String rangeIds) throws Exception {
    	String _rangeIds[] = rangeIds.split(",");
    	for(String _rangeId: _rangeIds) {
    		priceRangeMapper.deletePriceRange(Integer.parseInt(_rangeId));
    	}
    	return _rangeIds.length;
    }
}
