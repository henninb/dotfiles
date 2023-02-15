#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//#include <cjson/cJSON.h>
#include <jansson.h>
#include <sys/stat.h>
#include <ctype.h>

int fileRead( char *);
//void trim( char * );
//void foo1();
void print_json_indent(int );
void print_json_aux(json_t *, int );
int fsize( char * );
json_t *load_json(const char *);
void print_json(json_t *);
void print_json_array(json_t *, int );
void print_json_object(json_t *, int );
void print_json_string(json_t *, int );
//void somefun(char *);
void process_file(char *);

#define TITLE 0
#define AUTHOR 1
#define SUBJECT 2
#define BOOKID 3

int fsize( char *fname ) {
    FILE *fp;
    if ((fp = fopen(fname, "r")) == NULL) {
      perror("Error while opening the file.\n");
      exit(2);
    }

    int prev=ftell(fp);
    fseek(fp, 0L, SEEK_END);
    int sz=ftell(fp);
    fseek(fp,prev,SEEK_SET); //go back to where we were
    fclose(fp);
    return sz;
}

void process_file( char *fname ) {
  int c;
  FILE *fp = NULL;
  int idx = 0;
  char buffer[fsize(fname)];

  memset(buffer, '\0', sizeof(buffer));
  if ((fp = fopen(fname, "r")) == NULL) {
      perror("Error while opening the file.\n");
      exit(2);
  }

  while((c=getc(fp)) != EOF) {
    if( c != '\n' ) {
      if( isprint(c)!= 0 ) {
      /* if( c >= 0 && c <=127 ) { */
        buffer[idx] = c;
        idx++;
      } else {
        printf("%c", c);
        exit(1);
      }
    } else {
    }
  }
  fclose(fp);
  printf("sizeof(%ld)\n", strlen(buffer));
  json_t *root = load_json(buffer);
  if (root) {
      print_json(root);
      json_decref(root);
  }
}

int main(int argc, char* argv[]) {
  if (argc != 2) {
    printf("Usage: %s <fname>\n", argv[0]);
    exit(1);
  }
  //process_file("json_in/chase_brian.json");
  process_file(argv[1]);
  return 0;
}

const char *json_plural(int count) {
    return count == 1 ? "" : "s";
}

void print_json_object(json_t *element, int indent) {
    size_t size;
    const char *key = NULL;
    json_t *value = NULL;

    print_json_indent(indent);
    size = json_object_size(element);

    printf("JSON Object of %ld pair%s:\n", size, json_plural(size));
    json_object_foreach(element, key, value) {
        print_json_indent(indent + 2);
        printf("JSON Key: \"%s\"\n", key);
        print_json_aux(value, indent + 2);
    }
}

void print_json_indent(int indent) {
    int i;
    for (i = 0; i < indent; i++) { putchar(' '); }
}

void print_json_string(json_t *element, int indent) {
    print_json_indent(indent);
    printf("JSON String: \"%s\"\n", json_string_value(element));
}

void print_json_array(json_t *element, int indent) {
    size_t i;
    size_t size = json_array_size(element);
    print_json_indent(indent);

    printf("JSON Array of %ld element%s:\n", size, json_plural(size));
    for (i = 0; i < size; i++) {
        print_json_aux(json_array_get(element, i), indent + 2);
    }
}

void print_json_aux(json_t *element, int indent) {
    switch (json_typeof(element)) {
    case JSON_OBJECT:
        print_json_object(element, indent);
        break;
    case JSON_ARRAY:
        print_json_array(element, indent);
        break;
    case JSON_STRING:
        print_json_string(element, indent);
        break;
    case JSON_INTEGER:
      printf("bh - json int\n");
   //     print_json_integer(element, indent);
        break;
    case JSON_REAL:
      printf("bh - json real\n");
    //    print_json_real(element, indent);
        break;
    case JSON_TRUE:
      printf("bh - json true\n");
     //   print_json_true(element, indent);
        break;
    case JSON_FALSE:
      printf("bh - json false\n");
      //  print_json_false(element, indent);
        break;
    case JSON_NULL:
      printf("bh - json null\n");
       // print_json_null(element, indent);
        break;
    default:
        fprintf(stderr, "unrecognized JSON type %d\n", json_typeof(element));
    }
}

void print_json(json_t *root) {
    print_json_aux(root, 0);
}

/* char *read_line(char *line, int max_chars) { */
/*     printf("Type some JSON > "); */
/*     fflush(stdout); */
/*     return fgets(line, max_chars, stdin); */
/* } */

json_t *load_json(const char *text) {
    json_t *root = NULL;
    json_error_t error;

    root = json_loads(text, 0, &error);

    if (root) {
        return root;
    } else {
        fprintf(stderr, "json error on line %d: %s\n", error.line, error.text);
        return (json_t *)0;
    }
}

