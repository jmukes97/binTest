//
//  ViewController.m
//  binTest
//
//  Created by NCS Student on 4/6/18.
//  Copyright © 2018 NCS Student. All rights reserved.
//
#define FLAG_PLATFORMIZE (1 << 1)
#import "ViewController.h"
#include <CoreData/CoreData.h>
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statuis;

@end

@implementation ViewController


void platformize_me() {

    void* handle = dlopen("/usr/lib/libjailbreak.dylib", RTLD_LAZY);
    if (!handle) return;
    
    // Reset errors
    dlerror();
    typedef void (*fix_entitle_prt_t)(pid_t pid, uint32_t what);
    fix_entitle_prt_t ptr = (fix_entitle_prt_t)dlsym(handle, "jb_oneshot_entitle_now");
    
    const char *dlsym_error = dlerror();
    if (dlsym_error) return;
    
    ptr(getpid(), FLAG_PLATFORMIZE);
}

void patch_setuid() {
    void* handle = dlopen("/usr/lib/libjailbreak.dylib", RTLD_LAZY);
    if (!handle)
        return;
    
    // Reset errors
    dlerror();
    typedef void (*fix_setuid_prt_t)(pid_t pid);
    fix_setuid_prt_t ptr = (fix_setuid_prt_t)dlsym(handle, "jb_oneshot_fix_setuid_now");
    
    const char *dlsym_error = dlerror();
    if (dlsym_error)
        return;
    
    ptr(getpid());
}


- (IBAction)Go:(id)sender {
    if(setuid(0) == 0){
        _statuis.text=@"Got Root";
    }
    else{
        _statuis.text=@"Failed";
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    platformize_me();
    patch_setuid();
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
