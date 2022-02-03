class Task {

  String description;
  bool isDone;
  bool isNew;

  Task({required this.description, this.isNew = false, this.isDone = false});

  void setNewDescription(value) {
    description = value;
  }

  void setAsNotNew() {
    isNew = false;
  }

  void toggleDone() {
    isDone = !isDone;
  }
}