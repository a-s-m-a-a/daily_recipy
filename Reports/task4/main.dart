
void main(){
  //task 1
  List<int> list1 =  [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
  list1.retainWhere((element) => element <5);
  print(list1);
  // task 2
  List<int> a =  [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];
  List<int> b =  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  List<int> comm = [];
  a = a.toSet().toList();
  b = b.toSet().toList();
  for (var i=0; i <a.length ; i++) {
    for (var j=0 ; j< b.length; j++) {
      if (a[i] == b[j])
      {
        comm.add(a[i]);
      }
    }
  }
print(comm);

//task 3
List<int> e = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
List<int> evenn =[];
for (var i=0; i < e.length; i++){
  if(e[i] % 2 ==0)
{
  evenn.add(e[i]);
}
}
print(evenn);
//task4
List<int> l =  [5, 10, 15, 20, 25];
print(l.first);
print(l.last);

}
