package com.example.cafe_project.domain.dto;

import java.math.BigDecimal;

public class RevenueDayDTO {
    private String date;
    private BigDecimal revenue;
    private long orderCount;
    private int barHeightPercent;

    public RevenueDayDTO() {
    }

    public RevenueDayDTO(String date, BigDecimal revenue, long orderCount) {
        this.date = date;
        this.revenue = revenue;
        this.orderCount = orderCount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public BigDecimal getRevenue() {
        return revenue;
    }

    public void setRevenue(BigDecimal revenue) {
        this.revenue = revenue;
    }

    public long getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(long orderCount) {
        this.orderCount = orderCount;
    }

    public int getBarHeightPercent() {
        return barHeightPercent;
    }

    public void setBarHeightPercent(int barHeightPercent) {
        this.barHeightPercent = barHeightPercent;
    }
}
