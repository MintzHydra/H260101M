//kontol
#include <stdio.h>
#include <conio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <dirent.h>
#include <thread>
#include <sstream>
#include <iostream>
#include <cstdint>
#include <byteswap.h>

//offset e kek kene kabieh

long int godmode = 0x1FFDAD4; long int godmode_ret = 0x1FFDAD8;
long int crit = 0x24C4BEC; long int crit_ret = 0x24C4BF0;
long int stable = 0x21C2590; long int stable_ret = 0x21C2594;
long int nograze = 0x21CDEA8;
long int noeva = 0x21DA5FC;
long int noguard = 0x21DA5F4;
long int lowdeffmdeff1 = 0x1F55170; long int lowdeffmdeff1_ret = 0x1F55174; long int lowdeffmdeff2 = 0x1F55584; long int lowdeffmdeff2_ret = 0x1F55588;
long int deff = 0x21C342C; long int deff_ret = 0x21C3430;
long int mdeff = 0x21C3480; long int mdeff_ret = 0x21C3484;
long int autoguard = 0x1E627AC; long int autoguard_ret = 0x1E627B0;
long int radius = 0x21DA61C;
long int instantcast = 0x21C70D4; long int instantcast_ret = 0x21C70D8;
long int quickdraw = 0xE46f432; long int quickdraw_ret = 0xE8A508;
long int unlockboss = 0x21ED610;
long int cutscene = 0x1C0A33C;
long int nodomination = 0x1D63304; long int nodomination_ret = 0x1D63308;
long int ailment100 = 0x24D25FC; long int ailment100_ret = 0x24D2600;
long int buffunli1 = 0x21BC3D4; long int buffunli2 = 0x21BC3E8; long int buffunli3 = 0x21BC46C;
long int cf1 = 0x21BC8B4; long int cf2 = 0x21BCC88; long int cf3 = 0x21BC840;
long int mobinvc = 0x2298FAC; long int mobinv_ret = 0x2298FB0;
long int ele = 0x2620930;
long int dmgboost = 0x24CB314;
long int aspd = 0x21C3528; long int aspd_ret = 0x21C352C;
long int critv2 = 0x20B1530; long int critv2_ret = 0x20B1534;
long int nomove = 0x21DA644; long int nomove_ret = 0x21DA648;
long int instantfinall = 0x1E378EC; long int instantfinall2 = 0x1E378F0;
long int skillburst = 0x1F24DF0;

//--------------------------

int handle;
typedef char PACKAGENAME;
long int get_module_base(int pid, const char *module_name)
{
	FILE *fp;
	long addr = 0;
	char *pch;
	char filename[32];
	char line[1024];
	snprintf(filename, sizeof(filename), "/proc/%d/maps", pid);
	fp = fopen(filename, "r");
	if (fp != NULL)
	{
		while (fgets(line, sizeof(line), fp))
		{
			if (strstr(line, module_name))
			{
				pch = strtok(line, "-");
				addr = strtoul(pch, NULL, 16);
				break;
			}
		}
		fclose(fp);
	}
	return addr;
}

int WBA_f(long int addr, float value)
{
	pwrite64(handle, &value, 4, addr);
	return 0;
}

int WBA_d(long int addr, int value)
{
	pwrite64(handle, &value, 4, addr);
	return 0;
}

uint32_t cvtr(std::string hexCode)
{
	uint32_t x;
	std::stringstream ss;
	ss << std::hex << hexCode;
	ss >> x;
	return bswap_32(x);
}

int getPID(PACKAGENAME * PackageName)
{
	DIR *dir = NULL;
	struct dirent *ptr = NULL;
	FILE *fp = NULL;
	char filepath[256];
	char filetext[128];
	dir = opendir("/proc");
	if (NULL != dir)
	{
		while ((ptr = readdir(dir)) != NULL)
		{

			if ((strcmp(ptr->d_name, ".") == 0) || (strcmp(ptr->d_name, "..") == 0))
				continue;
			if (ptr->d_type != DT_DIR)
				continue;
			sprintf(filepath, "/proc/%s/cmdline", ptr->d_name);
			fp = fopen(filepath, "r");
			if (NULL != fp)
			{
				fgets(filetext, sizeof(filetext), fp);
				if (strcmp(filetext, PackageName) == 0)
				{

					break;
				}
				fclose(fp);
			}
		}
	}
	if (readdir(dir) == NULL)
	{
		return 0;
	}
	closedir(dir);
	return atoi(ptr->d_name);
}

