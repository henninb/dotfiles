package example_db.services;

import example_db.entities.Loc;
import example_db.repositories.LocRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LocService {
    private LocRepository locRepository;

    @Autowired
    LocService(LocRepository locRepository) {
        this.locRepository = locRepository;
    }

    void updateLoc() {

        Iterable<Loc> locs = locRepository.findAll();

        for(Loc loc: locs) {
            locRepository.save(loc);
        }
    }
}
