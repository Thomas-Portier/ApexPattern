/**
 * Created by thom on 11/10/20.
 */
@IsTest
public with sharing class UnitOfWorkTest {
    @IsTest
    static void challengeComplete() {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new List<Schema.SObjectType>{
                Account.SObjectType,
                Contact.SObjectType,
                Note.SObjectType
            }
        );

        for (Integer i = 0; i < 100; i++) {
            Account acc = new Account();
            acc.Name = 'AccTest-' + i;
            uow.registerNew(acc);
            for (Integer j = 0; j < 5; j++) {
                Contact ctc = new Contact();
                ctc.LastName = 'CtcTest-' + i + '-' + j;
                uow.registerNew(ctc, Contact.AccountId, acc);
                Note nte = new Note();
                nte.Title = 'Title-' + i + '-' + j;
                nte.Body = 'Body-' + i + '-' + j;
                uow.registerNew(nte, Note.ParentId, ctc);
            }
        }
        uow.commitWork();

        System.assertEquals(100, [SELECT Id FROM Account].size());
        System.assertEquals(500, [SELECT Id FROM Contact].size());
        System.assertEquals(500, [SELECT Id FROM Note].size());
    }
}