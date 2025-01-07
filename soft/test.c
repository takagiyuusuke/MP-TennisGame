/* Do not remove the following line. Do not remove interrupt_handler(). */
#include "crt0.c"
#include "ChrFont0.h"

void	show_ball(int posx, int posy);
void	show_player();
void	play();
int	    btn_check_0();
int	    btn_check_1();
int	    btn_check_3();
int	    kypd_scan();
void	beep(int mode);
void	led_set(int data);
void	led_blink();
void	lcd_init();
void    lcd_wait(int n);
void	lcd_putc(int y, int x, int c);
void	lcd_putc_with_color(int y, int x, int c, int r,int g, int b);
void	lcd_puts(int y, int x, char *s, int r, int g, int b);
void	lcd_sync_vbuf();
void	lcd_clear_vbuf();
void	play_song();
void 	lcd_set_vbuf_pixel(int row, int col, int r, int g, int b);

#define START   -1
#define INIT    0
#define OPENING 1
#define XXXXX   2
#define ENDING  3

int state, posx, posy, p1_pos, p2_pos, p1_pos_x, p2_pos_x;
int a, vecx, vecy, point1, point2, life1, life2;
int angle1, angle2, mode, charged;
volatile int *rte_ptr1 = (int *)0xff14;
volatile int *rte_ptr2 = (int *)0xff1c;
volatile int *kypd_ptr = (int *)0xff30;
volatile int *led_ptr = (int *)0xff08;

unsigned char lcd_vbuf[64][96];

/* interrupt_handler() is called every 100msec */
void interrupt_handler()
{
	static volatile int *led_ptr = (int *)0xff08;
    volatile int *ptr = (int *)0xff24;
	lcd_init();
	
	if (state == INIT) {
	} else if (state == OPENING) {
	} else if (state == XXXXX) {
        if (posx + vecx >= 0 && posx + vecx <= 11) {
			posx += vecx;
            if (vecx == 3) vecx = 2;
            if (vecx == -3) vecx = -2;
		} else {
            if (posx <= 0) {life1--; vecx = 1; *ptr = 7; *ptr = 0;}
            if (posx >= 11) {life2--; vecx = -1; *ptr = 7; *ptr = 0;}
			posx += vecx;
		}
		
		if (posy + vecy >= 1 && posy + vecy <= 7) {
			posy += vecy;
		} else {
			vecy *= -1;
			posy += vecy;
            *ptr = 7; *ptr = 0;
		}
        if (mode >= 3) {
            p2_pos = posy;
            if (posx == 10) {
                vecx = -1;
                vecy = angle2;
                if (angle2 <= 0) angle2 += 1;
                else angle2 = -1;
            }
        }

		show_player();
		show_ball(posx, posy);
	} else if (state == ENDING) {
	}

	lcd_sync_vbuf();
}

void lcd_digit3(int y, int x, unsigned int val)
{
	int digit3, digit2, digit1;
	digit3 = (val < 100) ? ' ' : ((val % 1000) / 100) + '0';
	digit2 = (val <  10) ? ' ' : ((val %  100) /  10) + '0';
	digit1 = (val %  10) + '0';
	lcd_putc(0, 0, digit3);
	lcd_putc(0, 1, digit2);
	lcd_putc(0, 2, digit1);
}

