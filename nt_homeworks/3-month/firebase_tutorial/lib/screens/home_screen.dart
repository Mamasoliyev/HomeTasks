import 'dart:developer';

import 'package:firebase_tutorial/services/auth_service.dart';
import 'package:firebase_tutorial/services/book_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  AuthService authService = AuthService();
  BookService bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await authService.logOut();
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bookService.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final book = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(book['title']),
                  subtitle: Text(book['author']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await bookService.updateBook(book.id, "reading");
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          await bookService.deleteBook(book.id);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: Text("no BOOKS"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await bookService.addBook(
            title: "Alchemes",
            author: "Paul",
            pages: 208,
            status: "not_started",
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
