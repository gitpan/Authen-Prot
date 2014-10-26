#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#if defined(hpux)
#include <sys/types.h>
#include <hpsecurity.h>
#elif defined(sco_sv)
#include <sys/types.h>
#include <sys/security.h>
#include <sys/audit.h>
#endif

#include <prot.h>

typedef struct pr_passwd PASSWD;

MODULE = Authen::Prot		PACKAGE = Authen::Prot

PROTOTYPES: DISABLE

#if defined(sco_sv)

BOOT:
set_auth_parameters(1,"\0");


#endif

char *
bigcrypt(key, salt)
	char *key;
	char *salt;


int 
acceptable_password (word, stream)
	char *word;
	FILE *stream;


PASSWD *
getprpwent(CLASS)
		char *CLASS;
    CODE:
		RETVAL = (PASSWD*)getprpwent();
		if( RETVAL == NULL ){
			XSRETURN_UNDEF;
		}
    OUTPUT:
		RETVAL


PASSWD *
getprpwuid(CLASS, uid)
		char *CLASS;
		uid_t uid;
    CODE:
		RETVAL = (PASSWD*)getprpwuid(uid);
		if( RETVAL == NULL ){
			XSRETURN_UNDEF;
		}
    OUTPUT:
		RETVAL


#if defined(hpux)

PASSWD *
getprpwaid(CLASS, aid)
		char *CLASS;
		aid_t aid;
    CODE:
		RETVAL = (PASSWD*)getprpwaid(aid);
		if( RETVAL == NULL ){
			XSRETURN_UNDEF;
		}
    OUTPUT:
		RETVAL


#endif

PASSWD *
getprpwnam(CLASS, name)
		char *CLASS;
		char *name;
    CODE:
		RETVAL = (PASSWD*)getprpwnam(name);
		if( RETVAL == NULL ){
			XSRETURN_UNDEF;
		}
    OUTPUT:
		RETVAL

void
setprpwent()

void
endprpwent()

int
putprpwnam(self)
		PASSWD * self
    CODE:
		RETVAL = putprpwnam(self->ufld.fd_name, self);
    OUTPUT:
		RETVAL


INCLUDE: ./xsgen.pl |
