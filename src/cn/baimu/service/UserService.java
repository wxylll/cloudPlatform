package cn.baimu.service;

import cn.baimu.po.User;

import java.util.List;

/**
 * 前台用户Service
 * @auther wxy
 */
public interface UserService {

    /**
     * 添加前台用户账号
     * @param user
     */
    public void add(User user) throws Exception;

    /**
     * 删除账号
     * @param user
     */
    public void delete(User user) throws Exception;

    /**
     * 查询所有已有账号
     * @return
     */
    public List<User> findAll() throws Exception;

    /**
     * 根据用户名查询指定用户
     * @param username
     * @return
     */
    public User findByUsername(String username) throws Exception;

    /**
     * 用户登录
     * @param username
     * @param password
     * @return 登录成功即返回user详细信息，否则返回null
     */
    public User login(String username, String password);

    /**
     * 根据详细地址获取直辖用户（管辖范围包含该地点，且有最小管辖范围的用户）
     * @return
     * @throws Exception
     */
    public User findCrownUser(String position) throws Exception;

}
