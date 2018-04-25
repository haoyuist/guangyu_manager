package com.bt.om.web.controller.api;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bt.om.cache.JedisPool;
import com.bt.om.common.SysConst;
import com.bt.om.entity.DrawCash;
import com.bt.om.entity.DrawCashOrder;
import com.bt.om.entity.UserOrder;
import com.bt.om.enums.ResultCode;
import com.bt.om.enums.SessionKey;
import com.bt.om.service.IDrawCashOrderService;
import com.bt.om.service.IDrawCashService;
import com.bt.om.service.IUserOrderService;
import com.bt.om.util.DateUtil;
import com.bt.om.vo.api.OrderDrawVo;
import com.bt.om.vo.web.ResultVo;
import com.bt.om.web.BasicController;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * 逛鱼申请提现Controller
 */
@Controller
public class OrderDrawController extends BasicController {
	@Autowired
	private IDrawCashService drawCashService;
	@Autowired
	private IDrawCashOrderService drawCashOrderService;
	@Autowired
	private IUserOrderService userOrderService;
	@Autowired
	private JedisPool jedisPool;

	@RequestMapping(value = "/orderdraw.html", method = RequestMethod.GET)
	public String search(Model model, HttpServletRequest request) {
		String weekday = DateUtil.getWeekOfDate(new Date());
		if ("2".equals(weekday) || "5".equals(weekday)) {
			return "search/orderdraw";
		} else {
			 return "search/orderdraw-none";
//			return "search/orderdraw";
		}
	}

	// 申请提现
	@RequestMapping(value = "/api/orderdraw", method = RequestMethod.POST)
	@ResponseBody
	public Model orderDraw(Model model, HttpServletRequest request, HttpServletResponse response) {
		ResultVo<OrderDrawVo> result = new ResultVo<>();
		result.setCode(ResultCode.RESULT_SUCCESS.getCode());
		result.setResultDes("");
		model = new ExtendedModelMap();
		String mobile = "";
		String alipay = "";
		String vcode = "";
		String smscode = "";

		try {
			InputStream is = request.getInputStream();
			Gson gson = new Gson();
			JsonObject obj = gson.fromJson(new InputStreamReader(is), JsonObject.class);
			mobile = obj.get("mobile").getAsString();
			alipay = obj.get("alipay").getAsString();
			vcode = obj.get("vcode").getAsString();
			smscode = obj.get("smscode").getAsString();

			// 手机号码必须验证
			if (StringUtils.isEmpty(mobile)) {
				result.setResult(new OrderDrawVo(0, 0, "1"));
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
			// 支付宝必须验证
			if (StringUtils.isEmpty(alipay)) {
				result.setResult(new OrderDrawVo(0, 0, "2"));
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
			// 验证码必须验证
			if (StringUtils.isEmpty(vcode)) {
				result.setResult(new OrderDrawVo(0, 0, "3"));
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
			// 短信验证码必须验证
			if (StringUtils.isEmpty(smscode)) {
				result.setResult(new OrderDrawVo(0, 0, "4"));
				model.addAttribute(SysConst.RESULT_KEY, result);
				return model;
			}
		} catch (IOException e) {
			result.setCode(ResultCode.RESULT_FAILURE.getCode());
			result.setResultDes("系统繁忙，请稍后再试！");
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		String sessionCode = request.getSession().getAttribute(SessionKey.SESSION_CODE.toString()) == null ? ""
				: request.getSession().getAttribute(SessionKey.SESSION_CODE.toString()).toString();
		// 验证码有效验证
		if (!vcode.equalsIgnoreCase(sessionCode)) {
			result.setResult(new OrderDrawVo(0, 0, "5")); // 验证码不一致
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		String vcodejds = jedisPool.getResource().get(mobile);
		// 短信验证码已过期
		if (StringUtils.isEmpty(vcodejds)) {
			result.setResult(new OrderDrawVo(0, 0, "6"));
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		// 验证码有效验证
		if (!smscode.equalsIgnoreCase(vcodejds)) {
			result.setResult(new OrderDrawVo(0, 0, "7")); // 短信验证码不一致
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}

		jedisPool.getResource().del(mobile);

		List<UserOrder> userOrderList = userOrderService.selectByMobile(mobile);
		if (userOrderList == null || userOrderList.size() < 0) {
			result.setResult(new OrderDrawVo(0, 0, "8")); // 无可提现商品或者商品处于核对中
			model.addAttribute(SysConst.RESULT_KEY, result);
			return model;
		}
		double totalCommission = 0;
		int productNums = userOrderList.size();
		for (UserOrder userOrder : userOrderList) {
			totalCommission = totalCommission + userOrder.getCommission3();
		}

		DrawCash drawCash = new DrawCash();
		drawCash.setMobile(mobile);
		drawCash.setAlipayAccount(alipay);
		drawCash.setStatus(1);
		drawCash.setCash(totalCommission);
		drawCash.setCreateTime(new Date());
		drawCash.setUpdateTime(new Date());
		drawCashService.insert(drawCash);
		
		for(UserOrder userOrder : userOrderList){
			DrawCashOrder drawCashOrder = new DrawCashOrder();
			drawCashOrder.setOrderId(userOrder.getOrderId());
			drawCashOrder.setDrawCachId(drawCash.getId());
			drawCashOrder.setCreateTime(new Date());
			drawCashOrder.setUpdateTime(new Date());
			drawCashOrderService.insert(drawCashOrder);
		}
		
		UserOrder userOrder=new UserOrder();
		userOrder.setMobile(mobile);
		userOrder.setStatus2(2);
		userOrder.setUpdateTime(new Date());
		userOrderService.updateStatus2(userOrder);
		
		result.setResult(new OrderDrawVo(productNums, totalCommission, "0"));// 申请成功
		model.addAttribute(SysConst.RESULT_KEY, result);
		return model;
	}
}