void main()
{
	state = START; posx = 2; posy = 4; p1_pos = 4; p2_pos = 4, p1_pos_x = 1, p2_pos_x = 10;
	vecx = 1; vecy = 1; point1 = 0; point2 = 0; life1 = 4; life2 = 4;
    angle1 = 1; angle2 = -1, mode = 0;
	rte_ptr1 = (int *)0xff14;
	rte_ptr2 = (int *)0xff1c;
	kypd_ptr = (int *)0xff30;
	led_ptr = (int *)0xff08;
    volatile int *ptr = (int *)0xff24;
	lcd_init();

	while (1) {
        if (state == START) state = INIT;
		if (state == INIT) {
            state = OPENING;
            for (int i = 0; i < 64; i ++) {
                for (int j = 0; j < 96; j ++) lcd_vbuf[i][j] = 0;
            }
            lcd_puts(0 ,0, "TENNIS GAME", 255, 255, 255);
            lcd_puts(2 ,0, "SELECT MODE", 128, 128, 128);
            lcd_puts(3 ,0, "", 128, 128, 128);
            lcd_puts(4 ,0, " 1:2P EASY", 255, 64, 64);
            lcd_puts(5 ,0, " 2:2P HARD", 64, 255, 64); 
            lcd_puts(6 ,0, " 3:1P EASY", 64, 64, 255);
            lcd_puts(7 ,0, " 4:1P HARD", 160, 160, 64);

            while (mode == 0) {
                a = kypd_scan();
                if (a == 1) {
                    mode = 1;
                } else if (a == 2) {
                    mode = 2;
                } else if (a == 3) {
                    mode = 3;
                } else if (a == 4) {
                    mode = 4;
                }
            }
		} else if (state == OPENING) {
            show_player(p1_pos, p2_pos);
		    show_ball(posx, posy);
			play_song();
            state = XXXXX;
		} else if (state == XXXXX) {
			play();
			state = ENDING;
            *ptr = 6;
            *ptr = 2;
		} else if (state == ENDING) {
            lcd_clear_vbuf();
            lcd_puts(0 ,0, "GAME IS OVER", 255, 255, 255);
            if (life1 == 0) {
                lcd_puts(2 ,0, "PLAYER2 WIN!", 0, 0, 255);
            } else {
                lcd_puts(2 ,0, "PLAYER1 WIN!", 255, 0, 0);
            }
            if (life1 >= 1) lcd_putc_with_color(5, 1,'%', 255, 0, 0);
            if (life1 >= 2) lcd_putc_with_color(5, 2,'%', 255, 0, 0);
            if (life1 >= 3) lcd_putc_with_color(5, 3,'%', 255, 0, 0);
            if (life1 >= 4) lcd_putc_with_color(5, 4,'%', 255, 0, 0);
            lcd_putc_with_color(4, 1, (point1 / 100) + '0', 255, 64, 64);
            lcd_putc_with_color(4, 2, ((point1 / 10) % 10) + '0', 255, 64, 64);
            lcd_putc_with_color(4, 3, (point1 % 10) + '0', 255, 64, 64);
            lcd_putc_with_color(4, 8, (point2 / 100) + '0', 64, 64, 255);
            lcd_putc_with_color(4, 9, ((point2 / 10) % 10) + '0', 64, 64, 255);
            lcd_putc_with_color(4, 10, (point2 % 10) + '0', 64, 64, 255);
            if (life2 >= 4) lcd_putc_with_color(5, 7,'%', 0, 0, 255);
            if (life2 >= 3) lcd_putc_with_color(5, 8,'%', 0, 0, 255);
            if (life2 >= 2) lcd_putc_with_color(5, 9,'%', 0, 0, 255);
            if (life2 >= 1) lcd_putc_with_color(5, 10,'%', 0, 0, 255);
            int k = 0;
            while (k == 0) {
                k = kypd_scan();
            }
            state = INIT; posx = 2; posy = 4; p1_pos = 4; p2_pos = 4, p1_pos_x = 1, p2_pos_x = 10;
	        vecx = 1; vecy = 1; point1 = 0; point2 = 0; life1 = 4; life2 = 4;
            angle1 = 1; angle2 = -1, mode = 0;
		}  
	}
}

