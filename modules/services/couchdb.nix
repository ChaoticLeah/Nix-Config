{ ... }:
{
  services.couchdb = {
    enable = true;

    adminUser = "admin";
    adminPass = "e3iHNQU$LMxJPT0$8gDtRy*WZa3Lo*zrt^3n05SVRx1IbWUvztxjYv4*CRQ0";

    bindAddress = "0.0.0.0";

    #databaseDir = "/var/lib/couchdb/database";
    #viewIndexDir = "/var/lib/couchdb/view_index";

  };
}
