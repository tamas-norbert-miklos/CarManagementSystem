package ro.fortech.dao;

import ro.fortech.model.AbstractModel;

import java.util.Collection;

/**
 * Created by Tamas on 4/20/2017.
 */
public interface BaseDAO<T extends AbstractModel> {

    Collection<T> getAll();

    T findById(Long id);

    T update(T model);

    boolean delete(T model);
}