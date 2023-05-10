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
import com.chengxusheji.service.AreaInfoService;
import com.chengxusheji.po.AreaInfo;

//AreaInfo管理控制层
@Controller
@RequestMapping("/AreaInfo")
public class AreaInfoController extends BaseController {

    /*业务层对象*/
    @Resource AreaInfoService areaInfoService;

	@InitBinder("areaInfo")
	public void initBinderAreaInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("areaInfo.");
	}
	/*跳转到添加AreaInfo视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new AreaInfo());
		return "AreaInfo_add";
	}

	/*客户端ajax方式提交添加区域信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated AreaInfo areaInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        areaInfoService.addAreaInfo(areaInfo);
        message = "区域信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询区域信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)areaInfoService.setRows(rows);
		List<AreaInfo> areaInfoList = areaInfoService.queryAreaInfo(page);
	    /*计算总的页数和总的记录数*/
	    areaInfoService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = areaInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = areaInfoService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(AreaInfo areaInfo:areaInfoList) {
			JSONObject jsonAreaInfo = areaInfo.getJsonObject();
			jsonArray.put(jsonAreaInfo);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询区域信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<AreaInfo> areaInfoList = areaInfoService.queryAllAreaInfo();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(AreaInfo areaInfo:areaInfoList) {
			JSONObject jsonAreaInfo = new JSONObject();
			jsonAreaInfo.accumulate("areaId", areaInfo.getAreaId());
			jsonAreaInfo.accumulate("areaName", areaInfo.getAreaName());
			jsonArray.put(jsonAreaInfo);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询区域信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<AreaInfo> areaInfoList = areaInfoService.queryAreaInfo(currentPage);
	    /*计算总的页数和总的记录数*/
	    areaInfoService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = areaInfoService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = areaInfoService.getRecordNumber();
	    request.setAttribute("areaInfoList",  areaInfoList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "AreaInfo/areaInfo_frontquery_result"; 
	}

     /*前台查询AreaInfo信息*/
	@RequestMapping(value="/{areaId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer areaId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键areaId获取AreaInfo对象*/
        AreaInfo areaInfo = areaInfoService.getAreaInfo(areaId);

        request.setAttribute("areaInfo",  areaInfo);
        return "AreaInfo/areaInfo_frontshow";
	}

	/*ajax方式显示区域信息修改jsp视图页*/
	@RequestMapping(value="/{areaId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer areaId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键areaId获取AreaInfo对象*/
        AreaInfo areaInfo = areaInfoService.getAreaInfo(areaId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonAreaInfo = areaInfo.getJsonObject();
		out.println(jsonAreaInfo.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新区域信息信息*/
	@RequestMapping(value = "/{areaId}/update", method = RequestMethod.POST)
	public void update(@Validated AreaInfo areaInfo, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			areaInfoService.updateAreaInfo(areaInfo);
			message = "区域信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "区域信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除区域信息信息*/
	@RequestMapping(value="/{areaId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer areaId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  areaInfoService.deleteAreaInfo(areaId);
	            request.setAttribute("message", "区域信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "区域信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条区域信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String areaIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = areaInfoService.deleteAreaInfos(areaIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出区域信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<AreaInfo> areaInfoList = areaInfoService.queryAreaInfo();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "AreaInfo信息记录"; 
        String[] headers = { "记录编号","区域名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<areaInfoList.size();i++) {
        	AreaInfo areaInfo = areaInfoList.get(i); 
        	dataset.add(new String[]{areaInfo.getAreaId() + "",areaInfo.getAreaName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"AreaInfo.xls");//filename是下载的xls的名，建议最好用英文 
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
