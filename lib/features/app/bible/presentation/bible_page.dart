// class BibleHomePage extends StatelessWidget {
//   final BibleRepository repository = BibleRepository();

//   BibleHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2E1A47),
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: const Color(0xFF2E1A47),
//         title: const Text('Livros da Bíblia',
//             style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<String>>(
//         future: repository.getBooks(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//                 child: CircularProgressIndicator(color: Color(0xFFC99058)));
//           } else if (snapshot.hasError) {
//             return Center(
//                 child: Text('Erro: ${snapshot.error}',
//                     style: const TextStyle(color: Colors.white)));
//           } else if (snapshot.hasData) {
//             final books = snapshot.data!;
//             return ListView.builder(
//               itemCount: books.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(books[index],
//                       style: const TextStyle(color: Colors.white)),
//                   trailing: const Icon(Icons.arrow_forward_ios,
//                       color: Color(0xFFC99058)),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChapterPage(book: books[index]),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xFFC99058),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const SearchVersePage()),
//         ),
//         child: const Icon(Icons.search, color: Colors.white),
//       ),
//     );
//   }
// }
