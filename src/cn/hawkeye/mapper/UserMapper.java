package cn.hawkeye.mapper;

import cn.hawkeye.po.User;

import java.util.List;

/**
 * UserMapper
 * @author wxy
 */
public interface UserMapper {

    /**
     * 添加前台用户账号
     * @param user
     */
    public void add(User user);

    /**
     * 删除账号
     * @param user
     */
    public void delete(User user);

    /**
     * 查询所有已有账号
     * @return
     */
    public List<User> findAll();

    /**
     * 根据用户名查询指定用户
     * @param username
     * @return
     */
    public User findByUsername(String username);

}
