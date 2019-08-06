package cn.baimu.mapper;

import cn.baimu.po.User;

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
    public void add(User user) throws Exception;

    /**
     * 删除账号
     * @param uid
     */
    public void delete(String uid) throws Exception;

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
     * 根据地点获取用户
     * @param position
     * @return
     * @throws Exception
     */
    public List<User> findUserByPosition(String position) throws Exception;

    /**
     * 更新用户信息
     * @param user
     * @throws Exception
     */
    public void update(User user) throws Exception;

    /**
     * 获取指定用户
     * @param uid
     * @return
     * @throws Exception
     */
    public User get(String uid) throws Exception;

}