int killprocess(PACKAGENAME *bm)
{
    int pid = getPID(bm);
    if (pid == 0)
    {
        return -1;
    }
    char ml[32];
    sprintf(ml, "kill %d", pid);
    system(ml);
    return 0;
}

int killGG()
{
    DIR *dir = NULL;
    DIR *dirGG = NULL;
    struct dirent *ptr = NULL;
    struct dirent *ptrGG = NULL;
    char filepath[256];
    char filetext[128];
    dir = opendir("/data/data");
    int flag = 1;
    if (dir != NULL)
    {
        while (flag && (ptr = readdir(dir)) != NULL)
        {
            if ((strcmp(ptr->d_name, ".") == 0) || (strcmp(ptr->d_name, "..") == 0))
                continue;
            if (ptr->d_type != DT_DIR)
                continue;
            sprintf(filepath, "/data/data/%s/files", ptr->d_name);
            dirGG = opendir(filepath);
            if (dirGG != NULL)
            {
                while ((ptrGG = readdir(dirGG)) != NULL)
                {
                    if ((strcmp(ptrGG->d_name, ".") == 0) || (strcmp(ptr->d_name, "..") == 0))
                        continue;
                    if (ptrGG->d_type != DT_DIR)
                        continue;
                    if (strstr(ptrGG->d_name, "GG"))
                    {
                        int pid;
                        pid = getPID(ptr->d_name);
                        if (pid == 0)
                            continue;
                        else
                            killprocess(ptr->d_name);
                    }
                }
            }
        }
    }
    closedir(dir);
    closedir(dirGG);
    return 0;
}

int rebootsystem() {
	return system("su -c 'reboot'");
}


