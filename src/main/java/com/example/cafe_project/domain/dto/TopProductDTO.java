package com.example.cafe_project.domain.dto;

public class TopProductDTO {
    private String productName;
    private int quantitySold;

    public TopProductDTO() {
    }

    public TopProductDTO(String productName, int quantitySold) {
        this.productName = productName;
        this.quantitySold = quantitySold;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantitySold() {
        return quantitySold;
    }

    public void setQuantitySold(int quantitySold) {
        this.quantitySold = quantitySold;
    }
}
