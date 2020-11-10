public with sharing class CaseService {
    public static void closeCases(Set<Id> caseIds, String closeReason) {
        if (caseIds == null || caseIds.size() == 0) {
            throw new CaseServiceException('Opportunities not specified.');
        }

        if (closeReason == null || closeReason == '') {
            throw new CaseServiceException('Reason not specified.');
        }

        List<Case> cases = [SELECT Id FROM Case];
        for (Case cse : cases) {
            cse.Status = 'Closed';
            cse.Reason = closeReason;
        }

        Savepoint sp = Database.setSavepoint();
        try {
            update cases;
        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        }
    }

    public class CaseServiceException extends Exception {
    }
}