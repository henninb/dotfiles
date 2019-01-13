package example_db.repositories;

import example_db.entities.Loc;
import org.springframework.data.repository.CrudRepository;

public interface LocRepository extends CrudRepository<Loc, Integer> {
}
