Bugzilla Required-field
=======================

Extension for bugzilla using hook system to translate fields with "\*", in the names, to validate like required field. This is a simple solution not intrusive where is not required addition of fields in the database, only by the use of sufix "\*" in configuration of custom fields.

Version
----

1.0

Work for
----

Bugzilla [3.6.x,)
*Please, report me if in the newer versions don't work. I had made for version 3.4.4, but the code is lost, I will do this work for both.

Installation
--------------

```sh
cd [Bugzilla Home]/extensions
git clone [git-repo-url] RequiredField
```

How to use
----

- Go to : [bugzilla url]/editfields.cgi
- Create/Edit some field
- In the **Description** add sufix **\***

    Ex: origin of bug *
