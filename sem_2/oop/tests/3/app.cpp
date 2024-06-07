#include "mainwindow.h"

#include <QFormLayout>
#include <QLabel>
#include <QPushButton>
#include <QApplication>

constexpr int MAX_WIDTH = 800;
constexpr int MAX_HEIGHT = 800;

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow *w = new MainWindow;
    w->setFixedSize(MAX_WIDTH, MAX_HEIGHT);
    w->show();
    return a.exec();
}
