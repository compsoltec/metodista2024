import 'package:flutter/material.dart';

import '../components/fadeAnimation.dart';

class TestemunhoDetalhes extends StatefulWidget {
  String imagem, texto, nome, data;
  TestemunhoDetalhes(
      {super.key,
      required this.imagem,
      required this.texto,
      required this.nome,
      required this.data});

  @override
  State<TestemunhoDetalhes> createState() => _TestemunhoDetalhesState();
}

class _TestemunhoDetalhesState extends State<TestemunhoDetalhes> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          makePage(
              page: 1,
              image: NetworkImage(widget.imagem),
              title: widget.data,
              description: widget.texto),
        ],
      ),
    );
  }

  Widget makePage({image, title, description, page}) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(widget.imagem),
        fit: BoxFit.cover,
      )),
      child: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(begin: Alignment.bottomRight, stops: const [
          0.3,
          0.9
        ], colors: [
          Colors.black.withOpacity(.9),
          Colors.black.withOpacity(.6),
        ])),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 100,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            1,
                            Text(
                              widget.nome,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  height: 1.2,
                                  fontWeight: FontWeight.bold),
                            )),
                        FadeAnimation(
                            1,
                            Text(widget.data,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  height: 1.2,
                                ))),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          child: FadeAnimation(
                              2,
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: Text(
                                  widget.texto,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7),
                                      height: 1.9,
                                      fontSize: 15),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
