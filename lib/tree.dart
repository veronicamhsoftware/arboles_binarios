import 'dart:ffi';

import 'node.dart';
import 'dart:math' show max;

class Tree {
  //Define attributes
  Node? root;
  // Insert new Node in the Tree 
  void insert_node(int n)
    {
      if (root != null) {
        root!.insert(new Node(n));            
      } else {
        this.root = new Node(n);  
      }
    }

  // Return height of Tree
  int height(Node? n) {
    var right =  n?.right ?? 0;
    var left = n?.left ?? 0;
    int altRight = (right != 0 ? 1 + height(n!.right) : 0);    
    int altLeft = (left != 0 ? 1 + height(n!.left) : 0);
    return max(altRight, altLeft);
  }

  // Deselect all nodes
  void reset_selected(Node? n) {    
    var right =  n?.right ?? 0;
    var left = n?.left ?? 0;
    if (n != null) {
      n!.selected = false;
    }    
    if (right!=0){
      reset_selected(n!.right);
    }
    if (left!=0){
      reset_selected(n!.left);
    }  
  }

  // Delete Tree
  void resetTree() {
    root = null;    
  }

  // Find a node with the element
  bool exist(int element) {
    reset_selected(root);
    return exist_node(root, element);
  }

  bool exist_node(Node? node, int element) {
    if (node == null) {
      return false;
    }
    if (node.valueN == element) {
      node.selected = true;
      return true;
    } else if (element < node.valueN) {
      return exist_node(node.left, element);
    } else {
      return exist_node(node.right, element);
    }
  }
  // Delete a node
  void delete(int element) {
    reset_selected(this.root);
    this.root = delete_node(this.root, element);
  }
  Node? delete_node(Node? node, int element) {
    if (node == null){
      return node;
    }
    if(element > node.valueN){
      node.setRight(delete_node(node.right, element));
    }else if(element < node.valueN){
      node.setLeft(delete_node(node.left, element));
    }else{
      if(node.left == null && node.right == null){
        node = null;
      }else if(node.right != null){
        node.valueN = next(node);
        node.setRight(delete_node(node.right, node.valueN));        
      }else{
        node.valueN = previous(node);
        node.setLeft(delete_node(node.left, node.valueN));        
      }
    }
    return node;    
  }

  // Get next node
  int next(Node? node) {
    node = node!.right;
    while(node!.left != null){
      node = node.left; 
    }
    return node!.valueN;    
  }
  // Get previous node
  int previous(Node? node) {
    node = node!.left;
    while(node!.right != null){
      node = node.right;
    }
    return node!.valueN;    
  }
}
