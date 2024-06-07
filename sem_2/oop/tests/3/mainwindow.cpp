#include "mainwindow.h"
#include "QDebug"

#include "mainwindow.h"
#include <QThread>
#include <QVBoxLayout>
#include <QPushButton>
#include <QLabel>
#include <QDebug>
#include <QRandomGenerator>

constexpr int BLACK_JACK = 21;
constexpr int MAX_DEALER_SCORE = 17;
constexpr int MAX_CARD_VALUE = 11;

// CardWidget Implementation
CardWidget::CardWidget(int cardValue, QWidget *parent) : QWidget(parent) {
    QVBoxLayout *layout = new QVBoxLayout(this);
    cardLabel = new QLabel(QString::number(cardValue), this);
    cardLabel->setAlignment(Qt::AlignCenter);
    cardLabel->setFrameStyle(QFrame::Box | QFrame::Raised);

        // Style the card
    cardLabel->setStyleSheet(
        "background-color: white; "
        "border: 2px solid black; "
        "border-radius: 10px; "
        "font-size: 24px; "
        "color: black; "
        "padding: 5px;"
    );

    layout->addWidget(cardLabel);
    setLayout(layout);

    // Style the widget container for some shadow effect
    setStyleSheet(
        "background-color: lightgray; "
        "border: 1px solid gray; "
        "border-radius: 10px; "
        "padding: 2px;"
    );

    setFixedSize(80, 110); // Adjust to fit the card size with padding
}

MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent), playerScore(0), dealerScore(0){
    setupUi();
}

void MainWindow::setupUi()
{
    QWidget *centralwidget = new QWidget(this);
    setCentralWidget(centralwidget);

    QVBoxLayout *mainLayout = new QVBoxLayout();
    QHBoxLayout *cardsLayout = new QHBoxLayout();

    // Player cards on the left
    QVBoxLayout *playerLayout = new QVBoxLayout();
    QLabel *playerLabel = new QLabel("Player", this);
    playerLabel->setStyleSheet("font-size: 18px; color: blue;");
    playerLayout->addWidget(playerLabel);

    playerCardsLayout = new QVBoxLayout();
    playerLayout->addLayout(playerCardsLayout);

    cardsLayout->addLayout(playerLayout);
    // draw button
    drawCardButton = new QPushButton("Draw", this);
    drawCardButton->setStyleSheet("background-color: green; color: white; font-size: 18px; padding: 10px;");
    mainLayout->addWidget(drawCardButton);

    // reset button
    resetButton = new QPushButton("Reset", this);
    resetButton->setStyleSheet("background-color: red; color: white; font-size: 18px; padding: 10px;");
    resetButton->setEnabled(false);
    resetButton->hide();
    mainLayout->addWidget(resetButton);

    stayButton = new QPushButton("Stay", this);
    stayButton->setStyleSheet("background-color: blue; color: white; font-size: 18px; padding: 10px;");
    mainLayout->addWidget(stayButton);

    // Add a spacer between player and dealer cards
    cardsLayout->addStretch();

    // Dealer cards on the right
    QVBoxLayout *dealerLayout = new QVBoxLayout();
    QLabel *dealerTitleLabel = new QLabel("Dealer", this);
    dealerTitleLabel->setStyleSheet("font-size: 18px; color: red;");
    dealerLayout->addWidget(dealerTitleLabel);

    dealerCardsLayout = new QVBoxLayout();
    dealerLayout->addLayout(dealerCardsLayout);

    cardsLayout->addLayout(dealerLayout);

    mainLayout->addLayout(cardsLayout);

    // Add game status label in the middle
    statusLabel = new QLabel("Game Status: Ongoing", this);
    statusLabel->setStyleSheet("font-size: 18px; color: black; text-align: center;");
    mainLayout->addWidget(statusLabel, 0, Qt::AlignCenter);

    // Add score labels below the game status
    QHBoxLayout *scoreLayout = new QHBoxLayout();
    scoreLabel = new QLabel("Player Score: 0", this);
    scoreLabel->setStyleSheet("font-size: 18px; color: blue;");
    scoreLayout->addWidget(scoreLabel, 0, Qt::AlignLeft);

    dealerLabel = new QLabel("Dealer Score: 0", this);
    dealerLabel->setStyleSheet("font-size: 18px; color: red;");
    scoreLayout->addWidget(dealerLabel, 0, Qt::AlignRight);

    mainLayout->addLayout(scoreLayout);

    centralwidget->setLayout(mainLayout);

    // Set window style
    setStyleSheet("background-color: lightgray;");

    connect(resetButton, &QPushButton::clicked, this, &MainWindow::reset);
    connect(drawCardButton, &QPushButton::clicked, this, &MainWindow::draw);
    connect(stayButton, &QPushButton::clicked, this, &MainWindow::stayTurn);
}

