#include <iostream>
#include "include/textFile.h"
#include "include/folder.h"

int main() {
    // create some files and some folders
    TextFile *f1 = new TextFile("file1.txt", FileType::TEXT);
    TextFile *f2 = new TextFile("file2.txt", FileType::TEXT);
    // create a folder
    Folder *folder = new Folder("folder1");
    // add files to the folder
    folder->addComponent(f1);
    folder->addComponent(f2);
    // create another folder
    // add the first folder to the second folder
    // display the second folder
    Folder *folder2 = new Folder("folder2");
    folder2->addComponent(folder);
    folder2->display();
    // clean up
    // the destructor of folder2 will delete folder
    // the destructor of folder will delete f1 and f2
    // so we only need to delete folder2
    delete folder2;
}