int main(int argc, char **argv)
{
	killGG();
    int gs;
    void *jg;
    FILE *fp;
    char ch, wjm[51];
    if (!(fp = fopen("/data/data/com.hydra.modz.toram/files/assets", "r"))) //Verify that the folder exists
    {
     rebootsystem(); //Restart the system(mobile phone)
  }
	std::string ValueCustom = argv[2];
	//int ValueCustom = 0;
    int Fitur = atoi(argv[1]);
    {

        int ipid = getPID("com.asobimo.toramonline");
        if (ipid == 0)
        {
            puts("Aplikasi tidak berjalan!");
            exit(1);
        }
        char lj[64];
        sprintf(lj, "/proc/%d/mem", ipid);
        handle = open(lj, O_RDWR);
        if (handle == -1)
        {
            puts("Gagal mendapatkan memory!\n");
            exit(1);
        }
        char mname[] = "libil2cpp.so";
        char mname2[] = "libxigncode.so";
        long int libbase = get_module_base(ipid, mname);
        long int libbase2 = get_module_base(ipid, mname2);
        puts("HydraModz");
        switch (Fitur)
        {
        case 1: //bypass on
            WBA_d(libbase + 0x0, 0);
            WBA_d(libbase + 0x10, 0);
            close(handle);
            break;

        case 2: //bypass off
            WBA_d(libbase + 0x0, 1179403647);
            WBA_d(libbase + 0x10, 11993091);
            close(handle);
            break;
		
		case 3: //godmode on
			WBA_d(libbase + godmode, cvtr("20008052"));
			WBA_d(libbase + godmode_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 4: //godmode off
			WBA_d(libbase + godmode, cvtr("FF8303D1"));
			WBA_d(libbase + godmode_ret, cvtr("EF3B066D"));
			close(handle);
			break;
			
		case 5: //stable on
			WBA_d(libbase + stable, cvtr("800C8052"));
			WBA_d(libbase + stable_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 6: //stable off
			WBA_d(libbase + stable, cvtr("FF0301D1"));
			WBA_d(libbase + stable_ret, cvtr("F65701A9"));
			close(handle);
			break;
			
		case 7: //nograze on
			WBA_d(libbase + nograze, cvtr("00008052"));
			close(handle);
			break;
		
		case 8: //nograze off
			WBA_d(libbase + nograze, cvtr("003840B9"));
			close(handle);
			break;
			
		case 9: //noeva on
			WBA_d(libbase + noeva, cvtr("00008052"));
			close(handle);
			break;
		
		case 10: //noeva off
			WBA_d(libbase + noeva, cvtr("005040B9"));
			close(handle);
			break;
			
		case 11: //noguard on
			WBA_d(libbase + noguard, cvtr("00008052"));
			close(handle);
			break;
		
		case 12: //noguard off
			WBA_d(libbase + noguard, cvtr("004C40B9"));
			close(handle);
			break;
			
		case 13: //lowdeffmdeff on
			WBA_d(libbase + lowdeffmdeff1, cvtr("800C8052"));
			WBA_d(libbase + lowdeffmdeff1_ret, cvtr("C0035FD6"));
			WBA_d(libbase + lowdeffmdeff2, cvtr("800C8052"));
			WBA_d(libbase + lowdeffmdeff2_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 14: //lowdeffmdeff off
			WBA_d(libbase + lowdeffmdeff1, cvtr("F70F1CF8"));
			WBA_d(libbase + lowdeffmdeff1_ret, cvtr("F65701A9"));
			WBA_d(libbase + lowdeffmdeff2, cvtr("F70F1CF8"));
			WBA_d(libbase + lowdeffmdeff2_ret, cvtr("F65701A9"));
			close(handle);
			break;
			
		case 15: //deff on
			WBA_d(libbase + deff, cvtr("00A38252"));
			WBA_d(libbase + deff_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 16: //deff off
			WBA_d(libbase + deff, cvtr("F44FBEA9"));
			WBA_d(libbase + deff_ret, cvtr("FD7B01A9"));
			close(handle);
			break;
			
		case 17: //mdeff on
			WBA_d(libbase + mdeff, cvtr("00A38252"));
			WBA_d(libbase + mdeff_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 18: //mdeff off
			WBA_d(libbase + mdeff, cvtr("F44FBEA9"));
			WBA_d(libbase + mdeff_ret, cvtr("FD7B01A9"));
			close(handle);
			break;
			
		case 19: //autoguard on
			WBA_d(libbase + autoguard, cvtr("20008052"));
			WBA_d(libbase + autoguard_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 20: //autoguard off
			WBA_d(libbase + autoguard, cvtr("FF4302D1"));
			WBA_d(libbase + autoguard_ret, cvtr("ED33026D"));
			close(handle);
			break;
			
		case 21: //radius on
			WBA_d(libbase + radius, cvtr("E0E18452"));
			close(handle);
			break;
		
		case 22: //radius off
			WBA_d(libbase + radius, cvtr("00804139"));
			close(handle);
			break;
			
		case 23: //instantcast on
			WBA_d(libbase + instantcast, cvtr("00008052"));
			WBA_d(libbase + instantcast_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 24: //instantcast off
			WBA_d(libbase + instantcast, cvtr("F44FBEA9"));
			WBA_d(libbase + instantcast_ret, cvtr("FD7B01A9"));
			close(handle);
			break;
			
		case 25: //quickdraw on
			WBA_d(libbase + quickdraw, cvtr("E0E18452"));
			WBA_d(libbase + quickdraw_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 26: //quickdraw off
			WBA_d(libbase + quickdraw, cvtr("61000034"));
			WBA_d(libbase + quickdraw_ret, cvtr("E0031F2A"));
			close(handle);
			break;
			
		case 27: //unlockboss on
			WBA_d(libbase + unlockboss, cvtr("E0E18452"));
			close(handle);
			break;
		
		case 28: //unlockboss off
			WBA_d(libbase + unlockboss, cvtr("008440B9"));
			close(handle);
			break;
			
		case 29: //cutscene on
			WBA_d(libbase + cutscene, cvtr("80008052"));
			close(handle);
			break;
		
		case 30: //cutscene off
			WBA_d(libbase + cutscene, cvtr("00084339"));
			close(handle);
			break;
			
		case 31: //nodomination on
			WBA_d(libbase + nodomination, cvtr("00008052"));
			WBA_d(libbase + nodomination_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 32: //nodomination off
			WBA_d(libbase + nodomination, cvtr("F44FBEA9"));
			WBA_d(libbase + nodomination_ret, cvtr("FD7B01A9"));
			close(handle);
			break;
			
		case 33: //ailment100 on
			WBA_d(libbase + ailment100, cvtr("20008052"));
			WBA_d(libbase + ailment100_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case 34: //ailment100 off
			WBA_d(libbase + ailment100, cvtr("FF8301D1"));
			WBA_d(libbase + ailment100_ret, cvtr("F85F02A9"));
			close(handle);
			break;
			
		case 35: //cf on
			WBA_d(libbase + cf1, cvtr("EA031E32"));
			WBA_d(libbase + cf2, cvtr("A0160011"));
			WBA_d(libbase + cf3, cvtr("1F2003D5"));
			close(handle);
			break;
		
		case 36: //cf off
			WBA_d(libbase + cf1, cvtr("EA030032"));
			WBA_d(libbase + cf2, cvtr("A0060011"));
			WBA_d(libbase + cf3, cvtr("E8030032"));
			close(handle);
			break;
			
		case 37: //buffunli on
			WBA_d(libbase + buffunli1, cvtr("00008052"));
			WBA_d(libbase + buffunli2, cvtr("00008052"));
			WBA_d(libbase + buffunli3, cvtr("1F2003D5"));
			close(handle);
			break;
		
		case 38: //buffunli off
			WBA_d(libbase + buffunli1, cvtr("004C4039"));
			WBA_d(libbase + buffunli2, cvtr("001440BD"));
			WBA_d(libbase + buffunli3, cvtr("E0031FAA"));
			close(handle);
			break;
			
		case 39: //mob invincible on
			WBA_d(libbase + mobinvc, cvtr("00008052"));
			WBA_d(libbase + mobinv_ret, cvtr("C0035FD6"));
			close(handle);
			break;
		
		case40: //mob invincible off
			WBA_d(libbase + mobinvc, cvtr("00D440BD"));
			WBA_d(libbase + mobinv_ret, cvtr("0820201E"));
			close(handle);
			break;\
			
		case 41: //fire
			WBA_d(libbase + ele, cvtr("20008052"));
			close(handle);
			break;
		
		case 42: //wota
			WBA_d(libbase + ele, cvtr("40008052"));
			close(handle);
			break;
			
		case 43: //wind
			WBA_d(libbase + ele, cvtr("60008052"));
			close(handle);
			break;
			
		case 44: //earth
			WBA_d(libbase + ele, cvtr("80008052"));
			close(handle);
			break;
			
		case 45: //light
			WBA_d(libbase + ele, cvtr("A0008052"));
			close(handle);
			break;
			
		case 46: //dark
			WBA_d(libbase + ele, cvtr("C0008052"));
			close(handle);
			break;
			
		case 47: //neutral
			WBA_d(libbase + ele, cvtr("E0008052"));
			close(handle);
			break;
			
		case 48: //ele off
			WBA_d(libbase + ele, cvtr("E0031F2A"));
			close(handle);
			break;
			
		case 49: //dmgboost on
			WBA_d(libbase + dmgboost, cvtr("19328052"));
			close(handle);
			break;
			
		case 50: //dmgboost off
			WBA_d(libbase + dmgboost, cvtr("990C8052"));
			close(handle);
			break;
			
		case 51: //aspd on
			WBA_d(libbase + aspd, cvtr(ValueCustom));
			WBA_d(libbase + aspd_ret, cvtr("C0035FD6"));
			close(handle);
			break;
			
		case 52: //aspd off
			WBA_d(libbase + aspd, cvtr("F44FBEA9"));
			WBA_d(libbase + aspd_ret, cvtr("FD7B01A9"));
			close(handle);
			break;
			
		case 53: //crit on
			WBA_d(libbase + crit, cvtr("20008052"));
			WBA_d(libbase + crit_ret, cvtr("C0035FD6"));
			close(handle);
			break;
			
		case 54: //crit off
			WBA_d(libbase + crit, cvtr("FF0301D1"));
			WBA_d(libbase + crit_ret, cvtr("F65701A9"));
			close(handle);
			break;
			
		case 55: //critv2 on
			WBA_d(libbase + critv2, cvtr(ValueCustom));
			WBA_d(libbase + critv2_ret, cvtr("C0035FD6"));
			close(handle);
			break;
			
		case 56: //critv2 off
			WBA_d(libbase + critv2, cvtr("E80F1DFC"));
			WBA_d(libbase + critv2_ret, cvtr("F44F01A9"));
			close(handle);
			break;
			
		case 57: //nomove on
			WBA_d(libbase + nomove, cvtr("00008052"));
			WBA_d(libbase + nomove_ret, cvtr("C0035FD6"));
			close(handle);
			break;
			
		case 58: //nomove off
			WBA_d(libbase + nomove, cvtr("007440B9"));
			WBA_d(libbase + nomove_ret, cvtr("C0035FD6"));
			close(handle);
			break;
			
		case 59: //instantfinall on
			WBA_d(libbase + instantfinall, cvtr("08008052"));
			WBA_d(libbase + instantfinall2, cvtr("1F2003D5"));
			close(handle);
			break;
			
		case 60: //instantfinall off
			WBA_d(libbase + instantfinall, cvtr("A8018052"));
			WBA_d(libbase + instantfinall2, cvtr("0801174B"));
			close(handle);
			break;
			
		case 61: //killprocess on
		killprocess("com.asobimo.toramonline");
		break;
		
		case 62: //skillburst on
			WBA_d(libbase + skillburst, cvtr("02E28452"));
			close(handle);
			break;
			
		case 63: //skillburst off
			WBA_d(libbase + skillburst, cvtr("820C8052"));
			close(handle);
			break;
		}
    }
}