void play()
{
	int mask = 0b0000000001;
    int mask2 = 0b1111111100;
    int prev1 = 0;
    int prev2 = 0;
    int temp;
    int thr = (mode == 1 || mode == 3) ? 1: 0;
    volatile int *ptr = (int *)0xff24;

	while (life1 != 0 && life2 != 0) {
		a = kypd_scan();

		if (*rte_ptr1 & mask) {
            if (posx >= p1_pos_x && posx <= p1_pos_x + thr && posy >= p1_pos - thr && posy <= p1_pos + thr && vecx < 0) {
                vecx = (point1 % 10 == 0 && point1 > 0) ? 3 : 1;
                vecy = angle1;
                if (posy == p1_pos) {point1 += 2;}
                else {point1++;}
                *ptr = 3;
                *led_ptr = 3;
                lcd_wait(100000);
                //*ptr = 5;
                *led_ptr = 0;
                lcd_wait(100000);
                //*ptr = 8;
                *led_ptr = 3;
                lcd_wait(100000);
                //*ptr = 13;
                *led_ptr = 0;
                lcd_wait(100000);
                *ptr = 0;
            }
		}
		if (*rte_ptr2 & mask) {
			if (posx >= p2_pos_x - thr && posx <= p2_pos_x && posy >= p2_pos - thr && posy <= p2_pos + thr && vecx > 0) {
                vecx = (point2 % 10 == 0 && point2 > 0) ? -3 : -1;
                vecy = angle2;
                if (posy == p2_pos) {point2 += 2;}
                else {point2++;}
                *ptr = 4;
                *led_ptr = 12;
                lcd_wait(100000);
                //*ptr = 5;
                *led_ptr = 0;
                lcd_wait(100000);
                //*ptr = 8;
                *led_ptr = 12;
                lcd_wait(100000);
                //*ptr = 13;
                *led_ptr = 0;
                lcd_wait(100000);
                *ptr = 0;
            }
		}

        if ((temp = (*rte_ptr1 & mask2) >> 2) < prev1) {
            prev1 = temp;
            if (angle1 <= 0) angle1++;
        } else if (temp > prev1) {
            prev1 = temp;
            if (angle1 >= 0) angle1--;
        }
        if ((temp = (*rte_ptr2 & mask2) >> 2) > prev2) {
            prev2 = temp;
            if (angle2 <= 0) angle2++;
        } else if (temp < prev2) {
            prev2 = temp;
            if (angle2 >= 0) angle2--;
        }

        if (a == 4) {
			p1_pos = p1_pos > 1 ? p1_pos - 1 : 1;
            lcd_wait(200000);
		} else if (a == 8) {
			p1_pos = p1_pos < 7 ? p1_pos + 1 : 7;
            lcd_wait(200000);
		} else if (a == 5) {
			p1_pos_x = p1_pos_x < 5 ? p1_pos_x + 1 : 5;
			lcd_wait(200000);
		} else if (a == 7) {
			p1_pos_x = p1_pos_x > 1 ? p1_pos_x - 1 : 1;	
			lcd_wait(200000);
		}

		
		if (a == 6) {
			p2_pos = p2_pos > 1 ? p2_pos - 1 : 1;
            lcd_wait(200000);
		} else if (a == 0xc) {
			p2_pos = p2_pos < 7 ? p2_pos + 1 : 7;
            lcd_wait(200000);
		} else if (a == 0xb) {
			p2_pos_x = p2_pos_x < 10 ? p2_pos_x + 1 : 10;
			lcd_wait(200000);
		} else if (a == 9) {
			p2_pos_x = p2_pos_x > 6 ? p2_pos_x - 1 : 6;	
			lcd_wait(200000);
		}

	}
}