void MainWindow::reset()
{
    playerScore = 0;
    dealerScore = 0;
    scoreLabel->setText("Player Score: 0");
    dealerLabel->setText("Dealer Score: 0");
    statusLabel->setStyleSheet("color: black;");
    statusLabel->setText("Game Status: Ongoing");

    // Clear player cards
    QLayoutItem *item;
    while ((item = playerCardsLayout->takeAt(0)) != nullptr) {
        delete item->widget();
        delete item;
    }

    // Clear dealer cards
    while ((item = dealerCardsLayout->takeAt(0)) != nullptr) {
        delete item->widget();
        delete item;
    }

    drawCardButton->setEnabled(true);
    resetButton->setEnabled(false);
    resetButton->hide();
}

void MainWindow::draw()
{
    int card = generateCardValue();
    playerScore += card;
    scoreLabel->setText("Player Score: " + QString::number(playerScore));

    playerCardsLayout->addWidget(new CardWidget(card));

    qDebug() << "Player drew a card with value:" << card;

    if (playerScore > BLACK_JACK) {
        endStatus("Player Busts! Dealer Wins!");
        return;
    }

    // Dealer logic: Dealer draws a card if dealer's score is below 17
    if (dealerScore < MAX_DEALER_SCORE) {
        card = generateCardValue();
        dealerScore += card;
        dealerLabel->setText("Dealer Score: " + QString::number(dealerScore));
        dealerCardsLayout->addWidget(new CardWidget(card));
        qDebug() << "Dealer drew a card with value:" << card;

        if (dealerScore > BLACK_JACK) {
            endStatus("Dealer Busts! Player Wins!");
            return;
        }
    }

    // Check for win condition
    if (playerScore == BLACK_JACK) {
        endStatus("Player Wins with Blackjack");
        statusLabel->setStyleSheet("color: green;");

    } else if (dealerScore == BLACK_JACK) {
        statusLabel->setStyleSheet("color: red;");
        endStatus("Dealer Wins with Blackjack");

    } else if (playerScore > dealerScore && dealerScore >= MAX_DEALER_SCORE) {
        statusLabel->setStyleSheet("color: green;");
        endStatus("Player Wins!");

    } else if (dealerScore > playerScore && dealerScore >= MAX_DEALER_SCORE) {
        statusLabel->setStyleSheet("color: red;");
        endStatus("Dealer Wins!");
    }
}


void MainWindow::endStatus(std::string status)
{
    statusLabel->setText("Game Status: " + QString::fromStdString(status));
    // make status bigger
    statusLabel->setStyleSheet("font-size: 24px; color: red; text-align: center;");
    drawCardButton->setEnabled(false);
    // enable the reset button
    resetButton->show();
    resetButton->setEnabled(true);
}

void MainWindow::stayTurn() {
    while (dealerScore < MAX_DEALER_SCORE) {
        // sleep between 1 and 3 seconds
        QThread::msleep(QRandomGenerator::global()->bounded(1000, 3000));
        int card = generateCardValue();
        dealerScore += card;
        // display dealerScore
        dealerLabel->setText("Dealer Score: " + QString::number(dealerScore));
        dealerCardsLayout->addWidget(new CardWidget(card));
        qDebug() << "Dealer drew a card with value:" << card;

        if (dealerScore > BLACK_JACK) {
            endStatus("Dealer Busts! Player Wins!");
            return;
        }
    }
    if (dealerScore == BLACK_JACK)
        endStatus("Dealer Wins with Blackjack");
    else if (playerScore == BLACK_JACK)
        endStatus("Player Wins with Blackjack");
    else if (dealerScore < playerScore)
        endStatus("Player Wins!");
    else if (playerScore < dealerScore)
        endStatus("Dealer Wins!");
    else if (playerScore == dealerScore)
        endStatus("It's a tie!");

}

int MainWindow::generateCardValue()
{
    return QRandomGenerator::global()->bounded(1, MAX_CARD_VALUE);
}


MainWindow::~MainWindow()
{
    delete playerCardsLayout;
    delete dealerCardsLayout;
    delete scoreLabel;
    delete dealerLabel;
    delete statusLabel;
    delete drawCardButton;
    delete resetButton;
}
