#include "mainwindow.h"

#include <QLineEdit>
#include <QFormLayout>
#include <QLabel>
#include <QPushButton>
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow *main = new MainWindow();
    main->show();
    return a.exec();
}
