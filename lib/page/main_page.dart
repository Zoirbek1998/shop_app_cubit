import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_cubit/const.dart';
import 'package:shop_app_cubit/page/explore_page.dart';
import 'package:shop_app_cubit/providers/page_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageProvider pageProvider = PageProvider();

  @override
  void didChangeDependencies() {
    pageProvider = BlocProvider.of<PageProvider>(context);
    super.didChangeDependencies();
  }

  Widget body() {
    switch (pageProvider.state) {
      case 0:
        return const Center(
            child: Text("Home",
                style: TextStyle(color: Colors.black, fontSize: 32)));
      case 1:
        return const ExplorePage();
      case 2:
        return const Center(
            child: Text("Soved",
                style: TextStyle(color: Colors.black, fontSize: 32)));
      case 3:
        return const Center(
            child: Text("Menu",
                style: TextStyle(color: Colors.black, fontSize: 32)));
      default:
        return const Center(
            child: Text("Home",
                style: TextStyle(color: Colors.black, fontSize: 32)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageProvider, int>(
      bloc: pageProvider,
      builder: (context, state) {
        return Scaffold(
          body: body(),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                color: white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset.zero,
                      blurRadius: 1,
                      spreadRadius: 1)
                ]),
            child: BottomNavigationBar(
                elevation: 0,
                onTap: (value) {
                  pageProvider.setCurrentPage(value);
                },
                currentIndex: state,
                unselectedItemColor: black.withOpacity(0.2),
                selectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.explore_outlined), label: "Explore"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_outline), label: "Soved"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Menu"),
                ]),
          ),
        );
      },
    );
  }
}
