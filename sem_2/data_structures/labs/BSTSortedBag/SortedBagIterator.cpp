#include "SortedBagIterator.h"
#include "SortedBag.h"
// #include <exception>
#include <stdexcept>

SortedBagIterator::SortedBagIterator(const SortedBag& b) : bag(b) {
    current = findMinNode(bag.root); // Start from the minimum node
    initializeStack(); // Initialize the stack with the path to the minimum node
}

void SortedBagIterator::initializeStack() {
    BSTNode* node = bag.root;
    while (node != nullptr) {
        stack.push(node);
        node = node->left;
    }
}

// Private helper function to find the minimum node in a subtree
BSTNode* SortedBagIterator::findMinNode(BSTNode* node) const {
    if (node == nullptr)
        return nullptr;

    while (node->left != nullptr)
        node = node->left;

    return node;
}

// Return the current element in the iterator
TComp SortedBagIterator::getCurrent() {
    if (!valid()) {
        throw std::runtime_error("Iterator is not valid");
    }

    return current->element;
}

bool SortedBagIterator::valid() {
    return current != nullptr;
}

// Move the iterator to the next element in sorted order
void SortedBagIterator::next() {
    if (!valid()) {
        throw std::runtime_error("Iterator is not valid");
    }

    // If the current node has a right subtree, move to its minimum node
    if (current->right != nullptr) {
        current = current->right;
        while (current != nullptr) {
            stack.push(current);
            current = current->left;
        }
    } else {
        // Otherwise, move up the stack until we find a node that hasn't been visited
        BSTNode* prev = stack.top();
        stack.pop();
        while (!stack.empty() && stack.top()->right == prev) {
            prev = stack.top();
            stack.pop();
        }
        // If the stack is not empty, the top of the stack is the next node
        if (!stack.empty()) {
            current = stack.top();
        } else {
            current = nullptr; // Finished traversing
        }
    }
}

// Move the iterator to the first element in sorted order
void SortedBagIterator::first() {
    current = findMinNode(bag.root); // Start from the minimum node
    while (!stack.empty()) {
        stack.pop(); // Clear the stack
    }
    initializeStack(); // Initialize the stack with the path to the minimum node
}