void show_ball(int posx, int posy)
{   
    if (posx < 0) posx = 0;
    if (posx > 11) posx = 11;
	lcd_putc_with_color(posy, posx, '$',128, 255, 64);
    lcd_putc_with_color(posy, posx, '&',255, 255, 255);
    if (life1 >= 1) lcd_putc_with_color(0, 2,'%', 255, 0, 0);
    if (life1 >= 2) lcd_putc_with_color(0, 3,'%', 255, 0, 0);
    if (life1 >= 3) lcd_putc_with_color(0, 4,'%', 255, 0, 0);
    if (life1 >= 4) lcd_putc_with_color(0, 5,'%', 255, 0, 0);
    lcd_putc_with_color(0, 0, (point1 / 10) % 10 + '0', 255, 64, 64);
    lcd_putc_with_color(0, 1, (point1 % 10) + '0', 255, 64, 64);
    lcd_putc_with_color(0, 10, (point2 / 10) % 10 + '0', 64, 64, 255);
    lcd_putc_with_color(0, 11, (point2 % 10) + '0', 64, 64, 255);
    if (life2 >= 4) lcd_putc_with_color(0, 6,'%', 0, 0, 255);
    if (life2 >= 3) lcd_putc_with_color(0, 7,'%', 0, 0, 255);
    if (life2 >= 2) lcd_putc_with_color(0, 8,'%', 0, 0, 255);
    if (life2 >= 1) lcd_putc_with_color(0, 9,'%', 0, 0, 255);
}

void show_player()
{
    lcd_clear_vbuf();
    lcd_putc_with_color(p1_pos, p1_pos_x, '#', 255, 64, 64);
    lcd_putc_with_color(p2_pos, p2_pos_x, '"', 64, 64, 255);
    int x = 8 * p1_pos_x + 4;
    int y = 8 * p1_pos + 3;
    int length = 11;
    if (angle1 == 0) length += 3;
    for (int i = 3; i < length; i ++) {
        if (y + i * angle1 >= 8 && y + i * angle1 <= 64) lcd_set_vbuf_pixel(y + i * angle1,x + i,255,0,0);
    }
    x = 8 * p2_pos_x + 4;
    y = 8 * p2_pos + 3;
    length = 11;
    if (angle2 == 0) length += 3;
    for (int i = 3; i < length; i ++) {
        if (y + i * angle2 >= 8 && y + i * angle2 <= 64) lcd_set_vbuf_pixel(y + i * angle2,x - i,0,0,255);
    }
}

/*
* Switch functions
*/
int btn_check_0()
{
        volatile int *sw_ptr = (int *)0xff04;;
        return (*sw_ptr & 0x10) ? 1 : 0;
}

int btn_check_1()
{
        volatile int *sw_ptr = (int *)0xff04;;
        return (*sw_ptr & 0x20) ? 1 : 0;
}

int btn_check_3()
{
        volatile int *sw_ptr = (int *)0xff04;;
        return (*sw_ptr & 0x80) ? 1 : 0;
}

/*
* LED functions
*/
void led_set(int data)
{
        volatile int *led_ptr = (int *)0xff08;
        *led_ptr = data;
}

void led_blink()
{
        led_set(0xf);               /* Turn on */
        for (int i = 0; i < 300000; i++);   /* Wait */
        led_set(0x0);               /* Turn off */
        for (int i = 0; i < 300000; i++);   /* Wait */
        led_set(0xf);               /* Turn on */
        for (int i = 0; i < 300000; i++);   /* Wait */
        led_set(0x0);               /* Turn off */
}

/*
* LCD functions
*/
void lcd_wait(int n)
{
        for (int i = 0; i < n; i++);
}

void lcd_cmd(unsigned char cmd)
{
       volatile int *lcd_ptr = (int *)0xff0c;
       *lcd_ptr = cmd;
       lcd_wait(1000);
}

void lcd_data(unsigned char data)
{
       volatile int *lcd_ptr = (int *)0xff0c;
       *lcd_ptr = 0x100 | data;
       lcd_wait(200);
}

void lcd_pwr_on()
{
       volatile int *lcd_ptr = (int *)0xff0c;
       *lcd_ptr = 0x200;
       lcd_wait(700000);
}

