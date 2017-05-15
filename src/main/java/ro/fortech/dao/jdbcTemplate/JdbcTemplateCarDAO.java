package ro.fortech.dao.jdbcTemplate;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import ro.fortech.dao.CarDAO;
import ro.fortech.model.Car;
import ro.fortech.model.EngineType;
import ro.fortech.model.TransmissionType;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by Tamas on 5/4/2017.
 */
public class JdbcTemplateCarDAO implements CarDAO {

    private JdbcTemplate jdbcTemplate;

    private String carDetailsForQuery = "Select c.id, " +
                                        "c.seller_id, " +
                                        "cm.manufacturer_name, " +
                                        "ct.type_name, " +
                                        "c.price, " +
                                        "c.mileage, " +
                                        "c.registration_year, " +
                                        "c.extras, " +
                                        "et.engine_type, " +
                                        "tt.transmission_type, " +
                                        "co.colour, " +
                                        "c.matriculation_status, " +
                                        "c.picture_src " +

                                        "from cars c join car_manufacturers cm on c.manufacturer_id = cm.id "+
                                        "join car_types ct on c.type_id = ct.id "+
                                        "join engine_types et on c.engine_type_id = et.id "+
                                        "join transmission_types tt on c.transmission_type_id = tt.id "+
                                        "join colours co on c.colour_id = co.id ";



