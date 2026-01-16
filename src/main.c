#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

extern char name1[] ;	
extern char name2[] ;
extern char name3[] ;
extern int id1 ;
extern int id2 ;
extern int id3 ;
extern int sum ;

int main() {
	int16_t frame[480][640] ;
	int max_cX = -700, min_cY = 270, cY_step = -5 ;
	int cY, fd ;

	printf( "Function1: Name\n" ) ;
	name() ;
	printf( "Function2: ID\n" ) ;
	id() ;
	printf( "Main Function:\n" ) ;
	printf( "*****Print All*****\n" ) ;
	printf( "Team 05\n" ) ;
	printf( "%d  %s\n", id1, name1 ) ;
	printf( "%d  %s\n", id2, name2 ) ;
	printf( "%d  %s\n", id3, name3 ) ;
	printf( "ID Summation = %d\n", sum ) ;
	printf( "*****End Print*****\n" ) ;
	
	printf( "\n***** Please enter p to draw Julia Set animation *****\n" ) ;
	while ( getchar() != 'p' ) {}
	system( "clear" ) ;

	fd = open( "/dev/fb0", ( O_RDWR | O_SYNC ) ) ;
	if ( fd < 0 ) {	
		printf( "Frame Buffer Device Open Error!!\n" ) ;	
	}
	else {
		for ( cY = 400 ; cY >= min_cY ; cY = cY + cY_step ) {
			drawJuliaSet( cY, frame ) ;  // frame is call by reference
			write( fd, frame, sizeof(int16_t) * 480 * 640 ) ;
			lseek( fd, 0, SEEK_SET ) ;
		}
		
		printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" ) ;
		printf( "by Team 05\n" ) ;
		printf( "%d  %s\n", id1, name1 ) ;
		printf( "%d  %s\n", id2, name2 ) ;
		printf( "%d  %s\n", id3, name3 ) ;
		close( fd ) ;
	}

	while ( getchar() != 'p' ) {}
	return 0 ;
}