void lcd_init()
{
       lcd_pwr_on();   /* Display power ON */
       lcd_cmd(0xa0);  /* Remap & color depth */
       lcd_cmd(0x20);
       lcd_cmd(0x15);  /* Set column address */
       lcd_cmd(0);
       lcd_cmd(95);
       lcd_cmd(0x75);  /* Set row address */
       lcd_cmd(0);
       lcd_cmd(63);
       lcd_cmd(0xaf);  /* Display ON */
}

void lcd_set_vbuf_pixel(int row, int col, int r, int g, int b)
{
       r >>= 5; g >>= 5; b >>= 6;
       lcd_vbuf[row][col] = ((r << 5) | (g << 2) | (b << 0)) & 0xff;
}

void lcd_clear_vbuf()
{
    for (int row = 0; row < 64; row++) {
        for (int col = 0; col < 96; col++) {
            if ((col == 47 || col == 0 || col == 95) && row >= 9 || row == 9 || row == 63)
                lcd_vbuf[row][col] = 255;
            else {
                if (row >= 10) lcd_vbuf[row][col] = 0b00000100;
                else lcd_vbuf[row][col] = 0;
            }
        }
    }
}

void lcd_sync_vbuf()
{
        for (int row = 0; row < 64; row++)
                for (int col = 0; col < 96; col++)
                        lcd_data(lcd_vbuf[row][col]);
}

void lcd_putc(int y, int x, int c)
{
        for (int v = 0; v < 8; v++)
                for(int h = 0; h < 8; h++)
                        if((font8x8[(c - 0x20) * 8 + h] >> v) & 0x01)
                                lcd_set_vbuf_pixel(y * 8 + v, x * 8 + h, 0, 255, 0);
}

void lcd_putc_with_color(int y, int x, int c, int r, int g, int b)
{
        for (int v = 0; v < 8; v++)
                for(int h = 0; h < 8; h++)
                        if((font8x8[(c - 0x20) * 8 + h] >> v) & 0x01)
                                lcd_set_vbuf_pixel(y * 8 + v, x * 8 + h, r, g, b);
}

void lcd_puts(int y, int x, char *str, int r, int g, int b)
{
        for (int i = x; i < 12; i++)
                if (str[i] < 0x20 || str[i] > 0x7f)
                        break;
                else
                        lcd_putc_with_color(y, i, str[i], r, g, b);
}

int kypd_scan()
{
        volatile int *iob_ptr = (int *)0xff18;

        *iob_ptr = 0x07;                /* 0111 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0x1;
        if ((*iob_ptr & 0x40) == 0)
                return 0x4;
        if ((*iob_ptr & 0x20) == 0)
                return 0x7;
        if ((*iob_ptr & 0x10) == 0)
                return 0x0;

        *iob_ptr = 0x0b;                /* 1011 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0x2;
        if ((*iob_ptr & 0x40) == 0)
                return 0x5;
        if ((*iob_ptr & 0x20) == 0)
                return 0x8;
        if ((*iob_ptr & 0x10) == 0)
                return 0xf;

        *iob_ptr = 0x0d;                /* 1101 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0x3;
        if ((*iob_ptr & 0x40) == 0)
                return 0x6;
        if ((*iob_ptr & 0x20) == 0)
                return 0x9;
        if ((*iob_ptr & 0x10) == 0)
                return 0xe;

        *iob_ptr = 0x0e;                /* 1110 */
        for (int i = 0; i < 1; i++);    /* Wait */
        if ((*iob_ptr & 0x80) == 0)
                return 0xa;
        if ((*iob_ptr & 0x40) == 0)
                return 0xb;
        if ((*iob_ptr & 0x20) == 0)
                return 0xc;
        if ((*iob_ptr & 0x10) == 0)
                return 0xd;
        return 0;
}

void play_song()
{
        volatile int *iob_ptr = (int *)0xff24;
        *iob_ptr = 5;
        *iob_ptr = 0;
        lcd_wait(13000);
        *iob_ptr = 1;
}
