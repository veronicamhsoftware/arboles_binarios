class Node {
  //Define attributes
  int valueN;
  bool? selected;
  Node? left;
  Node? right;
  //Builder
  Node(this.valueN);

  //Insert new Node
  void insert(Node? root) {
    if (root != null){
      if (root.valueN < valueN) {      
      if (left != null) {
          left!.insert(root);
      } else {          
          left = root;
      }
    } else {            
        if (right != null) {
          right!.insert(root);            
        } else {
           right = root; 
        }
    }
    }
    
  }
  void setRight(Node? n_right) {
      this.right = n_right;
  }
  void setLeft(Node? n_left) {
      this.left = n_left;
  }
}

