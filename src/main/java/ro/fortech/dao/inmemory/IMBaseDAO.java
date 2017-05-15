package ro.fortech.dao.inmemory;

import ro.fortech.dao.BaseDAO;
import ro.fortech.model.AbstractModel;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Created by Tamas on 4/30/2017.
 */
public class IMBaseDAO<T extends AbstractModel> implements BaseDAO<T> {
    private Map<Long, T> models = new HashMap<Long, T>();

    private static AtomicLong ID = new AtomicLong(System.currentTimeMillis());

    @Override
    public Collection<T> getAll() {

        return models.values();
    }

    @Override
    public T findById(Long id) {

        return models.get(id);
    }

    @Override
    public T update(T model) {
        if (model.getId() <= 0) {
            model.setId(ID.getAndIncrement());
        }

        models.put(model.getId(), model);
        return model;
    }

    @Override
    public boolean delete(T model) {
        boolean result = models.containsKey(model.getId());

        if (result)
            models.remove(model.getId());
        return result;
    }

}