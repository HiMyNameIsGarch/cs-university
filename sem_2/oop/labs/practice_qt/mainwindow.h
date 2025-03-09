#pragma once
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QTableWidget>
#include <QLineEdit>
#include <QPushButton>
#include <QVBoxLayout>
#include <QFormLayout>
#include <QVector>
#include <QMessageBox>
#include <QMainWindow>


class Book {
public:
    Book(QString t, QString a, int y, double p, int q): title{t}, author{a}, year{y}, price{p}, quantity{q}{};

    QString getTitle() const {return title;}
    QString getAuthor() const {return author;}
    int getYear() const {return year;}
    double getPrice() const {return price;}
    int getQuantity() const {return quantity;}
private:
    QString title;
    QString author;
    int year;
    double price;
    int quantity;
};

QT_BEGIN_NAMESPACE
namespace Ui {
    class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

    public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void onAddButtonClicked();

private:
    QTableWidget *tableWidget;
    QLineEdit *titleEdit;
    QLineEdit *authorEdit;
    QLineEdit *yearEdit;
    QLineEdit *priceEdit;
    QLineEdit *quantityEdit;
    QPushButton *addButton;

    void setupUi();
    bool validateInput();

    QVector<Book> books;

};
#endif // MAINWINDOW_H
