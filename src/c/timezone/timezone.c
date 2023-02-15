#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct timezone_struct {
   char tz[25];
   char offset[25];
   //int offset;
} Timezone;

int get_timezone( Timezone *timezone ) {
  time_t rawtime = 0;
  struct tm *ptm = NULL;

  if( (rawtime = time(NULL)) == -1 ) {
    return -1;
  }

  if ((ptm = localtime(&rawtime)) == NULL) {
    return -2;
  }

  //printf("is dst: %d\n", ptm->tm_isdst);
  strftime(timezone->tz, sizeof(timezone->tz), "%Z", ptm);
  strftime(timezone->offset, sizeof(timezone->offset), "%z", ptm);
  return 0;
}

int main(int argc, char *argv[]) {
  Timezone *timezone;

  timezone = malloc(sizeof(Timezone));
  if( get_timezone(timezone) == 0 ) {
    printf("TZ=<%s>\n", timezone->tz);
    printf("offset=<%s>\n", timezone->offset);
  }
  return 0;
}
