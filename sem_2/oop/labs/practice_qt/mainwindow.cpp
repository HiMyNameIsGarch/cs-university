#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent) {
    setupUi();
}

void MainWindow::setupUi()
{
    QWidget *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);

    QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
    // QStringList header { "Title", "Author", "Year", "Price", "Quantity"};

    tableWidget = new QTableWidget(0,5, this);
    // tableWidget->setHorizontalHeader(header);
    tableWidget->setAlternatingRowColors(true);
    tableWidget->setWordWrap(true);
}

MainWindow::~MainWindow()
{
}
