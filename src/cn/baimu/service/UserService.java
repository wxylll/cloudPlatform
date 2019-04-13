package cn.baimu.service;

import cn.baimu.po.User;

import java.util.List;

/**
 * UserService
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

}
