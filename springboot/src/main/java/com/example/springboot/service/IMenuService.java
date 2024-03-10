package com.example.springboot.service;

import com.example.springboot.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 112 服务类
 * </p>
 *
 * @author baomidou
 * @since 2023-01-27
 */
public interface IMenuService extends IService<Menu> {

    List<Menu> findMenus(String name);
}
