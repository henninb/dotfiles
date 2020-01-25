package example_db.services;

import example_db.domain.Person;
import example_db.repositories.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonService {
    private PersonRepository personRepository;

    @Autowired
    PersonService(PersonRepository personRepository) {
        this.personRepository = personRepository;
    }

    void addPerson(Person person) {
        //Iterable<Person> persons = personRepository.findAll();

        //for(Person person: persons) {
            personRepository.save(person);
        //}
    }
}
