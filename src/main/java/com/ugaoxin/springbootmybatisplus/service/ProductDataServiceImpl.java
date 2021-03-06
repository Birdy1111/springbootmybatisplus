package com.ugaoxin.springbootmybatisplus.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ugaoxin.springbootmybatisplus.mapper.ProductDataMapper;
import com.ugaoxin.springbootmybatisplus.mapper.ProductMapper;
import com.ugaoxin.springbootmybatisplus.pojo.ProductData;
import org.springframework.stereotype.Service;

@Service
public class ProductDataServiceImpl extends ServiceImpl<ProductDataMapper, ProductData> implements ProductDataService{
}
