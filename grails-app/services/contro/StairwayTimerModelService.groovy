package contro

import grails.gorm.transactions.Transactional

@Transactional 
class StairwayTimerModelService {

    @Transactional
    void deleteTimer (StairwayTimer timer) {
       // timer.delete(flush: true, failOnError:true)
    }

    
    static void saveSTWTimer (StairwayTimer timer) {
        timer.save(flush: true, failOnError:true)
    }



    @Transactional
    void updateTimer (String minutesToWait) {
        /*StairwayTimer swt = StairwayTimer.findByDevice(device)
        if (swt == null) {
            swt = new StairwayTimer()
        }
        swt.device = device
        swt.lastSeen = new Date()
        swt.minutesToWait = minutesToWait
        swt.save(flush:true, failOnError:true)*/
    }
}


