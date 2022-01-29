package example_db.services;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
//import com.github.javafaker.service.FakeValuesService;
//import com.github.javafaker.service.RandomService;

import example_db.domain.Person;

@Slf4j
@Service
public class BatchExecuteService {
    private PersonService personService;

    //private FakeValuesService fakeValuesService = new FakeValuesService(new Locale("en-US"), new RandomService());

    @Autowired
    BatchExecuteService(PersonService personService) {
        this.personService = personService;
    }

    //every 4 seconds
    @Scheduled(fixedDelay = 4000)
    public void execute() {
        System.out.println("test");
        Person person = new Person();
        //person.setFirstName("blah");
        //person.setPersonId( 54 );
        personService.addPerson(person);
        System.out.println("test complete");
//        System.exit(2);
        //List<Map<String, Object>> list = jdbcTemplate.queryForList(tlogQuery);

//        list.forEach(row -> {
//            LOGGER.info(String.valueOf(row));
//        });
//        if (list.size() > 0) {
//            postToSlackService.postOnSlack(TokenService.token, new StringBuilder(list.toString()));
//        }
    }

}