    public JdbcTemplateCarDAO(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public Collection<Car> getAll() {
        String query = carDetailsForQuery;

        return jdbcTemplate.query(query, new CarMapper());
    }

    @Override
    public Car findById(Long id) {
        String query = carDetailsForQuery +
                " where c.id = ?";
        Collection<Car> cars =  jdbcTemplate.query(query, new CarMapper(), id);
        Car result;
        if (cars.size() != 1) {
            result = null;
        } else {
            result = cars.iterator().next();
        }
        return result;
    }

    @Override
    public Car update(Car model) {
        String sql = "";
        Long newId = null;
        if (model.getId() > 0) {
            sql = "update cars set manufacturer_id=(SELECT id FROM car_manufacturers WHERE manufacturer_name =?)," +
                                 " type_id=(SELECT id FROM car_types WHERE type_name =?)," +
                                 " price=?," +
                                 " mileage=?," +
                                 " registration_year=?," +
                                 " extras=?, " +
                                 " engine_type_id=(SELECT id FROM engine_types WHERE engine_type =?)," +
                                 " transmission_type_id=(SELECT id FROM transmission_types WHERE transmission_type =?)," +
                                 " colour_id=(SELECT id FROM colours WHERE colour =?)," +
                                 " matriculation_status = ?, "+
                                 " picture_src = ?, "+
                                 " seller_id=? "
                    + "where id = ? returning id";
            newId = jdbcTemplate.queryForObject(sql, new Object[]{
                    model.getManufacturer(),
                    model.getType(),
                    model.getPrice(),
                    model.getMileAge(),
                    model.getFabricationYear(),
                    model.getExtras(),
                    model.getEngineType().name(),
                    model.getTransmissionType().name(),
                    model.getColour(),
                    model.getMatriculated(),
                    model.getImgUrl(),
                    model.getSellerId(),

                    model.getId()

                    }, new RowMapper<Long>() {
                        public Long mapRow(ResultSet rs, int arg1) throws SQLException {
                            return rs.getLong(1);
                        }
                    });

        } else {
            sql = "insert into cars (manufacturer_id, type_id, price, mileage, registration_year, extras, " +
                                    "engine_type_id, transmission_type_id, colour_id, matriculation_status, " +
                                    " picture_src, seller_id) "
                    + "values ((SELECT id FROM car_manufacturers WHERE manufacturer_name =?)," +
                             " (SELECT id FROM car_types WHERE type_name =?)," +
                             " ?," +
                             " ?," +
                             " ?," +
                             " ?," +
                             " (SELECT id FROM engine_types WHERE engine_type =?)," +
                             " (SELECT id FROM transmission_types WHERE transmission_type =?)," +
                             " (SELECT id FROM colours WHERE colour =?)," +
                             " ?," +
                             " ?," +
                             " ?" +
                             ") returning id";

            newId = jdbcTemplate.queryForObject(sql, new Object[]{
                    model.getManufacturer(),
                    model.getType(),
                    model.getPrice(),
                    model.getMileAge(),
                    model.getFabricationYear(),
                    model.getExtras(),
                    model.getEngineType().name(),
                    model.getTransmissionType().name(),
                    model.getColour(),
                    model.getMatriculated(),
                    model.getImgUrl(),
                    model.getSellerId(),

            }, new RowMapper<Long>() {
                public Long mapRow(ResultSet rs, int arg1) throws SQLException {
                    return rs.getLong(1);
                }
            });
        }
        model.setId(newId);

        return model;

    }

    @Override
    public boolean delete(Car model) {
        return jdbcTemplate.update("delete from cars where id=?", model.getId()) > 0;
    }

    @Override
    public Collection<Car> getCarListOfSeller(long sellerId) {
        String query = carDetailsForQuery +
                " where c.seller_id = ?";
        return  jdbcTemplate.query(query, new CarMapper(), sellerId);
    }

    @Override
    public Map<String, List<String>> getCarManufacturersAndTypes() {
        Map<String, List<String>> map = new LinkedHashMap<>();
        map.putAll(
                jdbcTemplate.query("Select manufacturer_name, type_name FROM car_types JOIN car_manufacturers" +
                                " ON car_types.manufacturer_id = car_manufacturers.id;",
                        new ResultSetExtractor<Map<String, List<String>>>() {
                            @Override
                            public Map<String, List<String>> extractData(ResultSet rs) throws SQLException, DataAccessException {
                                Map<String, List<String>> manufacturersAndTypes = new LinkedHashMap<>();
                                while (rs.next()) {
                                    String manufacturerName = rs.getString("manufacturer_name");
                                    String typeName = rs.getString("type_name");

                                    if (!manufacturersAndTypes.keySet().contains(manufacturerName)) {
                                        manufacturersAndTypes.put(manufacturerName, new LinkedList<>());
                                    }
                                    manufacturersAndTypes.get(manufacturerName).add(typeName);
                                }
                                return manufacturersAndTypes;
                            }
                        })
        );
        return map;
    }

    private static class CarMapper implements RowMapper<Car> {
        @Override
        public Car mapRow(ResultSet rs, int rowNum) throws SQLException {
            Car car = new Car();
            car.setId(rs.getLong("id"));
            car.setSellerId(rs.getLong("seller_id"));
            car.setManufacturer(rs.getString("manufacturer_name"));
            car.setType(rs.getString("type_name"));
            car.setPrice(rs.getInt("price"));
            car.setMileAge(rs.getInt("mileage"));
            car.setFabricationYear(rs.getInt("registration_year"));
            car.setExtras(rs.getString("extras"));
            car.setEngineType(EngineType.valueOf(rs.getString("engine_type")));
            car.setTransmissionType(TransmissionType.valueOf(rs.getString("transmission_type")));
            car.setColour(rs.getString("colour"));
            car.setMatriculated(rs.getBoolean("matriculation_status"));
            car.setImgUrl(rs.getString("picture_src"));

            return car;
        }
    }

    @Override
    public List<String> getAllColors() {
        List<String> allColours = new LinkedList<>();
        allColours.add("All");
        allColours.addAll(
                jdbcTemplate.query("SELECT colour FROM colours", new RowMapper<String>() {
                    @Override
                    public String mapRow(ResultSet rs, int rowNum) throws SQLException {
                        return rs.getString("colour");
                    }
                })
        );
        allColours.add("Other");
        return allColours;
    }

}
