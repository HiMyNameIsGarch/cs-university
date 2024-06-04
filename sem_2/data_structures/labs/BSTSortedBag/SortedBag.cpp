#include "SortedBag.h"
#include "SortedBagIterator.h"

SortedBag::SortedBag(Relation r) : root(nullptr), relation(r) {}

void SortedBag::add(TComp e) {
    recursiveAdd(root, e);
}

// Recursive helper function to add an element to the sorted bag
void SortedBag::recursiveAdd(BSTNode*& node, TElem e) {
    if (node == nullptr) {
        node = new BSTNode(e, 1);
        return;
    }

    if (node->element == e) {
        node->frequency++;
        return;
    }

    if (relation(node->element, e))
        recursiveAdd(node->left, e);
    else if (relation(e, node->element))
        recursiveAdd(node->right, e);
}

bool SortedBag::remove(TComp e) {
    return recursiveRemove(root, e);
}

// Recursive helper function to remove an element from the sorted bag
bool SortedBag::recursiveRemove(BSTNode*& node, TElem e) {
    if (node == nullptr)
        return false;

    if (node->element == e) {
        if (node->frequency > 1) {
            node->frequency--;
            return true;
        } else {
            if (node->left == nullptr) {
                BSTNode* temp = node->right;
                delete node;
                node = temp;
            } else if (node->right == nullptr) {
                BSTNode* temp = node->left;
                delete node;
                node = temp;
            } else {
                BSTNode* minRight = findMin(node->right);
                node->element = minRight->element;
                node->frequency = minRight->frequency;
                recursiveRemove(node->right, minRight->element);
            }
            return true;
        }
    }

    if (relation(node->element, e))
        return recursiveRemove(node->left, e);
    else if (relation(e, node->element))
        return recursiveRemove(node->right, e);
    return recursiveRemove(node->right, e);
}

// Find the minimum element in the subtree rooted at node
BSTNode* SortedBag::findMin(BSTNode* node) const {
    if (node == nullptr)
        return nullptr;

    while (node->left != nullptr)
        node = node->left;

    return node;
}


bool SortedBag::search(TComp elem) const {
    return recursiveSearch(root, elem);
}

// Recursive helper function to search for an element in the sorted bag
bool SortedBag::recursiveSearch(BSTNode* node, TElem e) const {
    if (node == nullptr)
        return false;

    if (node->element == e)
        return true;

    if (relation(node->element, e))
        return recursiveSearch(node->left, e);
    if (relation(e, node->element))
        return recursiveSearch(node->right, e);
    return false;
}

int SortedBag::nrOccurrences(TComp elem) const {
    return recursiveNrOccurrences(root, elem);
}

// Recursive helper function to return the number of occurrences for an element in the sorted bag
int SortedBag::recursiveNrOccurrences(BSTNode* node, TElem e) const {
    if (node == nullptr)
        return 0;

    if (node->element == e)
        return node->frequency;

    if (e < node->element)
        return recursiveNrOccurrences(node->left, e);
    else // e > node->element
        return recursiveNrOccurrences(node->right, e);
}

int SortedBag::size() const {
    return recursiveSize(root);
}

// Recursive helper function to return the number of elements in the sorted bag
int SortedBag::recursiveSize(BSTNode* node) const {
    if (node == nullptr)
        return 0;

    return node->frequency + recursiveSize(node->left) + recursiveSize(node->right);
}


bool SortedBag::isEmpty() const {
     return root == nullptr;
}


SortedBagIterator SortedBag::iterator() const {
	return SortedBagIterator(*this);
}


SortedBag::~SortedBag() {
    deleteSubtree(root);
}

// Helper function to delete the subtree rooted at node
void SortedBag::deleteSubtree(BSTNode* node) {
    if (node == nullptr)
        return;

    deleteSubtree(node->left);
    deleteSubtree(node->right);
    delete node;
}
