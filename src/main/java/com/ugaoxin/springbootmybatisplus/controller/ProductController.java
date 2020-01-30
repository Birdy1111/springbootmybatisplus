package com.ugaoxin.springbootmybatisplus.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ugaoxin.springbootmybatisplus.pojo.Product;
import com.ugaoxin.springbootmybatisplus.service.ProductSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 技术框架的productcontroller
 * 1.证明技术框架能跑通
 * 2.业务框架在第一步能跑通的情况下进行处理业务
 * 3.整合，变成企业里面实际研发的产品或者项目
 */

@RestController
public class ProductController {
    @Autowired
    private ProductSerivce productSerivce;
    /*
     *从数据库查询Product表中值
     */
    @RequestMapping("getListByPage")
    public IPage<Product>  getListByPage() {

        //调用service方法   优先考虑mybatisplus的内置封装方法
        IPage<Product> page = new Page<Product>(0,5);

        IPage<Product> res = productSerivce.page(page);

        return res;

    }
}
