/// A wrapper of [List] that implements fixed-sized queue where
/// elements will be removed from the front if it is full.
class FixedSizedQueue<E> {
  FixedSizedQueue(int size) {
    queue = List();
    this.size = size;
  }

  List<E> queue;
  int size;

  void add(E element) {
    /// Removes the first element if the maximum size is reached.
    if (queue.length == size) {
      queue.removeAt(0);
    }
    queue.add(element);
  }

  void addAll(Iterable<E> iterable) {
    queue.addAll(iterable);

    /// Removes the first n elements if exceeding the maximum size.
    if (queue.length > size) {
      queue.removeRange(0, queue.length - size);
    }
  }

  int get length => queue.length;
  E operator [](int i) => queue[i];
  List<E> toList() => queue;
}
