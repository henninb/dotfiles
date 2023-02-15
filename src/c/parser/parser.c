#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct book_struct {
   char title[50];
   char author[50];
   char subject[50];
   int book_id;
} Book;

void fileRead( char *);
void trim( char * );
void parse_book( char *, char *, Book *);
void print_book(Book *);

#define TITLE 0
#define AUTHOR 1
#define SUBJECT 2
#define BOOKID 3

int main(int argc, char* argv[]) {
  char str[] ="Where there is will, there is a way.";
  char *delim = " ";

  if (argc != 2) {
    printf("Usage: %s <fname>\n", argv[0]);
    exit(1);
  }
  fileRead(argv[1]);
  return 0;
}

void fileRead( char *file_name ) {
   FILE *fp = NULL;
   char ch;
   char *line = NULL;
   size_t len;
   Book *book;

   if ((fp = fopen(file_name, "r")) == NULL) {
      perror("Error while opening the file.\n");
      exit(2);
   }

   while ((ch = getline(&line, &len, fp)) != -1) {
     book = malloc(sizeof(Book));
     trim(line);
     parse_book( line, "|", book );
     print_book(book);
     free(book);
   }

   fclose(fp);
}

void trim( char *str ) {
    int index = -1;
    int i = 0;

    while(str[i] != '\0') {
        if(str[i] != ' ' && str[i] != '\t' && str[i] != '\n') {
            index= i;
        }
        i++;
    }

    str[index + 1] = '\0';
}

void parse_book( char *str, char *delim, Book *book ) {
  char *token = NULL;
  int idx = 0;

  token = strtok(str, delim);

  while ( token != NULL ) {
    if( idx == AUTHOR ) {
      sprintf(book->author, "%s", token);
    } else if( idx == TITLE ) {
      sprintf(book->title, "%s", token);
    } else if( idx == SUBJECT ) {
      sprintf(book->subject, "%s", token);
    } else if( idx == BOOKID ) {
        book->book_id = atoi(token);
    } else {
      printf("should never get here\n");
      exit(1);
    }
    token = strtok(NULL, delim);
    idx++;
  }
}

void print_book(Book *book ) {
    printf("\n");
    printf("%d\n", book->book_id);
    printf("%s\n", book->author);
    printf("%s\n", book->title);
    printf("%s\n", book->subject);
    printf("\n");
}
