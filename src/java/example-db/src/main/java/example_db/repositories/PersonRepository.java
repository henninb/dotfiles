package example_db.repositories;

import example_db.domain.Person;
//import org.springframework.data.repository.CrudRepository;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PersonRepository extends JpaRepository<Person, Integer> {
//public interface PersonRepository extends CrudRepository<Person, Integer> {
}
