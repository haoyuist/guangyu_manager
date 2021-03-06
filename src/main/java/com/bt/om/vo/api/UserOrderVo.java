package com.bt.om.vo.api;

import java.io.Serializable;

public class UserOrderVo implements Serializable {
	private static final long serialVersionUID = 354883746982564301L;
	private String msg;
	private String status;
	private String canDraw;

	public UserOrderVo(String msg, String status, String canDraw) {
		this.msg = msg;
		this.status = status;
		this.canDraw = canDraw;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCanDraw() {
		return canDraw;
	}

	public void setCanDraw(String canDraw) {
		this.canDraw = canDraw;
	}

}
