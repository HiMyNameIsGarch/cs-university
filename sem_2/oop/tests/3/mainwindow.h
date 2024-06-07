#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTableWidget>
#include <QLineEdit>
#include <QPushButton>
#include <QVBoxLayout>
#include <QFormLayout>
#include <QVector>
#include <QMessageBox>

QT_BEGIN_NAMESPACE
namespace Ui {
    class MainWindow;
}
QT_END_NAMESPACE

class CardWidget : public QWidget {
    Q_OBJECT

public:
    explicit CardWidget(int cardValue, QWidget *parent = nullptr);

private:
    QLabel *cardLabel;
};

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void draw();
    void reset();

private:

    // Buttons for actions
    QPushButton *drawCardButton;
    QPushButton *resetButton;
    QPushButton *stayButton;

    // Labels
    QLabel *scoreLabel;
    QLabel *dealerLabel;
    QLabel *statusLabel;

    // Layouts
    QVBoxLayout *playerCardsLayout;
    QVBoxLayout *dealerCardsLayout;

    // Data
    int playerScore;
    int dealerScore;

    void setupUi();
    void endStatus(std::string status);
    int generateCardValue();
    void stayTurn();

};
#endif // MAINWINDOW_H
