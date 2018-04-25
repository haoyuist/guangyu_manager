package com.bt.om.vo.api;

import java.io.Serializable;

public class OrderDrawVo implements Serializable {

	private static final long serialVersionUID = 3690982281582596226L;
	private int productNums;
	private double money;
	private String status;

	public OrderDrawVo(int productNums, double money, String status) {
		this.productNums = productNums;
		this.money = money;
		this.status = status;
	}

	public int getProductNums() {
		return productNums;
	}

	public void setProductNums(int productNums) {
		this.productNums = productNums;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
