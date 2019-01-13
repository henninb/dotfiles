package example_db.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class BatchExecuteService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());

    private LocService locService;

    @Autowired
    BatchExecuteService(LocService locService) {
        this.locService = locService;
    }

    @Scheduled(fixedDelay = 1000 * 60)
    public void execute() {
        System.out.println("test");
        locService.updateLoc();
        //List<Map<String, Object>> list = jdbcTemplate.queryForList(tlogQuery);

//        list.forEach(row -> {
//            LOGGER.info(String.valueOf(row));
//        });
//        if (list.size() > 0) {
//            postToSlackService.postOnSlack(TokenService.token, new StringBuilder(list.toString()));
//        }
    }

}
