package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.PriceRangeService;
import com.chengxusheji.po.PriceRange;

//PriceRange管理控制层
@Controller
@RequestMapping("/PriceRange")
public class PriceRangeController extends BaseController {

    /*业务层对象*/
    @Resource PriceRangeService priceRangeService;

	@InitBinder("priceRange")
	public void initBinderPriceRange(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("priceRange.");
	}
	/*跳转到添加PriceRange视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new PriceRange());
		return "PriceRange_add";
	}

	/*客户端ajax方式提交添加租金范围信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated PriceRange priceRange, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        priceRangeService.addPriceRange(priceRange);
        message = "租金范围添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询租金范围信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)priceRangeService.setRows(rows);
		List<PriceRange> priceRangeList = priceRangeService.queryPriceRange(page);
	    /*计算总的页数和总的记录数*/
	    priceRangeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = priceRangeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = priceRangeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(PriceRange priceRange:priceRangeList) {
			JSONObject jsonPriceRange = priceRange.getJsonObject();
			jsonArray.put(jsonPriceRange);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询租金范围信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(PriceRange priceRange:priceRangeList) {
			JSONObject jsonPriceRange = new JSONObject();
			jsonPriceRange.accumulate("rangeId", priceRange.getRangeId());
			jsonPriceRange.accumulate("priceName", priceRange.getPriceName());
			jsonArray.put(jsonPriceRange);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询租金范围信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<PriceRange> priceRangeList = priceRangeService.queryPriceRange(currentPage);
	    /*计算总的页数和总的记录数*/
	    priceRangeService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = priceRangeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = priceRangeService.getRecordNumber();
	    request.setAttribute("priceRangeList",  priceRangeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "PriceRange/priceRange_frontquery_result"; 
	}

     /*前台查询PriceRange信息*/
	@RequestMapping(value="/{rangeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer rangeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键rangeId获取PriceRange对象*/
        PriceRange priceRange = priceRangeService.getPriceRange(rangeId);

        request.setAttribute("priceRange",  priceRange);
        return "PriceRange/priceRange_frontshow";
	}

	/*ajax方式显示租金范围修改jsp视图页*/
	@RequestMapping(value="/{rangeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer rangeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键rangeId获取PriceRange对象*/
        PriceRange priceRange = priceRangeService.getPriceRange(rangeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPriceRange = priceRange.getJsonObject();
		out.println(jsonPriceRange.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新租金范围信息*/
	@RequestMapping(value = "/{rangeId}/update", method = RequestMethod.POST)
	public void update(@Validated PriceRange priceRange, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			priceRangeService.updatePriceRange(priceRange);
			message = "租金范围更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "租金范围更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除租金范围信息*/
	@RequestMapping(value="/{rangeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer rangeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  priceRangeService.deletePriceRange(rangeId);
	            request.setAttribute("message", "租金范围删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "租金范围删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条租金范围记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String rangeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = priceRangeService.deletePriceRanges(rangeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出租金范围信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<PriceRange> priceRangeList = priceRangeService.queryPriceRange();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "PriceRange信息记录"; 
        String[] headers = { "记录编号","价格区间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<priceRangeList.size();i++) {
        	PriceRange priceRange = priceRangeList.get(i); 
        	dataset.add(new String[]{priceRange.getRangeId() + "",priceRange.getPriceName()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"PriceRange.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
