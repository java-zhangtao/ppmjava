package com.jian.bus.vo;

import com.jian.bus.pojo.Car;
import com.jian.bus.pojo.Customer;

public class CarVo extends Car {
    private Integer page=1;
    private Integer limit=10;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }
}
