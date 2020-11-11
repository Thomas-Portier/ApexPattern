/**
 * Created by thom on 11/11/20.
 */

trigger AccountsTrigger on Account(
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete
) {
    fflib_SObjectDomain.triggerHandler(Accounts.class);
}