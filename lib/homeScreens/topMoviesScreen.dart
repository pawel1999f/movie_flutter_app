import 'package:flutter/material.dart';
import '../MovieDatabase.dart';

final database = DatabaseProvider();

class TopMoviesScreen extends StatefulWidget {
  const TopMoviesScreen({Key? key}) : super(key: key);

  @override
  State<TopMoviesScreen> createState() => _TopMoviesScreenState();
}

class _TopMoviesScreenState extends State<TopMoviesScreen> {
  List<Movie> values = [];

  _TopMoviesScreenState() : super() {
    getMoves();
  }

  Future<void> getMoves() async {
    print("list 0");
    var temp = await database.movies();
    print("list 1");
    setState(() {
      values = temp;
    });
    print("list 2");
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: Text(
        "header",
      ),
      columnSpacing: 8,
      rowsPerPage: 4,
        dataRowHeight: kMinInteractiveDimension * 1.4,
      // onRowsPerPageChanged: (value) {
      //   setState(() {
      //     _rowsPerPage.value = value!;
      //   });
      // },
      // initialFirstRowIndex: _rowIndex.value,
      // onPageChanged: (rowIndex) {
      //   setState(() {
      //     _rowIndex.value = rowIndex;
      //   });
      // },
      columns: [
        DataColumn(
          label: Text("place"),
          // numeric: true,
        ),
        // DataColumn(
        //   label: Text(""),
        //   numeric: true,
        // ),
        DataColumn(
          label: Text("title"),
        ),
      ],
      source: MySource(values),
    );
  }
}

class MySource extends DataTableSource {
  List<Movie> values;

  MySource(this.values) : super();

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Row(children: [
          Text(
            '$index',
          ),
          Padding(padding: EdgeInsets.only(left: 16)),
          Container(
            width: 100,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.center,
              image: NetworkImage('https://i.stack.imgur.com/lkd0a.png'),
            )),
          ),
        ]),
      ),
      DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(
          values[index].title,
          maxLines: 3,
        ),
        Text(
          values[index].release.toString(),
        ),
      ])),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => values.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class Person {
  final int id;
  final String name;

  const Person({
    required this.id,
    required this.name,
  });
}
