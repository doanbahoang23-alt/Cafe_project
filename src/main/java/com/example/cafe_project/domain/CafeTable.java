package com.example.cafe_project.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "cafetable")
public class CafeTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long tableId;
    
    private Integer status;
    
    @NotBlank(message = "Vui lòng nhập số bàn")
    @Size(min = 1, max = 20, message = "Số bàn phải từ 1 đến 20 ký tự")
    private String tableNumber;
    
    @NotNull(message = "Vui lòng nhập sức chứa")
    @Min(value = 1, message = "Sức chứa phải từ 1 người trở lên")
    @Max(value = 50, message = "Sức chứa không được vượt quá 50 người")
    private Integer capacity;

    public Long getTableId() {
        return tableId;
    }

    public void setTableId(Long tableId) {
        this.tableId = tableId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(String tableNumber) {
        this.tableNumber = tableNumber;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

}
