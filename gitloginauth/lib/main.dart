import 'package:flutter/material.dart';
import 'package:gitloginauth/github_oauth_credentials.dart';
import 'package:gitloginauth/src/github_login.dart';
import 'package:github/github.dart';
import 'src/github_summary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Client',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Github Client'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return GithubLoginWidget(
        builder: (context, httpClient) {
          // WindowToFront.activate();
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              elevation: 2,
            ),
            body: GitHubSummary(
                gitHub: _getGitHub(httpClient.credentials.accessToken)),
          );
        },
        githubClientId: githubClientId,
        githubClientSecret: githubClientSecret,
        githubScopes: githubScopes);
  }

  Future<CurrentUser> viewerDetail(String accessToken) async {
    final github = GitHub(auth: Authentication.withToken(accessToken));
    return github.users.getCurrentUser();
  }
}

GitHub _getGitHub(String accessToken) {
  return GitHub(auth: Authentication.withToken(accessToken));
}
